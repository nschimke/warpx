#!/usr/bin/env bash

set -eux

cd $(dirname $0)

source_root=$(git rev-parse --show-toplevel)
configuration_subpath=$(git rev-parse --show-prefix | sed -e 'sx/$xx')

cd "$source_root"
ln -sf "$configuration_subpath/Containerfile" .
ln -sf "$configuration_subpath/spack" .
mkdir -p .devcontainer
pushd .devcontainer
ln -sf "../$configuration_subpath/devcontainer.json" .
ln -sf "../$configuration_subpath/credentials.sh" .
popd

export spack_yaml="$configuration_subpath/spack-cuda.yaml"

docker buildx build \
    --secret id=credentials,src=.devcontainer/credentials.sh \
    --build-arg spack_yaml \
    --tag warpx:dev \
    -f Containerfile \
    --target=spack_base \
    --progress=plain \
    .
