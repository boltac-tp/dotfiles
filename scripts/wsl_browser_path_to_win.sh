#!/bin/bash
if [[ ${1} == //* ]]; then
    WINPATH="file:///$(wslpath -m ${1})"
else
    WINPATH="${1}"
fi
/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe $WINPATH
