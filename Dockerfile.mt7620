#
# Dockerfile for openwrt:mt7620
#

FROM easypi/openwrt:base
MAINTAINER EasyPi Software Foundation

ENV OPENWRT_VERSION=18.06.2
ENV OPENWRT_URL=https://downloads.openwrt.org/releases/18.06.2/targets/ramips/mt7620
ENV OPENWRT_IMG=openwrt-imagebuilder-18.06.2-ramips-mt7620.Linux-x86_64
ENV OPENWRT_SDK=openwrt-sdk-18.06.2-ramips-mt7620_gcc-7.3.0_musl.Linux-x86_64
ENV OPENWRT_IMG_URL=${OPENWRT_URL}/${OPENWRT_IMG}.tar.xz
ENV OPENWRT_SDK_URL=${OPENWRT_URL}/${OPENWRT_SDK}.tar.xz

RUN set -xe \
    && curl -sSL ${OPENWRT_IMG_URL} | tar xJ \
    && curl -sSL ${OPENWRT_SDK_URL} | tar xJ \
    && ln -s ${OPENWRT_IMG} img \
    && ln -s ${OPENWRT_SDK} sdk \
    && cd sdk \
    && ln -s /data bin \
    && ./scripts/feeds update -a
