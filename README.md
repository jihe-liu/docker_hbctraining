# Docker image for scRNAseq analysis workshop

Docker provides a platform for preconfigured image with all requisite softwares and packages with desired versions. In this tutorial, we will show you how to run Rstudio on docker, which allows you to perform single-cell RNAseq analysis for the workshop.

## Step 1: Installation
Based on the operating system you use, download and install [docker](https://docs.docker.com/get-docker/) on your local computer.

## Step 2: Run docker image
Start docker program on your computer. Then on your terminal, download the docker image for single cell analysis with the following command:
```wrap
docker run --rm -d -p 8787:8787 --name single_cell -e PASSWORD=rstudioSC -v /Users/jil655/Documents/HBC_Training/docker:/home/rstudio/projects vbarrerab/singlecell-base:R.4.0.3-BioC.3.11-ubuntu_20.04
```

After the container is run for the first time, you can re-start that existing container with the command:
```
docker container start single_cell
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
As you perform the analysis, newly generated files will be automatically mounted to the local folder that you specified. After you are done with the analysis, you first close the web browser. Then on your terminal, hit `ctrl`+`c` to end the program. You might also need to stop the container with the command:
```
docker container stop single_cell
```

## Appendix: some useful command
Here we summarize some frequenctly used docker command, all of which can be run on the command line.
```
docker images       # list all docker images (use `-a` to show intermediate images)
docker rmi Image_ID         # remove docker image
docker run --rm -p 8787:8787 -e PASSWORD=1234 rocker/rstudio         # quick way to run an image
docker container ls     # check status of container
docker container ls -a      # check all containers (started and stopped)
docker container stop container_id      # stop a container that is currently running
docker container start container_name       # start an existing container
docker rm container_id      # remove docker container
docker pull rocker/r-base       # pull an image from DockerHub
```

## Reference
- More information and instruction about this docker image for scRNAseq analysis can be found on HBC [knowledgebase](https://github.com/hbc/knowledgebase/blob/master/scrnaseq/rstudio_sc_docker.md).
- If you are interested in learning more about docker and reproducible research, you can follow this short [tutorial](http://ropenscilabs.github.io/r-docker-tutorial/).

# 0302
Tried to run Seurat directly, but it is not based on R. 

# 0318
Oliver tutorial on dockerfile
1. Write dockerfile
```
# Base image https://hub.docker.com/u/rocker/
FROM rocker/r-base:latest

## create directories
RUN mkdir -p /01_data
RUN mkdir -p /02_code
RUN mkdir -p /03_output

## copy files
COPY /02_code/install_packages.R /02_code/install_packages.R
COPY /02_code/myScript.R /02_code/myScript.R

## install R-packages
RUN Rscript /02_code/install_packages.R
```

2. Build docker image
```
docker build -t oliver_image .
```

3. Run docker
```
docker run -it --rm -v /Users/jil655/Documents/HBC_Training/docker/oliver_tutorial/r-script-in-docker/01_data:/01_data -v /Users/jil655/Documents/HBC_Training/docker/oliver_tutorial/r-script-in-docker/03_output:/03_output oliver_image
```

4. Run the R script within docker:
```
source("02_code/myScript.R")
q()     # quit R after done
```

# 0323
Test my own scRNAseq image
> error:
> library(tidyverse)
    Error: package or namespace load failed for ‘tidyverse’ in dyn.load(file, DLLpath = DLLpath, ...):
    unable to load shared object '/usr/local/lib/R/site-library/xml2/libs/xml2.so':
    libxml2.so.2: cannot open shared object file: No such file or directory

# 0324
## Upload image to docker hub
1. login docker on command line
```
docker login
```
Follow username and password

2. tag image
```
docker tag image_id dockerhub_username/image_name
```

3. push image to the hub
```
docker push dockerhub_username/image_name
```