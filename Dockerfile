FROM docker.ocf.berkeley.edu/theocf/debian:stretch

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        # needed for cloning deadsnakes repo
        git \
        # Python 3.7 deps (found via dpkg-checkbuilddeps)
        sharutils \
        libreadline-dev \
        libncursesw5-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libgdbm-dev \
        libdb-dev \
        tk-dev \
        blt-dev \
        libssl-dev \
        libexpat1-dev \
        libmpdec-dev \
        libbluetooth-dev \
        libsqlite3-dev \
        libffi-dev \
        libgpm2 time \
        xvfb \
        python3-sphinx \
        texinfo \
        # needed for building the package
        packaging-dev \
        devscripts \
        # others?
        lsb-release \
        xauth

COPY package.sh /tmp

CMD ["/tmp/package.sh"]
