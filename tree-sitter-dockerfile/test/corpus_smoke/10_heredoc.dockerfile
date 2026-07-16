FROM alpine:3.20
RUN <<END
apk add --no-cache git
git --version
END
COPY <<CONF /etc/app.conf
listen 8080
verbose true
CONF
