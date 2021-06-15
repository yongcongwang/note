#!/bin/bash
# By yongcong.wang @ 24/11/2019

set -x
set -e  # exit if err

# vars
ROOT_DIR=$(cd $(dirname $0); pwd)

# src filse
cd ${ROOT_DIR}
git status
git add .
git commit -m "update posts"
git push origin master

# publish
mkdocs gh-deploy --force
