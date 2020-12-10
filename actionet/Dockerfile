FROM shmohammadi86/genomics

LABEL name="shmohammadi86/actionet" \
      version=1.0.0 \
      vendor="ACTIONet" \
      maintainer="shahin.mohammadi@gmail.com" \
      description="ACTIONet single-cell framework." \
      license="GPLv2"

RUN R -e 'devtools::install_github("shmohammadi86/ACTIONet", ref = "R-release")'

CMD ["/init"]
