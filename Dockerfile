FROM cypress/included:3.3.1

USER root


ARG BUILDDIR="/tmp/build"
ARG PYTHON_VER="3.6.8"
WORKDIR ${BUILDDIR}

RUN apt-get update -qq && \
apt-get upgrade -y  > /dev/null 2>&1 && \
apt-get install wget gcc make zlib1g-dev -y -qq > /dev/null 2>&1 && \
wget --quiet https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz > /dev/null 2>&1 && \
tar zxf Python-${PYTHON_VER}.tgz && \
cd Python-${PYTHON_VER} && \
./configure  > /dev/null 2>&1 && \
make > /dev/null 2>&1 && \
make install > /dev/null 2>&1 && \
rm -rf ${BUILDDIR} 

RUN apt-get install -y poppler-utils ghostscript imagemagick

#image magic
RUN mkdir -p /etc/ImageMagick-6
COPY data/policy.xml /etc/ImageMagick-6/

## add custom .bashrc
COPY data/.bashrc /root/.bashrc

ENTRYPOINT ["/usr/bin/env"]