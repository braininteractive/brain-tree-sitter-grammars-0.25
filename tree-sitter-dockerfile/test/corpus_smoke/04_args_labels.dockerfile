ARG BASE_TAG=3.20
FROM alpine:${BASE_TAG}
ARG BUILD_DATE
ARG VCS_REF="unknown"
LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$VCS_REF \
      maintainer="Example Maintainer <dev@example.com>"
