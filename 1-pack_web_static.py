#!/usr/bin/env python3

from datetime import datetime
from fabric.api import *
import os

def do_pack():

    local('sudo mkdir -p versions')
    time = datetime.now()
    time_str = time.strftime("%Y%m%d%H%M%S")
    local('sudo tar -cvzf versions/web_static_time_str.tgz web_static')
    

