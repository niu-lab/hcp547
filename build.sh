#!/usr/bin/env bash
set -e

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

# build image
echo "build hcp547 v${VERSION} image ..."
docker build -t "hcp547:${VERSION}" .
