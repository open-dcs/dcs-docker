FROM debian:latest
MAINTAINER Geoff Johnson <geoff.jay@gmail.com>

# Update and install core packages
RUN apt-get update && apt-get upgrade
RUN apt-get install -y \
    automake \
    build-essential \
    git \
    intltool

# Install dependencies
RUN apt-get install -y \
    libglib2.0-dev \
    libgirepository1.0-dev \
    libgsl0-dev \
    libxml2-dev \
    python-gobject-dev

# Install OpenDCS console applications
# TODO write a pkgbuild?
RUN git clone https://github.com/open-dcs/dcs.git
WORKDIR dcs
RUN git checkout develop
RUN ./autogen.sh \
    --disable-ui \
    --disable-webkit \
    --disable-python-plugin \
    --disable-vala-plugin
