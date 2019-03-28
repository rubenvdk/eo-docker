#!/usr/bin/env bash

# Script reference:
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html

IMAGE="redblanket/eojup:latest"

CONTAINER_NAME="eojupy_minio"

NB_USERNAME="jovyan" # Changing this leads to errors... to be tested

HOST_WORK="/home/`id -u -n`/repos/"
CONTAINER_WORK="/home/$NB_USERNAME/repos"

DATA="/data/"
DATA_MOUNT="/data/"

## Local
# DATA="/c/Users/ZANAGAD/Downloads"
# DATA_MOUNT="/home/$NB_USERNAME/Downloads"


JUPYTER_TOKEN="d920926ebf16df183c9cbbddbe15966d5798902567a75ab3"
# "c8de56fa4deed24899803e93c227592aef6538f93025fe01"
# To generate an hashed password:
# >>> import IPython
# >>> IPython.lib.passwd()
# HASHED_PASSWD="'sha1:67a75ab3faee:d920926ebf16df183c9cbbddbe15966d57989025'"  # vito

docker run -d \
  --restart always \
  --name $CONTAINER_NAME \
  -p 9999:8888 \
  -p 9000:9000 \
  -v ${DATA}:${DATA_MOUNT} \
  -v ${HOST_WORK}:${CONTAINER_WORK} \
  -e NB_UID=`id -u` \
  -e NB_GID=`id -g` \
  -e GRANT_SUDO=yes \
  -e JUPYTER_TOKEN=${JUPYTER_TOKEN} \
  -e JUPYTER_ENABLE_LAB=yes \
  --user root \
  $IMAGE start-notebook.sh
