#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update \
  && apt-get install -y --no-install-recommends wget gnupg2 ca-certificates

# Install the GPG key for the repository
wget  --no-check-certificate https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB && apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB && rm GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB

# Add the APT Repository
sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list'

# Install MKL
apt-get update -y && apt-get install -q -y --no-install-recommends -o=Dpkg::Use-Pty=0 intel-mkl


## update alternatives
update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so     \
                    libblas.so-x86_64-linux-gnu      /usr/lib/x86_64-linux-gnu/libmkl_rt.so 50
update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so.3   \
                    libblas.so.3-x86_64-linux-gnu    /usr/lib/x86_64-linux-gnu/libmkl_rt.so 50
update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so   \
                    liblapack.so-x86_64-linux-gnu    /usr/lib/x86_64-linux-gnu/libmkl_rt.so 50
update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so.3 \
                    liblapack.so.3-x86_64-linux-gnu  /usr/lib/x86_64-linux-gnu/libmkl_rt.so 50

echo "MKL_THREADING_LAYER=GNU" >> /etc/environment
