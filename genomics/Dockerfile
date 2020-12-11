FROM shmohammadi86/r-oneapi-bioc

LABEL name="genomics" \
      maintainer="shahin.mohammadi@gmail.com" \
      description="Docker image with R/Python packages for genomics (+single-cell) analysis."


ADD scripts/install_sc.R /tmp/
RUN R -f /tmp/install_sc.R


ADD scripts/condarc /opt/intel/oneapi/intelpython/latest/.condarc
RUN conda update conda && \
    conda install python=3.6 && \
    conda install anaconda-client && \
    conda install jupyter -y && \
    conda install dask numpy pandas scikit-learn matplotlib seaborn pyyaml scikit-learn h5py keras plotly cython -y && \
    pip install solo-sc scrublet kb-python cellxgene anndata scanpy scvi-tools scanorama bbknn wot


# Init command for s6-overlay
CMD ["/init"]
