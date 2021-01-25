#!/usr/bin/bash
VERSION=0.78.2

wget https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_0.78.2_Linux-64bit.deb
sudo apt install ./hugo_extended_${VERSION}_Linux-64bit.deb
rm ./hugo_extended_${VERSION}_Linux-64bit.deb

if [ ! -d ~/site ]; then
  cd
  mkdir site
  cd site
  git clone --recursive git@github.com:boltac-tp/boltac.git
  git clone --recursive git@github.com:boltac-tp/debit.git
fi
