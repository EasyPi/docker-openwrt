OpenWrt
=======

[![Build Status](https://travis-ci.org/EasyPi/docker-openwrt.svg)](https://travis-ci.org/EasyPi/docker-openwrt)
[![Docker Stars](https://img.shields.io/docker/stars/easypi/openwrt.svg)](https://hub.docker.com/r/easypi/openwrt/)
[![Docker Pulls](https://img.shields.io/docker/pulls/easypi/openwrt.svg)](https://hub.docker.com/r/easypi/openwrt/)
[![Image Layers](https://images.microbadger.com/badges/image/easypi/openwrt.svg)](https://microbadger.com/#/images/easypi/openwrt)

## docker-compose.yml

```
openwrt:
  image: vimagick/openwrt
  container_name: openwrt
  hostname: OpenWrt
  ports:
    - "8022:22"
    - "8080:80"
  restart: always
```

## build image

```bash
$ make build
$ make login
$ make push
$ make clean
```

## up and running

```
$ docker-compose up -d
$ docker-compose exec openwrt sh
>>> opkg update
>>> opkg install luci
>>> exit
```

## issues

- [ ] OpenWrt cannot access NIC properly.

-----------------------------------------

OpenWrt Builder
===============

:radio: OpenWrt Package Builder for Raspberry Pi

## docker-compose.yml

```yaml
base:
  image: easypi/openwrt:base
  command: sleep infinity
  environment:
    - TERM=xterm
  restart: unless-stopped

bcm2710:
  extends:
    service: base
  image: easypi/openwrt:bcm2710
  volumes:
    - ./data/bcm2710:/data
```

## Server Setup

```bash
$ docker-compose up -d bcm2710
$ docker-compose exec bcm2710 bash
>>> cd ~/sdk
>>> sudo chmod 777 bin

>>> ./scripts/feeds update -a
>>> ./scripts/feeds install -a
>>> make defconfig
>>> IGNORE_ERRORS=1 make V=s

>>> git clone https://github.com/shadowsocks/openwrt-shadowsocks.git package/shadowsocks-libev
>>> ./scripts/feeds install libopenssl zlib
>>> vi package/shadowsocks-libev/Makefile
- DEPENDS:=$(3) +libpthread
+ DEPENDS:=$(3) +libpthread +zlib
>>> make menuconfig # Network ▷ <M> shadowsocks-libev ▷ Save ▷ Exit
>>> make package/shadowsocks-libev/compile V=s

>>> git clone https://github.com/shadowsocks/luci-app-shadowsocks.git package/luci-app-shadowsocks
>>> pushd package/luci-app-shadowsocks/tools/po2lmo
>>> make && sudo make install
>>> popd
>>> make menuconfig # LuCI ▷ 3. Applications ▷ <M> luci-app-shadowsocks ▷ Save ▷ Exit
>>> make package/luci-app-shadowsocks/compile V=s

$ tree -A -F -L 3 /data/
/data/
├── packages/
│   └── arm_cortex-a53_neon-vfpv4/
│       ├── base/
│       └── packages/
└── targets/
    └── brcm2708/
        └── bcm2710/
```

> You need to manage dependencies manually without `./scripts/feeds`.

## Client Setup

```
$ opkg update
$ opkg install shadowsocks-libev*.ipk \
               luci-app-shadowsocks*.ipk \
               iptables-mod-tproxy
```

## References

- <https://wiki.openwrt.org/doc/howto/build>
- <https://docs.travis-ci.com/user/docker/>
- <https://github.com/shadowsocks/openwrt-shadowsocks>
- <https://github.com/shadowsocks/luci-app-shadowsocks>
