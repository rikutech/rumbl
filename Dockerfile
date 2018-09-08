FROM elixir:alpine

RUN yes | mix local.hex
RUN yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
RUN mix local.rebar --force
RUN apk update && \
    apk upgrade && \
    apk add --update\
    bash \
    alpine-sdk \
    musl-dev \
    gcc \
    make \
    g++ \
    file \
    curl-dev \
    git \
    nodejs \
    nodejs-npm \
    inotify-tools \
    && rm -rf /var/cache/apk/*

RUN mkdir /app
ADD . /app
WORKDIR /app
RUN mix deps.get && mix deps.compile
