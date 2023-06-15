FROM alpine:3.18@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1

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
