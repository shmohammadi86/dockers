#!/bin/bash
set -e

apt-get update \
  && apt-get install -y --no-install-recommends wget gnupg2 ca-certificates

# Install the GPG key for the repository
wget  --no-check-certificate https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB && apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB && rm GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB

# Add the APT Repository
sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list'

# Install MKL
apt-get update -y && apt-get install -y --no-install-recommends -o=Dpkg::Use-Pty=0 intel-mkl
