#!/usr/bin/bash
VERSION=` git ls-remote https://github.com/gohugoio/hugo | grep refs/tags | grep -oE "[0-9]\.[0-9][0-9]+\.[0-9]" | sort --version-sort | tail -n 1`
NOW_VER=`hugo version | grep -oE "[0-9]\.[0-9][0-9]?\.[0-9][0-9]?"`
if [[ $VERSION == $NOW_VER ]]; then
   echo "hugo already updated v$VERSION"
   exit 1
fi
wget https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_Linux-64bit.deb
sudo dpkg -i ./hugo_extended_${VERSION}_Linux-64bit.deb
rm ./hugo_extended_${VERSION}_Linux-64bit.deb

