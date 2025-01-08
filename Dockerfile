FROM alpine:3.18@sha256:dd60c75fba961ecc5e918961c713f3c42dd5665171c58f9b2ef5aafe081ad5a0

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
