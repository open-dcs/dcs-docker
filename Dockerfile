FROM debian:latest
MAINTAINER Geoff Johnson <geoff.jay@gmail.com>

RUN apt-get update && apt-get upgrade
RUN apt-get install -y \
    aclocal \
    automake \
    build-essential \
    git

# Install OpenDCS console applications
# TODO write a pkgbuild?
RUN git clone https://github.com/open-dcs/dcs.git
WORKDIR dcs
RUN ./autogen.sh --disable-ui --disable-webkit \
        --disable-python-plugin --disable-vala-plugin
