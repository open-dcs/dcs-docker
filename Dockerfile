FROM debian:latest
MAINTAINER Geoff Johnson <geoff.jay@gmail.com>

# Update and install core packages
RUN apt-get update && apt-get upgrade
RUN apt-get install -y \
    autoconf \
    autoconf-archive \
    automake \
    build-essential \
    gettext \
    git \
    gobject-introspection \
    libtool \
    intltool

# Install dependencies
RUN apt-get install -y \
    libglib2.0-dev \
    libgee-0.8-dev \
    libgirepository1.0-dev \
    libgsl0-dev \
    libpeas-dev \
    libreadline-dev \
    libsoup2.4-dev \
    libxml2-dev \
    libzmq3-dev \
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
