FROM ubuntu:latest

ENV MESON_VERSION 0.54.0

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        build-essential \
        cmake \
        doxygen \
        git \
        libboost-all-dev \
        libmad0-dev libid3tag0-dev \
        ninja-build \
        pkg-config \
        python3 python3-pip python3-setuptools python3-wheel \
        wget \
        xz-utils && \
    apt-get autoremove -y && \
    apt-get clean && \
    pip3 install \
        meson==${MESON_VERSION}

# Install helpers

COPY /scripts/* /opt/helpers/

# Install Go

ENV GO_VERSION 1.13
RUN /opt/helpers/install_go.sh ${GO_VERSION}

# Generate the "huge" music library

RUN /opt/helpers/generate_music.huge.sh

# Install our static test helpers

COPY /static/tracks/*.mp3 /music/
COPY /static/mpd.conf /conf

# Users of this image should replace this command. Return a non-zero
# exit code if they don't.
CMD ["/bin/false"]
