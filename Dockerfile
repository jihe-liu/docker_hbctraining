FROM rocker/rstudio

MAINTAINER jiheliu@hsph.harvard.edu

# Run libraries
RUN apt-get update && apt-get install --yes \
       r-base-dev \
       libssl-dev \
       libcurl4-openssl-dev \
       libxml2-dev \
       libpng-dev \
       libglpk-dev

# Copy R script for installation
COPY install.R install.R

# Install R packages
RUN Rscript /install.R
