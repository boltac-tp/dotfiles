#!/usr/bin/python

import atexit
import readline
import os

# save history file as ~/.cache/.python_history

histfile = os.path.join(os.path.expanduser("~/.cache"), ".python_history")

try:
    readline.read_history_file(histfile)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
