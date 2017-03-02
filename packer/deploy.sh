#!/usr/bin/env bash

set -e

base="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -ne 1 ]]; then
    echo "You must set a version number"
    echo "./deploy.sh <packer version>"
    exit 1
fi

version=$1
dockerfile_version=$(grep PACKER_VERSION= ${base}/Dockerfile-light | cut -d= -f2)

if [[ $version != $dockerfile_version ]]; then
    echo "Version mismatch in 'Dockerfile-light'"
    echo "found ${dockerfile_version}, expected ${version}."
    echo "Make sure the versions are correct."
    exit 1
fi

echo "Building docker images for packer ${version}..."
docker build -f "${base}/Dockerfile-full" -t hashicorp/packer:full .
docker build -f "${base}/Dockerfile-light" -t hashicorp/packer:light .
docker tag hashicorp/packer:light hashicorp/packer:${version}
docker tag hashicorp/packer:light hashicorp/packer:latest

echo "Uploading docker images for packer ${version}..."
docker push hashicorp/packer:${version}
docker push hashicorp/packer:latest
docker push hashicorp/packer:light
docker push hashicorp/packer:full
