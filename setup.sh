#!/bin/bash

cd "$(dirname "$0")"
cd ./

set -eu

npm init -y
npm install http-server --save-dev