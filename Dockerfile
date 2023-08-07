FROM alpine:3.18@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a

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
