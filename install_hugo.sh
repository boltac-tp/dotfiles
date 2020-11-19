#! bin/bash

wget https://github.com/gohugoio/hugo/releases/download/v0.78.2/hugo_extended_0.78.2_Linux-64bit.deb
sudo apt install ./hugo_extended_0.78.2_Linux-64bit.deb

cd
mkdir site
cd site

git clone --recursive git@github.com:boltac-tp/boltac.git
git clone --recursive git@github.com:boltac-tp/debit.git
