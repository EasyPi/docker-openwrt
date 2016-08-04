#
# Dockerfile for openwrt:mt7688
#

FROM easypi/openwrt:base
MAINTAINER EasyPi Software Foundation

ENV OPENWRT_VERSION=15.05.1
ENV OPENWRT_URL=https://downloads.openwrt.org/chaos_calmer/15.05.1/ramips/mt7688
ENV OPENWRT_IMG=OpenWrt-ImageBuilder-15.05.1-ramips-mt7688.Linux-x86_64
ENV OPENWRT_SDK=OpenWrt-SDK-15.05.1-ramips-mt7688_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64
ENV OPENWRT_IMG_URL=${OPENWRT_URL}/${OPENWRT_IMG}.tar.bz2
ENV OPENWRT_SDK_URL=${OPENWRT_URL}/${OPENWRT_SDK}.tar.bz2

RUN set -xe \
    && curl -sSL ${OPENWRT_IMG_URL} | tar xj \
    && curl -sSL ${OPENWRT_SDK_URL} | tar xj \
    && ln -s ${OPENWRT_IMG} img \
    && ln -s ${OPENWRT_SDK} sdk \
    && cd sdk \
    && ln -s /data bin \
    && ./scripts/feeds update -a
