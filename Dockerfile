FROM public.ecr.aws/docker/library/debian:stable-20240904

RUN apt-get update
RUN apt-get install -y \
    curl \
    git \
    build-essential \
    python3 \
    libsdl2-dev \
    libsdl2-ttf-dev \
    libfontconfig-dev \
    libpulse-dev \
    qtbase5-dev \
    qtbase5-dev-tools \
    qtchooser \
    qt5-qmake

ARG MAME_VERSION=0.269
ARG MAME_TARBALL_SHA256=05df2e82ff1d157282a5a667a67aa6eb331c55a64138afad0e8ac223553088ca

RUN mkdir "/root/mame-source" \
 && cd "/root/mame-source" \
 && curl -sSLfo "mame-${MAME_VERSION}.tar.gz" "https://github.com/mamedev/mame/archive/refs/tags/mame$(echo "${MAME_VERSION}" | tr --delete .).tar.gz" \
 && echo "${MAME_TARBALL_SHA256}  mame-${MAME_VERSION}.tar.gz" > mame-${MAME_VERSION}.tar.gz.sha256 \
 && sha256sum -c "mame-${MAME_VERSION}.tar.gz.sha256" \
 && rm mame-${MAME_VERSION}.tar.gz.sha256 \
 && tar -xzf mame-${MAME_VERSION}.tar.gz \
 && rm mame-${MAME_VERSION}.tar.gz
