FROM nginx:1.27
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
STOPSIGNAL SIGQUIT
EXPOSE 80/tcp 443/tcp
