#!/bin/bash
docker build --no-cache --tag=dxvk/dxvk-builder:latest-async - < Dockerfile.latest-async
mkdir -p ~/dxvk-build/latest-async
export DXVK_DIR=~/dxvk-build/latest-async
docker run --volume=$DXVK_DIR:/root/bin/ --tty dxvk/dxvk-builder:latest-async