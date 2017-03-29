# nodecljs
FROM alpine:latest
MAINTAINER Greg Haskins <gregory.haskins@gmail.com>

ENV BUILDER_VERSION 0.0.1
ENV LEIN_ROOT=1

LABEL io.k8s.description="Platform for building Clojurescript on NodeJS" \
      io.k8s.display-name="builder 0.0.1" \
      io.openshift.s2i.scripts-url="/usr/libexec/s2i"

RUN apk --no-cache add \
    nodejs \
    openjdk8 \
    curl \
    wget \
    git \
    bash

RUN curl -sL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein && \
    chmod a+x /usr/local/bin/lein && \
    lein self-install

# Defines the location of the S2I
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
# Copy the S2I scripts from ./.s2i/bin/ to /usr/local/s2i when making the builder image
COPY ./s2i/bin/ /usr/local/s2i

CMD ["/usr/local/s2i/usage"]
