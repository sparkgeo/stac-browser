#!/bin/sh

DOCKER_REPO=cuttlefish/stac-browser
GIT_HASH=`git rev-parse --short HEAD`
BUILDER=enexus-builder

if ! docker buildx use $BUILDER ; then
  docker buildx create --name $BUILDER --use
fi
docker buildx build --platform=linux/amd64,linux/arm64 -t $DOCKER_REPO:$GIT_HASH --build-arg="pathPrefix=/stacbrowser/" . --push
echo "Built ${DOCKER_REPO}:${GIT_HASH}"
