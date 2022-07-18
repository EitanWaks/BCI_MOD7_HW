# Python version (use -bullseye variants on local arm64/Apple Silicon)
ARG VARIANT="3.10-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

ARG gitusername=$GIT_USERNAME
ARG gitpassword=$GIT_PASSWORD

ARG githubnamespace=EitanWaks
ARG githubreponame=BCI_MOD7_HW
ARG githubrepo=${githubnamespace}/${githubreponame}.git

ARG datasetname=1
ARG datasettype=mat
ARG dataseturl=https://gin.g-node.org/robintibor/high-gamma-dataset/raw/395f86583b7342e687dbfa5ef9077377b0428370/data/train/1.mat

# Dataset hashed July 16, 2022
ARG DATASET_SHA256=41dd2171d8806658e053a81e51960e1434f949615221afc4afb22adb46f4ceee

# Download High Gamma Dataset 1.mat dataset from https://gin.g-node.org/robintibor/high-gamma-dataset
WORKDIR /app
ADD ${dataseturl} ./data/${datasetname}.${datasettype}
# COPY ${datasetname}.${datasettype} ./data/${datasetname}.${datasettype}

# # Hash checksum for the dataset
RUN echo "${DATASET_SHA256}  ./data/${datasetname}.${datasettype}" | sha256sum --check

# Download latest source code from github
RUN git clone https://${gitusername}:${gitpassword}@github.com/${githubrepo}

# install packages
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN python -m pip install -r ./${githubreponame}/requirements.txt

CMD ["jupyter-lab","--ip=0.0.0.0","--no-browser","--allow-root"]
