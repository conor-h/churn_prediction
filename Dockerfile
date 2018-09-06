FROM ubuntu:18.04

RUN apt-get update && apt-get install --no-install-recommends -y \
        build-essential \
        git \
        && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

ENV MCND https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
ENV PATH /root/miniconda/bin:$PATH

RUN wget "$MCND" -O miniconda.sh && bash miniconda.sh -b -p /root/miniconda && \
        conda install dask jupyter seaborn scikit-learn -y && \
        conda clean -ay && \
        rm miniconda.sh


EXPOSE 8888
WORKDIR /
CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='demo'
