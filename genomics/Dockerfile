FROM shmohammadi86/r-oneapi-bioc

LABEL name="genomics" \
      maintainer="shahin.mohammadi@gmail.com" \
      description="Docker image with R/Python packages for genomics (+single-cell) analysis."

RUN conda update --all
RUN pip install solo-sc scrublet kb-python cellxgene anndata scanpy scvi-tools scanorama bbknn wot

ADD scripts/install_sc.R /tmp/
RUN R -f /tmp/install_sc.R

CMD ["/init"]
