#!/bin/bash
WINPATH="file:///$(wslpath -m ${1})"
/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe $WINPATH
