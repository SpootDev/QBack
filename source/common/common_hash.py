"""
  Copyright (C) 2015 Quinn D Granfor <spootdev@gmail.com>

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  version 2, as published by the Free Software Foundation.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License version 2 for more details.

  You should have received a copy of the GNU General Public License
  version 2 along with this program; if not, write to the Free
  Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  MA 02110-1301, USA.
"""

import base64
import hashlib
import os
import struct
import zipfile
import zlib
from functools import reduce

from cryptography.fernet import Fernet
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

from . import common_file


class CommonHashCrypto:
    """
    Class for interfacing with crypto
    """

    def __init__(self):
        if not os.path.isfile('/mediakraken/secure/data.zip'):
            salt = os.urandom(30)
            common_file.com_file_save_data(file_name='/mediakraken/secure/data.zip',
                                           data_block=salt,
                                           as_pickle=True)
        else:
            salt = common_file.com_file_load_data(file_name='/mediakraken/secure/data.zip',
                                                  as_pickle=True)
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
            backend=default_backend()
        )
        if 'SECURE' in os.environ:  # docker compose
            self.hash_key = base64.urlsafe_b64encode(
                kdf.derive(os.environ['SECURE'].encode('utf-8')))
        else:  # docker swarm
            self.hash_key = base64.urlsafe_b64encode(
                kdf.derive(common_file.com_file_load_data('/run/secrets/secure_key')))
        self.fernet = Fernet(self.hash_key)

    def com_hash_gen_crypt_encode(self, encode_string):
        # encode, since it needs bytes
        return self.fernet.encrypt(encode_string.encode())

    def com_hash_gen_crypt_decode(self, decode_string):
        # encode, since it needs bytes
        return self.fernet.decrypt(decode_string.encode())


def com_hash_sha1_by_filename(file_name, enter_archive=False):
    """
    Calculate sha1 for file
    """
    if enter_archive is False:
        sha1 = hashlib.sha1()
        with open(file_name, 'rb') as file_handle:
            for chunk in iter(lambda: file_handle.read(8192), b''):
                sha1.update(chunk)
        file_handle.close()
        return sha1.digest()  # TODO or do I need to use hexdigest
    else:
        # get without the dot
        file_extention = os.path.splitext(file_name)[1][1:].strip().lower()
        if file_extention == 'zip':
            zip_handle = zipfile.ZipFile(file_name, 'r')  # issues if u do RB
            hash_dict = {}
            for zippedfile in zip_handle.namelist():
                try:
                    # calculate sha1 hash
                    SHA1 = hashlib.sha1()  # "reset" the sha1 to blank
                    SHA1.update(zip_handle.read(zippedfile))
                    sha1_hash_data = SHA1.hexdigest()
                    hash_dict[zippedfile] = sha1_hash_data
                except:
                    pass
            zip_handle.close()
            return hash_dict
        elif file_name.endswith('7z'):
            try:
                file_handle = open(file_name, 'rb')
                archive = Archive7z(file_handle)
                filenames = archive.getnames()
                hash_dict = {}
                for filename in filenames:
                    cf = archive.getmember(filename)
                    try:
                        # calculate sha1 hash
                        SHA1 = hashlib.sha1()  # "reset" the sha1 to blank
                        SHA1.update(cf.read())
                        sha1_hash_data = SHA1.hexdigest()
                        hash_dict[filename] = sha1_hash_data
                    except:
                        pass
                file_handle.close()
                return hash_dict
            except:
                pass
