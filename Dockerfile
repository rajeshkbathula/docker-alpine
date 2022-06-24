FROM alpine:3.16.0

USER root

RUN apk add make unzip zip wget git bash curl openssh
RUN PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip && pip3 install --no-cache --upgrade pip setuptools && pip3 install virtualenv

RUN pip install --no-cache-dir awscli

RUN apk --no-cache add ca-certificates

ENV HOME=/root

ENV PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"

ENV asdf "$HOME/.asdf/asdf.sh"

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.0

RUN asdf plugin add terraform
RUN asdf plugin add python
