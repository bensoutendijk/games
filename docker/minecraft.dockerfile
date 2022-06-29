FROM itzg/minecraft-server:java17-jdk

RUN apt-get update \
  && apt-get install -y curl unzip wget python3-distutils \
  && wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py \
  && python3 /tmp/get-pip.py \
  && pip3 install botocore


RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip

COPY ./entrypoints/startMinecraft.sh /startWithImport.sh

ENTRYPOINT [ "bash", "/startWithImport.sh" ]