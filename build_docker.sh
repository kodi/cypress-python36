#!/usr/bin/env bash
set -e

## ------------------------------------
## @author Dragan Bajcic <dragan.bajcic@atlasml.io>
## Simple script to create docker file and test it
## locally
## ------------------------------------

red='\e[21;31m%s\e[0m\n'
green='\e[21;32m%s\e[0m\n'
yellow='\e[21;33m%s\e[0m\n'
blue='\e[21;34m%s\e[0m\n'
magenta='\e[21;35m%s\e[0m\n'
cyan='\e[21;36m%s\e[0m\n'
white='\e[21;97m%s\e[0m\n'

### ------------------------------------
### CONFIG
### ------------------------------------
DOCKER_TAG=local-dev/cypress-python36  # change this to your_namespace/app-name
DOCKER_DEBUG=''
LOCAL_PATH='/data/atlas-ml/paperswithcode'
DOCKER_PATH='/src'
#DOCKER_DEBUG=--quiet           # uncomment this to turn off docker build output

printf "$yellow" "[1/2] >> build docker container with tag: $DOCKER_TAG"
printf "$white" "===================================="
docker build ${DOCKER_DEBUG} -t  ${DOCKER_TAG} .

printf "$yellow" "[2/2] >> Start a container: $DOCKER_TAG"
printf "$white" "===================================="
docker run --rm -v ${LOCAL_PATH}:${DOCKER_PATH} -i -t ${DOCKER_TAG} /bin/bash