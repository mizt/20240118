#!/bin/bash

cd "$(dirname "$0")"

set -eu

npm init -y
npm install http-server --save-dev