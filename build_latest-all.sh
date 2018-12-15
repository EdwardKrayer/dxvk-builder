#!/bin/bash

# Build latest
docker build --no-cache --tag=dxvk/dxvk-builder:latest - < Dockerfile.latest
mkdir -p ~/dxvk-build/latest
export DXVK_DIR=~/dxvk-build/latest
docker run --volume=$DXVK_DIR:/root/bin/ --tty dxvk/dxvk-builder:latest

# Build latest with async modification
docker build --no-cache --tag=dxvk/dxvk-builder:latest-async - < Dockerfile.latest-async
mkdir -p ~/dxvk-build/latest-async
export DXVK_DIR=~/dxvk-build/latest-async
docker run --volume=$DXVK_DIR:/root/bin/ --tty dxvk/dxvk-builder:latest-async