#!/usr/bin/env bash

set -e

base="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -ne 1 ]]; then
    echo "You must set a version number"
    echo "./deploy.sh <terraform version>"
    exit 1
fi

version=$1
dockerfile_version=$(grep TERRAFORM_VERSION= ${base}/Dockerfile-light | cut -d= -f2)

if [[ $version != $dockerfile_version ]]; then
    echo "Version mismatch in 'Dockerfile-light'"
    echo "found ${dockerfile_version}, expected ${version}."
    echo "Make sure the versions are correct."
    exit 1
fi

echo "Building docker images for terraform ${version}..."
docker build -f "${base}/Dockerfile-full" -t hashicorp/terraform:full .
docker build -f "${base}/Dockerfile-light" -t hashicorp/terraform:light .
docker tag hashicorp/terraform:light hashicorp/terraform:${version}
docker tag hashicorp/terraform:light hashicorp/terraform:latest

echo "Uploading docker images for terraform ${version}..."
docker push hashicorp/terraform:${version}
docker push hashicorp/terraform:latest
docker push hashicorp/terraform:light
docker push hashicorp/terraform:full
