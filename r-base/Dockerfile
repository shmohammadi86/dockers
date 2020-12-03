ARG PARENT_IMAGE
FROM "$PARENT_IMAGE"

LABEL name="r-base" \
      maintainer="shahin.mohammadi@gmail.com" \
      description="R4.0.3 compiled with Intel MKL+RStudio Server (inspired by the Rocker project)"

ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1
ENV R_VERSION=4.0.3
ENV S6_VERSION=v1.21.7.0
ENV RSTUDIO_VERSION=latest
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

COPY scripts /scripts

RUN /scripts/install_MKL.sh
RUN /scripts/install_R.sh
RUN /scripts/install_rstudio.sh
RUN /scripts/install_pandoc.sh

EXPOSE 8787

CMD ["/init"]
