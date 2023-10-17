FROM alpine:3.16.0

USER root

RUN apk add make unzip zip wget git bash curl openssh
RUN PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip && pip3 install --no-cache --upgrade pip setuptools && pip3 install virtualenv

# RUN pip install --no-cache-dir awscli

RUN apk --no-cache add ca-certificates

ARG GLIBC_VERSION=2.35-r0
#ARG AWSCLI_VERSION=2.11.11

# install glibc compatibility for alpine
RUN apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk \
    && apk add --no-cache --force-overwrite \
        glibc-${GLIBC_VERSION}.apk \
        glibc-bin-${GLIBC_VERSION}.apk \
        glibc-i18n-${GLIBC_VERSION}.apk


RUN apk add --no-cache aws-cli
ENV HOME=/root

ENV PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"

ENV asdf "$HOME/.asdf/asdf.sh"
RUN apk add make unzip zip wget git bash curl openssh


RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.11.2

RUN asdf plugin add terraform
RUN asdf plugin add python

