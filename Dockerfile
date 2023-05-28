FROM alpine:3.17@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126

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
