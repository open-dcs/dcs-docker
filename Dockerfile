FROM debian:latest
MAINTAINER Geoff Johnson <geoff.jay@gmail.com>

# Update and install core packages
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y \
        autoconf \
        autoconf-archive \
        automake \
        build-essential \
        docbook-xsl \
        gettext \
        git \
        gobject-introspection \
        libtool \
        intltool \
        valac

# Install dependencies
RUN apt-get install -y \
        libcomedi-dev \
        libglib2.0-dev \
        libgee-0.8-dev \
        libgirepository1.0-dev \
        libgsl0-dev \
        libjson-glib-dev \
        libmatheval-dev \
        libmodbus-dev \
        libpeas-dev \
        libreadline-dev \
        libsoup2.4-dev \
        libsqlite3-dev \
        libxml2-dev \
        libzmq3-dev \
        python-gobject-dev

# For now build libcld
RUN git clone https://github.com/geoffjay/libcld.git
WORKDIR libcld
RUN PKG_CONFIG_PATH=./deps/ ./autogen.sh && \
    make && \
    make install

# Install OpenDCS console applications
# TODO write a pkgbuild?
WORKDIR /
RUN git clone https://github.com/open-dcs/dcs.git
WORKDIR dcs
RUN git checkout develop * && \
    ./autogen.sh \
    --disable-ui \
    --disable-webkit \
    --disable-python-plugin \
    --disable-vala-plugin \
    --enable-coverage && \
    make && \
    make install
