FROM alpine:3.18@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11

COPY ./ /app/
RUN apk add --update --no-cache --virtual .build-deps \
        build-base \
        ncurses-dev \
    \
    # Install runtime
    && apk add --no-cache \
        ncurses-libs \
    \
    # Build
    && cd /app \
    && make \
    && install -m 755 erutaso /usr/local/bin \
    \
    # Clean
    && apk del --purge .build-deps \
    && rm -rf /app

ENTRYPOINT [ "/usr/local/bin/erutaso" ]
