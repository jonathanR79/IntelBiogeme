FROM continuumio/miniconda3:latest

ENV ACCEPT_INTEL_PYTHON_EULA=yes
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONDONTWRITEBYTECODE=true


RUN apt-get update && apt-get install -y --no-install-recommends \
    && apt-get install -y -q g++ --no-install-recommends\
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN conda update conda \
    && conda config --add channels intel\
    && conda install  -y -q intelpython3_core=2021.3.1 python=3 \
    && conda install -c intel -y jupyter_core \
    && conda install -c intel -y cython \
    && conda install -c intel -y unidecode \
    && conda install -c intel -y pandas \
    && conda install mkl-devel \
    && conda install -c conda-forge -y jupyterlab \
    && conda clean -afy

RUN pip install biogeme

RUN mkdir /app
WORKDIR /app

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook","--ip=0.0.0.0","--allow-root", "--no-browser"]
