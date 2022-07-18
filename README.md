# 585.683 Introduction to Brain Computer Interfaces - Mod 07 - Assignment
## Description
This is a repository dedicated to module 7 homework assignment. The purpose of this repository is to containerize an EEG analysis, including automation of building an OS, downloading the data set and checking it's integrity using hashing, and all presenting the analysis in a jupyter notebook.

## How to Install and Run
1. Install Docker (https://www.docker.com/get-started/)
2. Download Dockerfile and docker-compose.yaml (make sure they are in the same directory)
3. Open a Terminal and navigate to the directory containing the downloaded files
4. In the terminal execute: “docker build -t [name]:[tag] .” Without the quotation marks and without the square brackets. name and tag can be arbitrarily defined by the user.
5. In the terminal execute: “docker-compose up” Without the quotation marks.
6. Run the notebook in sequential order or play around with it

Building the image may take it's a long time due to downloading the dataset, environment, packages, and GitHub repository. This may take more than 15 minutes, entirely dependent upon Internet speed.
