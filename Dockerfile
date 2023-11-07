# "Latest LTS"
FROM ubuntu:22.04

# renovate: datasource=pypi depName=meson
ENV MESON_VERSION=1.2.3

RUN env DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    env DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    env DEBIAN_FRONTEND=noninteraceive apt-get install --no-install-recommends -y \
        build-essential \
        cmake \
        doxygen \
        fuse \
        gcc-9 g++-9 \
        git \
        libboost-all-dev \
        libglib2.0-dev \
        libmad0-dev libid3tag0-dev \
        ninja-build \
        pkg-config \
        python3 python3-pip python3-setuptools python3-wheel \
        valgrind \
        wget \
        xz-utils && \
    apt-get autoremove -y && \
    apt-get clean && \
    pip3 install \
        meson==${MESON_VERSION}

# Install helpers

COPY /scripts/* /opt/helpers/

# Install Go

# renovate: datasource=github-tags depName=golang/go
ENV GO_VERSION=go1.21.4
RUN /opt/helpers/install_go.sh ${GO_VERSION}

# Install our static test helpers

COPY /static/tracks/*.mp3 /music/
COPY /static/mpd.conf /conf

# Copy the golden MP3 to its new location and legacy music.huge location.
COPY /static/gold.mp3 /static/gold.mp3
COPY /static/gold.mp3 /music.huge/gold.mp3

# Users of this image should replace this command. Return a non-zero
# exit code if they don't.
CMD ["/bin/false"]
