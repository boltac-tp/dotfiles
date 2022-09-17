#!/bin/bash

# latest ver 取得
LAST_VER=$(git ls-remote https://github.com/golang/go | grep refs/tags | grep -oE "[0-9]\.[0-9]??[0-9]?\.[0-9]??[0-9]?" | sort --version-sort | tail -n 1)

if [[ -d /usr/local/go ]]; then
    CURRENT_VER=$(go version | grep -oE "[0-9]\.[0-9]??[0-9]?\.[0-9]??[0-9]?")

    if [[ $LAST_VER == "$CURRENT_VER" ]]; then
        echo "go already updated v$LAST_VER"
        exit 1
    fi
    sudo rm -rf /usr/local/go
fi

curl -L https://go.dev/dl/go"${LAST_VER}".linux-amd64.tar.gz | sudo tar xzf - -C /usr/local
echo "go already installed v$LAST_VER"

