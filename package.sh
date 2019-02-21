#!/bin/bash
set -euxo pipefail

cd /tmp
#  _    _                 _                _                                 
# | |  | |               | |              | |                                
# | |__| | ___ _ __ ___  | |__   ___    __| |_ __ __ _  __ _  ___  _ __  ___ 
# |  __  |/ _ \ '__/ _ \ | '_ \ / _ \  / _` | '__/ _` |/ _` |/ _ \| '_ \/ __|
# | |  | |  __/ | |  __/ | |_) |  __/ | (_| | | | (_| | (_| | (_) | | | \__ \
# |_|  |_|\___|_|  \___| |_.__/ \___|  \__,_|_|  \__,_|\__, |\___/|_| |_|___/
#                                                       __/ |                
#                                                      |___/                 
# The following is a massive hack so we can read the latest package version fromt the buster repos
# It is very dangerous to do this on a real system, only run it on a container!
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo 'deb http://httpredir.debian.org/debian buster main' | tee -a /etc/apt/sources.list
apt update
VERSION="$(apt-cache policy python3.7 | awk '/Candidate: / {print $2}')"
mv /etc/apt/sources.list.bak /etc/apt/sources.list
apt update
# end dragons
dget -x http://deb.debian.org/debian/pool/main/p/python3.7/python3.7_$VERSION.dsc
cd /tmp/python3.7_$VERSION
dch --local ~ocf --distribution stretch-backports 'Backported by OCF for stretch.'
dpkg-buildpackage -us -uc -sa