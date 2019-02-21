#!/bin/bash
set -euxo pipefail

cd /tmp
git clone https://github.com/deadsnakes/python3.7.git
cd python3.7/
dch --local ~ocf --distribution stretch-backports 'Backported by OCF for stretch.'
dpkg-buildpackage -us -uc -sa -b
cd ..
cp *.tar.gz *.tar.bz2 *.debian.tar.xz *.dsc *.changes *.deb /mnt || true  # don't fail if we can't find some of these
