#!/bin/bash
set -e

# Set up and install R
R_HOME=${R_HOME:-/usr/local/lib/R}
CRAN=${CRAN:-https://cloud.r-project.org}

apt-get update \
  && apt-get install -y --no-install-recommends \
    bash-completion \
    ca-certificates \
    devscripts \
    file \
    fonts-texgyre \
    g++ \
    gfortran \
    gsfonts \
    libbz2-* \
    libcurl4 \
    libicu* \
    libpcre2* \
    libjpeg-turbo* \
    libpangocairo-* \
    libpng16* \
    libreadline8 \
    libtiff* \
    liblzma* \
    locales \
    make \
    unzip \
    zip \
    zlib1g \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8 \

BUILDDEPS="curl \
    default-jdk \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libicu-dev \
    libpcre2-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    liblzma-dev \
    libx11-dev \
    libxt-dev \
    perl \
    rsync \
    subversion \
    tcl-dev \
    tk-dev \
    texinfo \
    texlive-extra-utils \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-recommended \
    texlive-latex-extra \
    x11proto-core-dev \
    xauth \
    xfonts-base \
    xvfb \
    wget \
    zlib1g-dev"

apt-get install -y --no-install-recommends $BUILDDEPS

# Download R source files
cd /tmp && wget https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz && tar xzf R-${R_VERSION}.tar.gz && cd R-${R_VERSION}

R_PAPERSIZE=letter \
    R_BATCHSAVE="--no-save --no-restore" \
    R_BROWSER=xdg-open \
    PAGER=/usr/bin/pager \
    PERL=/usr/bin/perl \
    R_UNZIPCMD=/usr/bin/unzip \
    R_ZIPCMD=/usr/bin/zip \
    R_PRINTCMD=/usr/bin/lpr \
    LIBnn=lib \
    AWK=/usr/bin/awk \
    MKL="-Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_gf_lp64.a ${MKLROOT}/lib/intel64/libmkl_gnu_thread.a ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lgomp -lpthread -lm -ldl" \
	&& ./configure --with-blas="$MKL" \
		  --with-lapack \
		  --enable-R-shlib \
		  --with-x=yes \
		  --enable-memory-profiling \
		  --enable-threads \
		  --enable-openmp \
		  --with-libpng \
		  --with-readline \
		  --with-ICU \
		  --with-tcltk \
		  --with-recommended-packages \
		  --disable-nls \
		  --disable-java \
		  R_SHELL=/bin/bash \
		'FFLAGS=-m64 -I/usr/include/mkl -O3 -march=native -mtune=native  -fopenmp -w' \
		'CFLAGS=-DU_STATIC_IMPLEMENTATION -m64 -I/usr/include/mkl -O3 -march=native -mtune=native  -fopenmp -w' \
		'CPPFLAGS=-DU_STATIC_IMPLEMENTATION -m64 -I/usr/include/mkl -O3 -march=native -mtune=native  -fopenmp -w' \
		'CXXFLAGS=-DU_STATIC_IMPLEMENTATION -m64 -I/usr/include/mkl -O3 -march=native -mtune=native  -fopenmp -w' \
		&& make -j $(shell nproc) \
		&& make install \
    		&& make clean

## Add a default CRAN mirror
echo "options(repos = c(CRAN = '${CRAN}'), download.file.method = 'libcurl')" >> ${R_HOME}/etc/Rprofile.site

## Set HTTPUserAgent for RSPM (https://github.com/rocker-org/rocker/issues/400)
echo  'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
                 paste(getRversion(), R.version$platform,
                       R.version$arch, R.version$os)))' >> ${R_HOME}/etc/Rprofile.site

## Add parallel make option
mkdir ~/.R/ && echo "MAKEFLAGS+=-j `nproc`" >> ~/.R/Makevars

## Add a library directory (for user-installed packages)
mkdir -p ${R_HOME}/site-library
chown root:staff ${R_HOME}/site-library
chmod g+ws ${R_HOME}/site-library

## Fix library path
echo "R_LIBS=\${R_LIBS-'${R_HOME}/site-library:${R_HOME}/library'}" >> ${R_HOME}/etc/Renviron
echo "TZ=${TZ}" >> ${R_HOME}/etc/Renviron

## Use littler installation scripts
Rscript -e "install.packages(c('littler', 'docopt'), repos='${CRAN}')"
ln -s ${R_HOME}/site-library/littler/examples/install2.r /usr/local/bin/install2.r
ln -s ${R_HOME}/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r
ln -s ${R_HOME}/site-library/littler/bin/r /usr/local/bin/r


## Clean up from R source install
cd /
rm -rf /tmp/*
apt-get remove --purge -y $BUILDDEPS
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
