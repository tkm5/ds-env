FROM ubuntu:latest

# update
RUN apt -y update && apt install -y \
libsm6 \
libxext6 \
libxrender-dev \
libglib2.0-0 \
sudo \
wget \
vim

#install anaconda3
WORKDIR /opt
# download anaconda package and install anaconda
# archive -> https://repo.continuum.io/archive/
RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
sh /opt/Anaconda3-2021.05-Linux-x86_64.sh -b -p /opt/anaconda3 && \
rm -f Anaconda3-2021.05-Linux-x86_64.sh
# set path
ENV PATH /opt/anaconda3/bin:$PATH

# update pip and conda and install packages
RUN pip install --upgrade pip && \
    pip install tensorflow && \
    pip install kaggle && \
    pip install tf-nightly && \
    pip install opencv-python && \
    pip install nibabel && \
    pip install pystan==2.19.1.1 && \
    apt install -y libgl1-mesa-dev

WORKDIR /
RUN mkdir /work && \
    mkdir /root/.kaggle && \
    mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/

# black theme and line number display settings
RUN echo '{"theme":"JupyterLab Dark"}' > /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

# execute jupyterlab as a default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]