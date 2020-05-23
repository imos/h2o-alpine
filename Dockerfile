FROM alpine:3.5
MAINTAINER Kentaro Imajo <github@imoz.jp>

ENV URL     https://github.com/h2o/h2o.git
ENV VERSION v2.2.6
ENV BUILD_OPTIONS -DCMAKE_INSTALL_SYSCONFDIR=/etc/h2o -DWITH_MRUBY=off

RUN apk update \
    && apk upgrade \
    && apk add wslay libuv libstdc++ libgcc \
    && apk add --virtual .build-deps \
         build-base libressl-dev make wslay-dev libuv-dev \
         cmake git linux-headers zlib-dev \
    && git clone $URL -b $VERSION --recursive --depth=1 --shallow-submodules \
    && cd h2o \
    && cmake $BUILD_OPTIONS \
    && make \
    && make install \
    && strip h2o \
    && cp h2o /usr/sbin \
    && cd .. \
    && rm -rf h2o \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/h2o

ADD h2o.conf /etc/h2o/
WORKDIR /etc/h2o/
EXPOSE 80 443
CMD h2o 
