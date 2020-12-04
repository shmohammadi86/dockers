FROM shmohammadi86/r-bioc

LABEL name="actionet" \
      description="ACTIONet single-cell analysis framework"

ENV DEBIAN_FRONTEND noninteractive

# Install R packages
ADD scripts/install.R /tmp/
RUN R -f /tmp/install.R

## Install nextflow
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        openjdk-8-jre-headless openssh-client cmake && \
    rm -rf /var/lib/apt/lists/*
RUN cd /tmp && export NXF_VER=19.07.0 && curl https://get.nextflow.io | bash && mv nextflow /usr/local/bin

## Install AWS CLI

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  sudo ./aws/install

CMD ["/init"]
