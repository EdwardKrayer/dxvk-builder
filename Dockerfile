	# hub.docker.com/dxvk/dxvk-builder
	# dxvk/dxvk-builder

FROM ubuntu:18.04

	# [ init ]

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y

	# [ winehq-staging ]

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y software-properties-common wget
RUN wget -qO - https://dl.winehq.org/wine-builds/Release.key | apt-key add -
RUN apt-add-repository -y https://dl.winehq.org/wine-builds/ubuntu/
RUN apt-get update
RUN apt-get install -y --install-recommends winehq-staging
RUN apt-get install -y winetricks

	# [ glslang ]

RUN apt-get install -y build-essential git cmake automake
RUN git clone https://github.com/KhronosGroup/glslang.git ./src/glslang/
RUN mkdir ./src/glslang/build && cd ./src/glslang/build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release && make && make install DESTDIR="/"

	# [ mingw-w64 ]

RUN add-apt-repository -y ppa:mati865/mingw-w64
RUN apt-get update
RUN apt-get install -y mingw-w64

	# [ mingw-w64 - configuration]

RUN update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix
RUN update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix
RUN update-alternatives --set i686-w64-mingw32-gcc /usr/bin/i686-w64-mingw32-gcc-posix
RUN update-alternatives --set i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-posix

	# [ lunarg-vulkan-sdk ]

RUN wget -qO - http://packages.lunarg.com/lunarg-signing-key-pub.asc | apt-key add -
RUN wget -qO /etc/apt/sources.list.d/lunarg-vulkan-bionic.list http://packages.lunarg.com/vulkan/lunarg-vulkan-bionic.list
RUN apt-get update
RUN apt-get install -y lunarg-vulkan-sdk python3-distutils libvulkan1

	# [ dxvk ]

RUN apt-get install -y meson ninja-build
RUN git clone https://github.com/doitsujin/dxvk.git /root/src/dxvk/
ENTRYPOINT /root/src/dxvk/package-release.sh latest /root/bin/ --no-package