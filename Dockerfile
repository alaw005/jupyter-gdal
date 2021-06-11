FROM jupyter/minimal-notebook

USER root

RUN apt-get update && apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntugis/ppa && apt-get update
RUN apt-get install gdal-bin -y && apt-get install libgdal-dev -y
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && export C_INCLUDE_PATH=/usr/include/gdal

USER $NB_USER

RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') && \
    pip install --upgrade jupyterlab jupyterlab-git
