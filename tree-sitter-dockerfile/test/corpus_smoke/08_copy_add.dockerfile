FROM busybox:1.36
ADD https://example.com/archive.tar.gz /tmp/
ADD --chown=1000:1000 local.tar /opt/
COPY --chmod=755 scripts/entrypoint.sh /usr/local/bin/
COPY ["file with spaces.txt", "/dest/"]
VOLUME ["/data", "/logs"]
