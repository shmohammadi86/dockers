FROM shmohammadi86/r-oneapi-bioc

LABEL name="genomics" \
      maintainer="shahin.mohammadi@gmail.com" \
      description="Docker image with R/Python packages for genomics (+single-cell) analysis."


ADD scripts/* /tmp/
RUN R -f /tmp/install_sc.R

RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda install python=3.6 && \
    /opt/conda/bin/conda install anaconda-client && \
    /opt/conda/bin/conda install jupyter -y && \
    /opt/conda/bin/conda install dask numpy pandas scikit-learn matplotlib seaborn pyyaml scikit-learn h5py keras plotly cython -y && \
    pip install solo-sc scrublet kb-python cellxgene anndata scanpy scvi-tools scanorama bbknn wot


# Init command for s6-overlay
CMD ["/init"]
