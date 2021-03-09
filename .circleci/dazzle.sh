#!/bin/sh
set -xe

if [[ -z $DOCKER_USER ]]; then
  echo "DOCKER_USER is mandatory"
  exit 2
fi

DOCKERFILE=`basename $1`
IMAGE_NAME=$2
TAR_FILENAME=$PWD/$3
BUILD_TAG="build-branch-$(echo $CIRCLE_BRANCH | sed 's_/_-_g')"

# Log in to Docker Hub.
# Use heredoc to avoid variable getting exposed in trace output.
# Use << (<<< herestring is not available in busybox ash).
# We'll be pushing images using docker.io/gitpod thus must login accordingly
docker login -u $DOCKER_USER --password-stdin docker.io << EOF
$DOCKER_PASS
EOF

sudo dazzle -v $*
