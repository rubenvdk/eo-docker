# FROM jupyter/scipy-notebook:41e066e5caa8
FROM jupyter/pyspark-notebook:65761486d5d3

USER root

RUN apt-get update && \
    apt-get install -y gdal-bin

USER jovyan

RUN pip install rasterio shapely pyshp tqdm sentinelsat pytest && \
    conda install -y gdal
    echo "install.packages('rgdal',repos='https://cran.rstudio.com', configure.args=c('--with-gdal-config=/opt/conda/bin/gdal-config','--with-proj-include=/opt/conda/include','--with-proj-lib=/opt/conda/lib','--with-proj-share=/opt/conda/share/proj/'))" | R --no-save && \
    echo "install.packages('raster',repos='https://cran.rstudio.com')" | R --no-save && \
    echo "install.packages('tidyverse',repos='https://cran.rstudio.com')" | R --no-save && \
    echo "install.packages('gdalUtils',repos='https://cran.rstudio.com')" | R --no-save

# ENTRYPOINT ["tini", "-g", "--"]
# CMD ["start-notebook.sh"]
