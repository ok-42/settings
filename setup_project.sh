#!/bin/bash
cp -r "$MY_SETTINGS_PATH"/project/. .
mkdir src
touch src/__init__.py
touch requirements.txt
git init
