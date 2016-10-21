FROM alpine:latest
MAINTAINER "Tim Fall <tim@hashicorp.com>"

ENV PACKER_VERSION=0.11.0
ENV PACKER_SHA256SUM=318ffffa13763eb6f29f28f572656356dc3dbf8d54c01ffddd1c5e2f08593adb

RUN apk add --update git bash wget

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/packer_${PACKER_VERSION}_linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENTRYPOINT ["/bin/packer"]
