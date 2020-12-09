FROM shmohammadi86/r-bioc

LABEL name="genomics" \
      maintainer="shahin.mohammadi@gmai.com" \
      description="Docker image with R/Python packages for genomics (+single-cell) analysis."


RUN mkdir ~/.R/ && echo "MAKEFLAGS+=-j \`nproc\`" >> ~/.R/Makevars && \
	echo "CURL_CA_BUNDLE=/opt/microsoft/ropen/$MRO_VERSION//lib64/R/lib/microsoft-r-cacert.pem" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Renviron

RUN cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site && head -n -7 /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site > /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site && sed -i 's/quiet <- /quiet <- TRUE #/' /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site && cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && echo "options("download.file.method" = \"libcurl\")" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site

ADD scripts/* /tmp/
RUN R -f /tmp/install_sc.R

RUN cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && rm /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site


## Install nextflow
RUN cd /tmp && export NXF_VER=19.07.0 && curl https://get.nextflow.io | bash && mv nextflow /usr/local/bin

## Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  sudo ./aws/install

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

## Install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda install python=3.6 && \
    /opt/conda/bin/conda install anaconda-client && \
    /opt/conda/bin/conda install jupyter -y && \
    /opt/conda/bin/conda install dask numpy pandas scikit-learn matplotlib seaborn pyyaml scikit-learn h5py keras plotly -y && \
    pip install solo-sc scrublet kb-python cellxgene anndata scanpy scvi-tools cwltool


# Init command for s6-overlay
CMD ["/init"]
