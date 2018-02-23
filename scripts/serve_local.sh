#!/usr/bin/env bash

set -e -o pipefail

cd `dirname $0`/..

if [[ "$1" == "--dev" && -e _config_dev.yml ]]; then
  CONFIG="--config _config.yml,_config_dev.yml"
  shift;
fi

SERVE_CMD='gulp serve'
if [[ "$1" == "--no-sync" ]]; then
  SERVE_CMD=superstatic
fi

bundle exec jekyll build $CONFIG --incremental --watch &
j_pid=$!
$SERVE_CMD --port 4001 &
f_pid=$!
echo "cached PIDs: $j_pid, $f_pid"
trap "{ kill $j_pid; kill $f_pid; exit 0;}" SIGINT
wait
