# Docker image for scRNAseq analysis workshop

Docker provides a platform for preconfigured image with all requisite softwares and packages with desired versions. In this tutorial, we will show you how to run Rstudio on docker, which allows you to perform single-cell RNAseq analysis for the workshop.

## Step 1: Installation
Based on the operating system you use, download and install [docker](https://docs.docker.com/get-docker/) on your local computer.

## Step 2: Run docker image
Start docker program on your computer. Then on your terminal, download the docker image for single cell analysis with the following command:
```wrap
docker run --rm -d -p 8787:8787 --name single_cell -e PASSWORD=rstudioSC -v /Users/jil655/Documents/HBC_Training/docker:/home/rstudio/projects vbarrerab/singlecell-base:R.4.0.3-BioC.3.11-ubuntu_20.04
```
> Note:
1. The first time you run this command, it will download the `vbarrerab/singlecell-base:R.4.0.3-BioC.3.11-ubuntu_20.0` docker image from DockerHub: https://hub.docker.com/r/vbarrerab/singlecell-base.
2. Use of flags
- `-p`: set the local port to access the docker container
- `--name`: set a name for the container
- `-v`: mount the container to a local host. The syntax is `local_folder_path:container_path`. For example, here the container path is set as `/home/rstudio/projects`. Before the `:`, specify the local path where you want to store the result.
- `--rm`: automatically remove the existing docker container once it is closed. This prevents occupation of space with existing containers.

At this point, you can check whether the container has been running, using `docker container` command. You should see a container ID and its associated properties.
```
docker container ls
```

## Step 3: Access Rstudio
Once the container is started, open your web browser, and go to **localhost:8787**.
You will be prompted to log into Rstudio. The Username is `rstudio` (this is by default), and the password is `rstudioSC` (the one you specified earlier in the `docker run` command). You should now see Rstudio interface in docker environment.

## Step 4: Load libraries
Libraries needed for single cell analysis in this workshop are already installed in this container. Now you just need to load all libraries.
```r
library(Seurat)
library(tidyverse)
library(Matrix)
library(RCurl)
library(scales)
library(cowplot)
library(SingleCellExperiment)
library(AnnotationHub)
library(ensembldb)
```

Run `sessionInfo` to check versions. Then you can perform analysis just like in your Rstudio environment.
```r
sessionInfo()
```

## Step 5: End container
As you perform the analysis, newly generated files will be automatically mounted to the local folder that you specified. After you are done with the analysis, you first close the web browser. Then on your terminal, hit `ctrl`+`c` to end the program. 

## Appendix: some useful command
Here we summarize some frequenctly used docker command, all of which can be run on the command line.
```
docker images       # list all docker images
docker container ls     # check status of container
docker container ls -a      # check all containers (started and stopped)
docker container stop container_id      # stop a container that is currently running
docker container start container_name       # start an existing container   
```

## Reference
- More information and instruction about this docker image for scRNAseq analysis can be found on HBC [knowledgebase](https://github.com/hbc/knowledgebase/blob/master/scrnaseq/rstudio_sc_docker.md).
- If you are interested in learning more about docker and reproducible research, you can follow this short [tutorial](http://ropenscilabs.github.io/r-docker-tutorial/).
