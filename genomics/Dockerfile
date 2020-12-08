FROM nuest/mro:4.0.2-rstudio

# Set Dockerfile version number
## This parameter should be incremented each time there is a change in the Dockerfile

ARG BIOCONDUCTOR_DOCKER_VERSION=3.12.25

LABEL name="bioconductor/bioconductor_docker" \
      version=$BIOCONDUCTOR_DOCKER_VERSION \
      url="https://github.com/Bioconductor/bioconductor_docker" \
      vendor="Bioconductor Project" \
      maintainer="maintainer@bioconductor.org" \
      description="Bioconductor docker image with system dependencies to install most packages." \
      license="Artistic-2.0"

# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*

# issues with '/var/lib/dpkg/available' not found
# this will recreate
RUN dpkg --clear-avail

# This is to avoid the error
# 'debconf: unable to initialize frontend: Dialog'
ENV DEBIAN_FRONTEND noninteractive

# Update apt-get
RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils \
	&& apt-get install -y --no-install-recommends \
	## Basic deps
	gdb \
	libxml2-dev \
	python3-pip \
	libz-dev \
	liblzma-dev \
	libbz2-dev \
	libpng-dev \
	## sys deps from bioc_full
	pkg-config \
	fortran77-compiler \
	byacc \
	automake \
	curl \
	## This section installs libraries
	libpcre2-dev \
	libnetcdf-dev \
	libhdf5-serial-dev \
	libfftw3-dev \
	libopenbabel-dev \
	libopenmpi-dev \
	libxt-dev \
	libudunits2-dev \
	libgeos-dev \
	libproj-dev \
	libcairo2-dev \
	libtiff5-dev \
	libreadline-dev \
	libgsl0-dev \
	libgslcblas0 \
	libgtk2.0-dev \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	libgmp3-dev \
	libhdf5-dev \
	libncurses-dev \
	libbz2-dev \
	libxpm-dev \
	liblapack-dev \
	libv8-dev \
	libgtkmm-2.4-dev \
	libmpfr-dev \
	libmodule-build-perl \
	libapparmor-dev \
	libprotoc-dev \
	librdf0-dev \
	libmagick++-dev \
	libsasl2-dev \
	libpoppler-cpp-dev \
	libprotobuf-dev \
	libpq-dev \
	libperl-dev \
	## software - perl extentions and modules
	libarchive-extract-perl \
	libfile-copy-recursive-perl \
	libcgi-pm-perl \
	libdbi-perl \
	libdbd-mysql-perl \
	libxml-simple-perl \
	libmysqlclient-dev \
	default-libmysqlclient-dev \
	libgdal-dev \
	## new libs
	libglpk-dev \
	## Databases and other software
	sqlite \
	openmpi-bin \
	mpi-default-bin \
	openmpi-common \
	openmpi-doc \
	tcl8.6-dev \
	tk-dev \
	default-jdk \
	imagemagick \
	tabix \
	ggobi \
	graphviz \
	protobuf-compiler \
	jags \
	## Additional resources
	xfonts-100dpi \
	xfonts-75dpi \
	biber \
	libsuitesparse-dev \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

## FIXME
## These two libraries don't install in the above section--WHY?
RUN apt-get update \
	&& apt-get -y --no-install-recommends install \
	libmariadb-dev-compat \
	libjpeg-dev \
	libjpeg-turbo8-dev \
	libjpeg8-dev \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# # Install libsbml and xvfb
RUN cd /tmp \
	## libsbml
	&& curl -O https://s3.amazonaws.com/linux-provisioning/libSBML-5.10.2-core-src.tar.gz \
	&& tar zxf libSBML-5.10.2-core-src.tar.gz \
	&& cd libsbml-5.10.2 \
	&& ./configure --enable-layout \
	&& make \
	&& make install \
	## Clean libsbml, and tar.gz files
	&& rm -rf /tmp/libsbml-5.10.2 \
	&& rm -rf /tmp/libSBML-5.10.2-core-src.tar.gz \
	## apt-get clean and remove cache
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*


RUN mkdir ~/.R/ && echo "MAKEFLAGS+=-j \`nproc\`" >> ~/.R/Makevars && \
	echo "CURL_CA_BUNDLE=/opt/microsoft/ropen/$MRO_VERSION//lib64/R/lib/microsoft-r-cacert.pem" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Renviron
RUN cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site && head -n -7 /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site > /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site && sed -i 's/quiet <- /quiet <- TRUE #/' /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site && cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && echo "options("download.file.method" = \"libcurl\")" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site

ADD scripts/* /tmp/
RUN R -f /tmp/install_bioc.R
RUN R -f /tmp/install_sc.R

RUN cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && rm /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site

# DEVEL: Add sys env variables to DEVEL image
RUN curl -O http://bioconductor.org/checkResults/devel/bioc-LATEST/Renviron.bioc \
	&& cat Renviron.bioc | grep -o '^[^#]*' | sed 's/export //g' >>/etc/environment \
	&& cat Renviron.bioc >> /usr/local/lib/R/etc/Renviron.site \
	&& echo BIOCONDUCTOR_DOCKER_VERSION=${BIOCONDUCTOR_DOCKER_VERSION} >> /usr/local/lib/R/etc/Renviron.site \
	&& rm -rf Renviron.bioc

ENV BIOCONDUCTOR_DOCKER_VERSION=$BIOCONDUCTOR_DOCKER_VERSION

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
