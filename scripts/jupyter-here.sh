#!/bin/bash

# run jupyter as the current user, using the current directory as the working dir

# TODO: make some parameters optional
if [ $# -ne 3 ]
then
    echo "usage: jupyter-here.sh image-shortname hostname port"
    exit 1
fi

IMAGE_SHORTNAME=$1
HOSTNAME="$2"
PORT=$3

docker run \
    -e NOTEBOOK_UID=$(id -u) \
    -e NOTEBOOK_GID=$(id -g) \
    -w $(pwd) \
    -v $(pwd):$(pwd) \
    -p $PORT:$PORT \
    -h $HOSTNAME \
    midvalestudent/jupyter-$IMAGE_SHORTNAME:latest \
    start-notebook.sh --ip=$HOSTNAME --port=$PORT
