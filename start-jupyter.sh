#!/usr/bin/env bash

# Script reference:
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html

IMAGE="jupyter/scipy-notebook:latest"
# 41e066e5caa8

CONTAINER_NAME="jupyter_minimal2"

NB_USERNAME="jovyan" # Changing this leads to errors... to be tested

HOST_WORK="/home/`id -u -n`/repos/"
CONTAINER_WORK="/home/$NB_USERNAME/repos"

MEP_DATA="/data/"
MEP_DATA_MOUNT="/data/"

# To generate an hashed password:
# >>> import IPython
# >>> IPython.lib.passwd()
HASHED_PASSWD="'sha1:67a75ab3faee:d920926ebf16df183c9cbbddbe15966d57989025'"  # vito

docker run -d \
  --name $CONTAINER_NAME \
  --restart always \
  -p 9999:8888 \
  -v $HOST_WORK:$CONTAINER_WORK \
  -v $MEP_DATA:$MEP_DATA_MOUNT \
  -e NB_UID=`id -u` \
  -e NB_GID=`id -g` \
  -e GRANT_SUDO=yes \
  -e JUPYTER_ENABLE_LAB=yes \
  --user root \
  $IMAGE start-notebook.sh \
  --NotebookApp.password=$HASHED_PASSWD
