FROM nuest/mro:4.0.2-rstudio

ARG BIOCONDUCTOR_DOCKER_VERSION=3.12.28

LABEL name="r-bioc" \
      maintainer="shahin.mohammadi@gmai.com" \
      description="MRAN-based bioc docker."


ENV DEBIAN_FRONTEND noninteractive
ENV BIOCONDUCTOR_DOCKER_VERSION=$BIOCONDUCTOR_DOCKER_VERSION

# Update apt-get
RUN rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/* && \
	dpkg --clear-avail && \
	apt-get update \
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
	&& make -j `nproc`\
	&& make install \
	## Clean libsbml, and tar.gz files
	&& rm -rf /tmp/libsbml-5.10.2 \
	&& rm -rf /tmp/libSBML-5.10.2-core-src.tar.gz \
	## apt-get clean and remove cache
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*


RUN mkdir ~/.R/ && echo "MAKEFLAGS+=-j \`nproc\`" >> ~/.R/Makevars && \
	cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site && \
	head -n -7 /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site > /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site && \
	sed -i 's/quiet <- /quiet <- TRUE #/' /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site && \
	cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_new.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && \
	echo "options("download.file.method" = \"libcurl\")" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && \
	echo "options(defaultPackages=c(getOption('defaultPackages'),'BiocManager'))" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && \
	echo "R_LIBS=/usr/local/lib/R/host-site-library:\${R_LIBS}" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Renviron.site
	
ADD scripts/* /tmp/
RUN R -f /tmp/install_bioc.R
RUN R -f /tmp/update_packages.R

RUN cp /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site && rm /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile_old.site \
	&& echo "options(defaultPackages=c(getOption('defaultPackages'),'BiocManager'))" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site \
	&& echo "Sys.setenv(CURL_CA_BUNDLE = file.path(Sys.getenv('R_HOME'), 'lib/microsoft-r-cacert.pem'))" >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Rprofile.site

# DEVEL: Add sys env variables to DEVEL image
RUN curl -O http://bioconductor.org/checkResults/devel/bioc-LATEST/Renviron.bioc \
	&& cat Renviron.bioc | grep -o '^[^#]*' | sed 's/export //g' >> /etc/environment \
	&& cat Renviron.bioc >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Renviron.site \
	&& echo BIOCONDUCTOR_DOCKER_VERSION=${BIOCONDUCTOR_DOCKER_VERSION} >> /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc/Renviron.site \
	&& rm -rf Renviron.bioc
	
  
  
# Init command for s6-overlay
CMD ["/init"]
