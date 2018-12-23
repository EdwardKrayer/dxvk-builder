#!/bin/bash

# Build latest
docker build --no-cache --tag=dxvk/dxvk-builder:latest - < Dockerfile.latest
mkdir -p ~/dxvk-build/latest
export DXVK_DIR=~/dxvk-build/latest
docker run --volume=$DXVK_DIR:/root/bin/ --tty dxvk/dxvk-builder:latest