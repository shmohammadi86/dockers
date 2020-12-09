ARG base_image="ubuntu:20.04"
FROM "$base_image"

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
ARG INTEL_URL=https://repositories.intel.com/graphics/intel-graphics.key

ADD $INTEL_URL /tmp
COPY scripts /tmp
RUN /tmp/install_MKL.sh

# setvars.sh environment variables
ENV CONDA_DEFAULT_ENV='base'
ENV CONDA_EXE='/opt/intel/oneapi/intelpython/latest/bin/conda'
ENV CONDA_PREFIX='/opt/intel/oneapi/intelpython/latest'
ENV CONDA_PROMPT_MODIFIER='(base) '
ENV CONDA_PYTHON_EXE='/opt/intel/oneapi/intelpython/latest/bin/python'
ENV CONDA_SHLVL='1'
ENV CPATH='/opt/intel/oneapi/mkl/latest/include:/opt/intel/oneapi/tbb/2021.1.1/env/../include'
ENV INTEL_PYTHONHOME='/opt/intel/oneapi/debugger/10.0.0/dep'
ENV LD_LIBRARY_PATH='/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/tbb/2021.1.1/env/../lib/intel64/gcc4.8'
ENV LIBRARY_PATH='/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/tbb/2021.1.1/env/../lib/intel64/gcc4.8'
ENV MKLROOT='/opt/intel/oneapi/mkl/latest'
ENV NLSPATH='/opt/intel/oneapi/mkl/latest/lib/intel64/locale/%l_%t/%N'
ENV ONEAPI_ROOT='/opt/intel/oneapi'
ENV PATH='/opt/intel/oneapi/intelpython/latest/bin:/opt/intel/oneapi/intelpython/latest/condabin:/opt/intel/oneapi/mkl/latest/bin/intel64:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
ENV PKG_CONFIG_PATH='/opt/intel/oneapi/mkl/latest/tools/pkgconfig'
ENV PYTHONPATH='/opt/intel/oneapi/advisor/2021.1.1/pythonapi'
ENV SETVARS_COMPLETED='1'
ENV TBBROOT='/opt/intel/oneapi/tbb/2021.1.1/env/..'
ENV _CE_CONDA=''
ENV _CE_M=''
