FROM ubuntu:latest

# update
RUN apt-get update && apt-get install -y \
	sudo \
	wget \
	vim

# install anaconda3
WORKDIR /opt

# download anaconda package and install anaconda
# archive -> https://repo.continuum.io/archive/
RUN wget https://repo.continuum.io/archive/Anaconda3-2020.11-Linux-x86_64.sh && \
	sh Anaconda3-2020.11-Linux-x86_64.sh -b -p /opt/anaconda3 && \
	rm -f Anaconda3-2020.11-Linux-x86_64.sh

# set path
ENV PATH /opt/anaconda3/bin:$PATH

# install nodejs (you have to need enable jupyter extension)
# RUN conda install -y nodejs

# update pip and conda
RUN pip install --upgrade pip

WORKDIR /
RUN mkdir /work

# execute jupyterlab as a default command
CMD ["jupyter" , "lab" , "--ip=0.0.0.0" , "--allow-root" , "--LabApp.token=''"]