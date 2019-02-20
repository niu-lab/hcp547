#!/usr/bin/env bash
set -e

# build base image
BASE=`docker images | grep hcp547 | grep base | awk '{ print $3}'`
if [ ! ${IMG} ];then
echo "build hcp547 base image ..."
docker build -t "hcp547:base" ./docker/base
fi

VERSION=0.1
IMG=`docker images | grep hcp547 | grep ${VERSION} | awk '{ print $3}'`

if [ ${IMG} ];then
    echo "remove hcp v${VERSION} images"
    docker rmi ${IMG}
fi

# build gpyflow workflow
echo "build hcp547.gpyflow.dir.zip ..."
pyflow tar hcp547.gpyflow.dir
echo "build hcp547.gpyflow.dir.zip ok"
mv hcp547.gpyflow.dir.zip bin/

# build version image
echo "build hcp547 v${VERSION} image ..."
docker build -t "hcp547:${VERSION}" .
