#!/bin/bash
set -e

# Setup Intel oneAPI repository
apt-get update \
  && apt-get install -y --no-install-recommends wget gnupg2 ca-certificates software-properties-common

cd /tmp \
	&& wget --no-check-certificate https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
	&& apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
	&& rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
	&& echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list \
	&& add-apt-repository "deb https://apt.repos.intel.com/oneapi all main"

# Install Intel(R) oneAPI Base Toolkit
apt-get update -y && \
	apt-get install -y --no-install-recommends -o=Dpkg::Use-Pty=0 \
		intel-oneapi-common-licensing \
		intel-oneapi-common-vars \
		intel-oneapi-mkl-devel \
		intel-oneapi-python \
		intel-oneapi-tbb-devel \
		--
		
