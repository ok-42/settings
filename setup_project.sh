#!/bin/bash
cp -r "$MY_SETTINGS_PATH"/project/. .
python -m venv venv
mkdir src
touch src/__init__.py
touch requirements.txt
git init
