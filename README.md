OpenWrt Builder
===============

[![Build Status](https://travis-ci.org/EasyPi/docker-openwrt.svg)](https://travis-ci.org/EasyPi/docker-openwrt)
[![Docker Stars](https://img.shields.io/docker/stars/easypi/openwrt.svg)](https://hub.docker.com/r/easypi/openwrt/)
[![Docker Pulls](https://img.shields.io/docker/pulls/easypi/openwrt.svg)](https://hub.docker.com/r/easypi/openwrt/)
[![Image Layers](https://images.microbadger.com/badges/image/easypi/openwrt.svg)](https://microbadger.com/#/images/easypi/openwrt)

:radio: OpenWrt Package Builder for Raspberry Pi

## docker-compose.yml

```yaml
base:
  image: easypi/openwrt:base
  command: sleep infinity
  environment:
    - TERM=xterm
  restart: unless-stopped

bcm2708:
  extends:
    service: base
  image: easypi/openwrt:bcm2708
  volumes:
    - ./data/bcm2708:/data
```

## Server Setup

```bash
$ docker-compose up -d bcm2708
$ docker-compose exec bcm2708 bash
>>> cd ~/sdk
>>> sudo chmod 777 bin

>>> ./scripts/feeds update -a
>>> ./scripts/feeds install -a
>>> make defconfig
>>> IGNORE_ERRORS=1 make V=s

>>> sudo apt install -y asciidoc xmlto
>>> git clone https://github.com/shadowsocks/openwrt-shadowsocks.git package/shadowsocks-libev
>>> vi package/shadowsocks-libev/Makefile
- Package/shadowsocks-libev-spec = $(call Package/shadowsocks-libev/Default,openssl,(OpenSSL),+libopenssl +libpthread +ipset +ip)
+ Package/shadowsocks-libev-spec = $(call Package/shadowsocks-libev/Default,openssl,(OpenSSL),+libopenssl +libpthread +ipset +ip +iptables-mod-tproxy +zlib)
>>> make menuconfig # Network ▷ shadowsocks-libev-spec ▷ Save ▷ Exit
>>> make package/shadowsocks-libev/compile V=s

>>> tree -dF /data/
/data/
└── brcm2708/
    └── packages/
        ├── base
        ├── luci
        ├── management
        ├── packages
        ├── routing
        └── telephony
```

## Client Setup

```
$ vi /etc/opkg.conf
$ opkg update
$ opkg install shadowsocks-libev-spec
```

## References

- <https://wiki.openwrt.org/doc/howto/build>
- <https://docs.travis-ci.com/user/docker/>
