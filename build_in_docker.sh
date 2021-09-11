#!/bin/bash

set -eu -o pipefail

DOCKER_IMAGE=android_build

docker build -t ${DOCKER_IMAGE} .

docker run \
  --rm \
  -t \
  -v "$(pwd)":/repo \
  -w /repo \
  ${DOCKER_IMAGE} \
  /bin/bash -c "./gradlew assemble"
