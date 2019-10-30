FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    zlib1g-dev \
    libtool-bin \
    zip \
    texinfo \
    cpio \
    autoconf \
    automake \
    flex \
    bison \
  && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/lib/x86_64-linux-gnu/libgmp.so.10.3.2 /usr/lib/x86_64-linux-gnu/libgmp.so.3 && \
    ln -s /usr/lib/x86_64-linux-gnu/libmpfr.so.6 /usr/lib/x86_64-linux-gnu/libmpfr.so.1 && \
    rm /bin/sh && \
    cp /bin/bash /bin/sh

WORKDIR /tmp

CMD export DIST_DIR="`ls -1 | grep .tar.bz2 | sed -e s/\.tar\.bz2//`" && \
    tar xjvf "${DIST_DIR}.tar.bz2" && \
    cd "${DIST_DIR}" && \
    make && \
    cd "/build-image" && \
    export PATH=/opt/m68k-uclinux/bin:$PATH && \
    echo "${DIST_DIR:0:-5}" && \
    tar xjfv "/opt/${DIST_DIR:0:-5}.tar.bz2" && \
    cd "${DIST_DIR:0:-5}" && \
    make "Behnke/MCF53281-32E64-Rev2.4_default" && \
    echo "Done."

