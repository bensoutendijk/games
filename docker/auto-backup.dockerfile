FROM ubuntu:20.04

RUN apt-get update \
  && apt-get install -y curl unzip jq

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip

ENTRYPOINT [ "bash", "/backup.sh" ]