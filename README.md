# Docker images related to ACTIONet package

* Level-1 (base): Highly-optimized version of the latest version of R compiled from source with MKL BLAS/LAPACK libraries.
* Level-2 (bioc): Builds on the top of the base-layer and adds the most commonly used packages for bioinformatics analysis
* Level-3 (actionet): Builds on the top of the bioc-layer and installs the latest ACTIONet/SCINET libraries from their corresponding GitHub repositories
