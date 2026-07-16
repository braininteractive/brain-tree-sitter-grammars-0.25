FROM --platform=$BUILDPLATFORM rust:1.79 AS build
USER 1001:1001
WORKDIR /build
CMD cargo --version
