# To build: docker build -t <namespace>/awscli .
# To run: docker run -it <namespace>/awscli
# cd /apps; aws s3 command

FROM alpine:3.2
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>

RUN apk --update add \
      python \
      py-pip \
      jq \
      curl && \
      pip install --upgrade awscli  && \
      mkdir /root/.aws

COPY get-metadata /usr/local/bin/get-metadata

# Expose data volume
VOLUME /apps
