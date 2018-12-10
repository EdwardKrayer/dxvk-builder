# dxvk-builder

# Name:			dxvk-builder
# Docker Name:	dxvk/dxvk-builder
# Docker URL:	hub.docker.com/dxvk/dxvk-builder
# Github:		github.com/EdwardKrayer/dxvk-builder

Description:

	Docker image to build DXVK binaries from their latest source.

Usage Instructions:

	Execute the following to build DXVK binaries from source, the binaries will be placed in the "dxvk-latest" directory at the path specified by environmental variable DXVK_DIR at line 4.

		git clone https://github.com/EdwardKrayer/dxvk-builder.git
		cd dxvk-builder
		docker build --tag=$USER/dxvk-builder:latest - < Dockerfile
		export DXVK_DIR=~/
		docker run --volume=$DXVK_DIR:/root/bin/ --tty $USER/dxvk-builder:latest

	In this example, binaries will be placed at ~/dxvk-latest/ after all instructions completed.
