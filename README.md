# dxvk-builder

## Description:

Docker image to build DXVK binaries from their latest source.

## Usage Instructions:

You can use the included build.sh, which will ask you which Dockerfile to build, or you can execute the following to build DXVK binaries from source, the binaries will be placed in the "dxvk-latest" directory at the path specified by environmental variable DXVK_DIR at line 4. In this example, binaries will be placed at ~/dxvk-latest/ after all instructions completed.

```bash
git clone https://github.com/EdwardKrayer/dxvk-builder.git
cd dxvk-builder
docker build --tag=$USER/dxvk-builder:latest - < Dockerfile
export DXVK_DIR=~/
docker run --volume=$DXVK_DIR:/root/bin/ --tty $USER/dxvk-builder:latest
```
