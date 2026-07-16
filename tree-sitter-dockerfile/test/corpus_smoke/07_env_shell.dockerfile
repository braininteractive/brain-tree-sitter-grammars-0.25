FROM ubuntu:24.04
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV PATH="/opt/tool/bin:${PATH}"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN echo "$PATH" | tr ':' '\n'
