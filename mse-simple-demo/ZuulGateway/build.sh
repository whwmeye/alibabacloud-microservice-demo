#!/bin/sh

export REGISTRY=${REGISTRY}

export appName=spring-cloud-zuul
export version=3.0.1

set -e

cd "$(dirname "$0")"

docker build --platform linux/amd64 . -t ${REGISTRY}${appName}:${version}

if [ -n "${REGISTRY}" ]; then
    docker push ${REGISTRY}${appName}:${version}
fi
