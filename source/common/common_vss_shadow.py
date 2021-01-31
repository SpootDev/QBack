"""
  Copyright (C) 2021 Quinn D Granfor <spootdev@gmail.com>

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  version 3, as published by the Free Software Foundation.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License version 2 for more details.

  You should have received a copy of the GNU General Public License
  version 3 along with this program; if not, write to the Free
  Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  MA 02110-1301, USA.
"""

import vss


class CommonVSSShadow:
    """
    Class for interfacing with crypto
    """

    def __init__(self, local_drive_list):
        # Create a set that contains the LOCAL disks you want to shadow
        local_drives = set()
        for drive in local_drive_list:
            local_drives.add(drive)
        # Initialize the Shadow Copies
        self.sc = vss.ShadowCopy(local_drives)

    def close(self):
        # When done, clean up the shadow copies
        self.sc.delete()


# # An open and locked file we want to read
# locked_file = r'C:\foo\bar.txt'
# shadow_path = sc.shadow_path(locked_file)
#
# # shadow_path will look similar to:
# # u'\\\\?\\GLOBALROOT\\Device\\HarddiskVolumeShadowCopy7\\foo\\bar.txt'

# # Open shadow_path just like a regular file
# with open(shadow_path, 'rb') as fp:
#     data = fp.read()

test_shadow = CommonVSSShadow(('D'))
test_shadow.close()
