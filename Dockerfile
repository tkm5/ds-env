FROM ubuntu:latest

# update
RUN apt -y update && apt install -y \
libsm6 \
libxext6 \
libxrender-dev \
libglib2.0-0 \
openssh-client \
git \
sudo \
wget \
tmux \
emacs

#install anaconda3
WORKDIR /opt

# download anaconda package and install anaconda
# archive -> https://repo.anaconda.com/archive
RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh && \
bash /opt/Anaconda3-2022.05-Linux-x86_64.sh -b -p /opt/anaconda3 && \
rm -f Anaconda3-2021.11-Linux-x86_64.sh

# set path
ENV PATH /opt/anaconda3/bin:$PATH

# update pip and conda and install packages
RUN pip install --upgrade pip && \
    pip install tensorflow && \
    # optional pkgs
    pip install kaggle && \
    pip install japanize_matplotlib && \
    apt install zip unzip && \
    pip install slack_sdk && \
    pip install --upgrade jupyterlab jupyterlab-git

WORKDIR /
RUN mkdir /work 

# kaggle settings
RUN mkdir /root/.kaggle 
COPY settings/kaggle.json /root/.kaggle/

# git settings
RUN mkdir /root/.ssh
COPY settings/.ssh /root/.ssh
COPY settings/.gitconfig /root/.gitconfig
COPY .gitignore /root/.gitignore

# jupyter-lab extension settings
RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/ && \
    mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/
COPY settings/themes.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/
COPY settings/tracker.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/

# execute jupyterlab as a default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]