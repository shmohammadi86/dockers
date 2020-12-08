install.packages("BiocManager", repos="https://cran.rstudio.com")
install.packages(c("tidyverse", "httr", "curl", "dplyr", "remotes", "selectr", "caTools"))

BiocManager::install(version="3.12", update=TRUE, ask=FALSE)
BiocManager::install('devtools')
