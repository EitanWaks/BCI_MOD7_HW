# Python version (use -bullseye variants on local arm64/Apple Silicon)
ARG VARIANT="3.10-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT} AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set git credentials; credentials must be in PATH
ARG gitusername=$GIT_USERNAME
ARG gitpassword=$GIT_PASSWORD

# Set github credentials
ARG githubnamespace=EitanWaks
ARG githubreponame=BCI_MOD7_HW
ARG githubrepo=${githubnamespace}/${githubreponame}.git

# Set dataset name and filetype; used for the url (permalink)
ARG datasetname=1
ARG datasettype=edf
ARG dataseturl=https://gin.g-node.org/robintibor/high-gamma-dataset/src/395f86583b7342e687dbfa5ef9077377b0428370/data/train/${datasetname}.${datasettype}

# Logical statement for choosing the correct hash. Depending on the data type. Datasets hashed July, 20, 2022
FROM base AS branch-datasettype-edf
ARG DATASET_SHA256=943390216871aee03dac6cda77e0f0ba34bc9adfc9d8bc7790127981b13b7bc4

FROM base AS branch-datasettype-mat
ARG DATASET_SHA256=41dd2171d8806658e053a81e51960e1434f949615221afc4afb22adb46f4ceee

FROM branch-datasettype-${datasettype} AS final
RUN echo "VAR is equal to ${VAR}"

# Download High Gamma Dataset from https://gin.g-node.org/robintibor/high-gamma-dataset
WORKDIR /app
# ADD ${dataseturl} ./data/${datasetname}.${datasettype}
COPY ${datasetname}.${datasettype} ./data/${datasetname}.${datasettype}

# Hash checksum for the dataset
RUN echo "${DATASET_SHA256}  ./data/${datasetname}.${datasettype}" | sha256sum --check

# Download latest source code from github
RUN git clone https://${gitusername}:${gitpassword}@github.com/${githubrepo}

# Upgrade pip and install packages
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN python -m pip install -r ./${githubreponame}/requirements.txt

CMD ["jupyter-lab","--ip=0.0.0.0","--no-browser","--allow-root"]
