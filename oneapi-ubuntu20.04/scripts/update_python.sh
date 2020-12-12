conda update --all && \
    conda install python=3.6 && \
    conda install anaconda-client && \
    conda install jupyter -y && \
    conda install dask numpy pandas scikit-learn matplotlib seaborn pyyaml scikit-learn h5py plotly cython -y
