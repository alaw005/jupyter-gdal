ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="alaw005 <alaw005@gmail.com>"

USER root

# Install software properties to allow add-apt-repository
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    software-properties-common 
    
# Install OS dependencies for gdal
RUN add-apt-repository ppa:ubuntugis/ppa && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    gdal-bin \
    libgdal-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to jovyan user
USER ${NB_UID}

# Install Python 3 gdal pacakges
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && \
    export C_INCLUDE_PATH=/usr/include/gdal
RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}')

# Install Python 3 other packages
RUN pip install --upgrade jupyterlab jupyterlab-git

