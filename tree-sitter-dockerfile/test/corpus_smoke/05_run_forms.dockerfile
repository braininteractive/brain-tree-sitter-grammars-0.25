FROM debian:bookworm-slim
# shell form with line continuations
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl && \
    rm -rf /var/lib/apt/lists/*
# exec form
RUN ["/bin/bash", "-c", "echo exec form"]
# with mount option
RUN --mount=type=cache,target=/root/.cache pip install requests
