# Using docker image for single cell RNA-seq analysis workshop

Docker provides a platform for pre-configured image, with all requisite softwares and packages of desired versions. In this tutorial, we demonstrate how to run Rstudio on docker, and further use this docker environment for single cell RNA-seq analysis.

## Step 1: Install the docker software
Depending on your operating system, download and install corresponding [docker](https://docs.docker.com/get-docker/) on your local computer.

## Step 2: Create a local folder for the analysis
To facilitate the data transfer between our local computer and the docker environment, let's first create a local folder, where all future analysis results are stored. We create the folder on desktop: `/Users/jil655/Desktop/sc_rnaseq_workshop`. You could create this folder anywhere you would like.

## Step 3: Run the docker image for scRNA-seq
Start the docker software on your computer. Next, on your terminal, type the following command to download the pre-configured docker image for scRNA-seq:
```wrap
docker run --rm -d -p 8787:8787 --name sc_rnaseq -e PASSWORD=1234 -v /Users/jil655/Desktop/sc_rnaseq_workshop:/home/rstudio liujihe/single_cell_rnaseq
```

> Note:
1. The first time you run this command, it will download the `liujihe/single_cell_rnaseq` docker image from DockerHub: https://hub.docker.com/r/liujihe/single_cell_rnaseq. This is the docker image we have prepared for you, which include all requisite R packages for the workshop.
2. What each option mean:
- `-p`: set the local port to access the docker container
- `--name`: set a name for the container
- `-v`: mount the container to a local host. The syntax is `local_folder_path:container_path`. For example, the container path here is set as `/home/rstudio`. Before the `:`, specify the path of local folder to store the result. This option allows synchronization of result from docker to the local folder, so that you don't lose result after deleting docker container.
- `--rm`: automatically remove the existing docker container once it is closed. This prevents occupation of space with existing containers.

At this point, you can check whether the container is running, using the `docker container ls` command. You should see a container ID and its associated properties.
```
docker container ls
```

## Step 4: Log into the Rstudio environment
Now that the container runs, open your web browser, and go to **localhost:8787**.
You will be prompted to log into Rstudio. The Username is `rstudio` (this is by default), and the password is `1234` (the one you specified earlier in the `docker run` command). You should now see a Rstudio interface in docker environment.

## Step 5: Load libraries
Libraries needed for this scRNA-seq workshop are already installed in the container. Now you just need to load all libraries.
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

Run `sessionInfo` to make sure all libraries are loaded. Then you can perform analysis just like in your local Rstudio environment.
```r
sessionInfo()
```

## Step 6: Set up the project
Create a project in Rstudio, and add folders `data`, `results`, `figures`. Those folders are mounted on your local computer as well. Download the sequencing data to the `data` folder on your local computer. You are now all set to start the actual analysis.

## Step 6: End the container
As you perform the analysis, newly-generated files will be automatically mounted to the local folder that you specified. When you finish the analysis, close the web browser. Then on your terminal, hit `ctrl`+`c` to end the program. Lastly, stop the container with the command:
```
docker container stop sc_rnaseq
```

## Appendix: some useful command
Here we summarize some frequenctly used docker commands, all of which can be run on the command line.
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
- If you are interested in learning more about docker and reproducible research, you can follow this short [tutorial](http://ropenscilabs.github.io/r-docker-tutorial/).
