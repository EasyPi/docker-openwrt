FROM scratch
ADD rootfs.tgz /
ENTRYPOINT ["init"]
