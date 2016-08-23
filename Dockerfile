FROM scratch
ADD rootfs.tgz /
CMD ["/sbin/init"]
