# syntax=docker/dockerfile:1.7
FROM ubuntu:24.04

# Pre-install fish, TLS roots, and sudo. Archive tools (and 7zz) are
# installed below by tests/install-dependencies.sh, so the Linux apt
# list lives in exactly one place.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        fish \
        sudo && \
    rm -rf /var/lib/apt/lists/*

COPY tests/install-dependencies.sh /tmp/install-dependencies.sh
RUN bash /tmp/install-dependencies.sh && rm /tmp/install-dependencies.sh

# Install fishtape system-wide (vendor_functions.d is auto-loaded by fish for all users).
ARG FISHTAPE_VERSION=3.0.1
RUN wget -O /tmp/fishtape.tar.gz "https://github.com/jorgebucaran/fishtape/archive/refs/tags/${FISHTAPE_VERSION}.tar.gz" && \
    tar xf /tmp/fishtape.tar.gz -C /tmp && \
    cp /tmp/fishtape-*/functions/fishtape.fish /usr/share/fish/vendor_functions.d/ && \
    rm -rf /tmp/fishtape.tar.gz /tmp/fishtape-*

WORKDIR /workspace
ENTRYPOINT ["fish"]
