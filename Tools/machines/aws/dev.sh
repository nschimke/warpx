#!/usr/bin/env bash

docker buildx build \
    --secret id=credentials,src=credentials.sh \
    --tag warpx:dev \
    -f Containerfile \
    --progress=plain \
    --target=dev \
    .
