ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="alaw005 <alaw005@gmail.com>"

USER root

# Install all OS dependencies for gdal
RUN add-apt-repository ppa:ubuntugis/ppa && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    software-properties-common \
    gdal-bin \
    libgdal-dev

# Install Python gdal 
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && \
    export C_INCLUDE_PATH=/usr/include/gdal && \
    pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}')

# Install other Python packages
RUN pip install --upgrade jupyterlab jupyterlab-git

# Switch back to jovyan user
USER ${NB_UID}