#!/bin/bash

# latest ver 取得
GO_VER=$(git ls-remote https://github.com/golang/go | grep refs/tags | grep -oE "[0-9]\.[0-9]??[0-9]?\.[0-9]??[0-9]?" | sort --version-sort | tail -n 1)
NOW_VER=$(go version | grep -oE "[0-9]\.[0-9]??[0-9]?\.[0-9]??[0-9]?")
if [[ $GO_VER == "$NOW_VER" ]]; then
   echo "go already updated v$GO_VER"
   exit 1
fi

wget https://golang.org/dl/go"${GO_VER}".linux-amd64.tar.gz
if [ -d /usr/local/go ]; then
   sudo rm -rf /usr/local/go
fi
sudo tar -C /usr/local -xzf go"${GO_VER}".linux-amd64.tar.gz
rm go"${GO_VER}".linux-amd64.tar.gz
