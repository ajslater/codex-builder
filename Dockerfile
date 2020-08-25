ARG BASE_VERSION
FROM ubuntu:${BASE_VERSION}
ARG PKG_VERSION
LABEL version ${BASE_VERSION}_${PKG_VERSION}
ARG DEBIAN_FRONTEND=noninteractive

################
# SYSTEM SETUP #
################
RUN echo "*** install system build dependencies ***"
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
  gnupg2 \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*
COPY nodesource/nodesource.focal.list /etc/apt/sources.list.d/
COPY nodesource/nodesource.gpg.key .
RUN apt-key add ./nodesource.gpg.key
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  git \
  nodejs \
  libffi-dev \
  libjpeg-dev \
  libssl-dev \
  libwebp-dev \
  libyaml-dev \
  python3-pip \
  python3-venv \
  shellcheck \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U poetry
RUN npm install -g prettier prettier-plugin-toml
