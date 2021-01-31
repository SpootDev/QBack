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

import os
import re
import subprocess
from threading import Thread

from common import common_logging_elasticsearch_httpx


class PingIt(Thread):
    """
    # ping modules
    """

    def __init__(self, ip_addr):
        Thread.__init__(self)
        self.ip_addr = ip_addr
        self.status = -1

    def run(self):
        """
        run the pings
        """
        pingaling = None
        # if str.upper(sys.platform[0:3]) == 'WIN' or str.upper(sys.platform[0:3]) == 'CYG':
        #     pingaling = os.popen("ping -n 2 " + self.ip_addr, "r")
        # else:
        pingaling = os.popen("ping -q -c2 " + self.ip_addr, "r")
        while 1:
            line = pingaling.readline()
            if not line:
                break
            igot = re.findall(PingIt.lifeline, line)
            if igot:
                self.status = int(igot[0])


def mk_network_ping_list(host_list):
    """
    Ping host list
    """
    PingIt.lifeline = re.compile(r"(\d) received")
    report = ("No response", "Partial Response", "Alive")
    pinglist = []
    for host in host_list:
        current = PingIt(host)
        pinglist.append(current)
        current.start()
    for pingle in pinglist:
        pingle.join()
        common_logging_elasticsearch_httpx.com_es_httpx_post(message_type='info',
                                                             message_text={"Status from":
                                                                               pingle.ip_addr,
                                                                           'report': report[
                                                                               pingle.status]})


def mk_network_service_available(host_dns, host_port, wait_seconds='120'):
    if os.path.exists('/qback/wait-for-it-ash-busybox130.sh'):
        wait_pid = subprocess.Popen(
            ['/qback/wait-for-it-ash-busybox130.sh', '-h', host_dns, '-p', host_port,
             '-t', wait_seconds], stdout=subprocess.PIPE, shell=False)
    elif os.path.exists('/qback/wait-for-it-ash.sh'):
        wait_pid = subprocess.Popen(
            ['/qback/wait-for-it-ash.sh', '-h', host_dns, '-p', host_port,
             '-t', wait_seconds], stdout=subprocess.PIPE, shell=False)
    else:
        wait_pid = subprocess.Popen(
            ['/qback/wait-for-it-bash.sh', '-h', host_dns, '-p', host_port,
             '-t', wait_seconds], stdout=subprocess.PIPE, shell=False)
    wait_pid.wait()
