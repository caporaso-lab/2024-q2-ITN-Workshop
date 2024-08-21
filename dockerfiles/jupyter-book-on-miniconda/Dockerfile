FROM continuumio/miniconda3:latest

ENV DISTRO amplicon
ENV EPOCH 2024.5

ENV PATH /opt/conda/envs/qiime2-amplicon-2024.5/bin:$PATH
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV MPLBACKEND agg
ENV UNIFRAC_USE_GPU N
ENV HOME /home/qiime2
ENV XDG_CONFIG_HOME /home/qiime2

# set working directory
RUN mkdir /home/qiime2
WORKDIR /home/qiime2

# Important: let any UID modify these directories so that
# `docker run -u UID:GID` works
RUN chmod -R a+rwx /home/qiime2

# install qiime2 environment
RUN conda update -q -y conda
RUN conda install -q -y wget
RUN apt-get install -y procps

COPY qiime2-${DISTRO}-ubuntu-latest-conda.yml released-env.yml
RUN conda env create -n qiime2-${DISTRO}-${EPOCH} --file released-env.yml \
    && conda clean -a -y \
    && chmod -R a+rwx /opt/conda \
    && rm released-env.yml

# activate qiime2 environment, set up tab completion, and make qiime2
# environment activate on container startup
RUN /bin/bash -c "source activate qiime2-${DISTRO}-${EPOCH}"
ENV CONDA_PREFIX /home/qiime2/.conda/qiime2-${DISTRO}-${EPOCH}/
RUN qiime dev refresh-cache
RUN echo "source activate qiime2-${DISTRO}-${EPOCH}" >> $HOME/.bashrc
RUN echo "source tab-qiime" >> $HOME/.bashrc

# update cli prompt to print working directory
RUN echo "export PS1=\"\nCurrent working directory: \\w\n\\$ \"" >> $HOME/.bashrc

# install q2-fmt & dependencies
RUN pip install frictionless
RUN pip install git+https://github.com/qiime2/q2-stats.git
RUN pip install git+https://github.com/qiime2/q2-fmt.git

# install jupyter lab
RUN pip install jupyterlab

# declare that a volume will be mounted to the working directory
VOLUME "/home/qiime2"

# make default jupyter shell be bash
ENV SHELL /bin/bash

# install various useful tools
RUN apt-get update
RUN yes | apt-get install tree vim iputils-ping nano less

# copy starting workshop data into image
RUN mkdir workshop-input-data
COPY feature-table.qza workshop-input-data/feature-table.qza
COPY sample-metadata.tsv workshop-input-data/sample-metadata.tsv

# launch jupyter lab on startup
CMD ["jupyter", "lab", \
    "--ip=0.0.0.0", \
    "--port=8888", \
    "--no-browser", \
    "--allow-root", \
    "--NotebookApp.token=''"]
