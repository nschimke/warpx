#!/usr/bin/env bash

docker run -i -t \
    --mount type=bind,src=../../..,dst=/opt/warpx \
    --mount type=bind,src=$HOME,dst=/home/$USER \
    --user $(id -u):$(id -g) \
    warpx/dev
