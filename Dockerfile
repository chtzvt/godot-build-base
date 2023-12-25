FROM ubuntu:23.04

RUN set -xe \
    && apt update && apt -y upgrade

RUN echo "America/New_York" > /etc/timezone 
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY . /base
WORKDIR "/base"

# Install base system dependencies
RUN set -xe \
    && bash deps/base-system.sh

# Install osxcross
RUN set -xe \
    && bash deps/osxcross.sh

# Install wine
RUN set -xe \
    && bash deps/wine.sh

# Install godot
RUN set -xe \
    && bash deps/godot.sh

# Install blender
RUN set -xe \
    && bash deps/blender.sh

# Install steam sdk
RUN set -xe \
    && bash deps/steam-sdk.sh
