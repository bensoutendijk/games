FROM mbround18/valheim:latest

RUN apt-get update \
  && apt-get install -y curl unzip jq rsync

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip


ENTRYPOINT [ "bash", "/startWithImport.sh" ]