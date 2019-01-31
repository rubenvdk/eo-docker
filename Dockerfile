FROM ubuntu:bionic
WORKDIR /
RUN apt-get update && \
    apt-get install -y python3 python3-pip gdal-bin && \
    pip3 install numpy rasterio matplotlib
