#!/usr/bin/bash

echo '\n install Python & utils \n \n'
# install python
sudo apt install -y python3-venv python3-pip
# install poetry
curl-sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python - 
poetry config virtualenvs.in-project=true
# install pyenv
sudo apt install -y libffi-dev libssl-dev libsqlite3-dev libbz2-dev libreadline-dev
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

