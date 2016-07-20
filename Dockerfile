FROM ubuntu:xenial

RUN apt-get update -y && \
    apt-get install -y build-essential wget curl git default-jdk && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    curl -sL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein && \
    chmod a+x /usr/local/bin/lein && \
    apt-get -y autoremove && \
    apt-get clean

RUN useradd -s /bin/bash -m builder
USER builder

RUN lein self-install
