# README for ds-lab

## Overview

This repository contains the necessary configuration files to set up a data science lab environment using Docker. The environment includes JupyterLab, Anaconda3, and other essential tools for data science.

## Prerequisites

- Docker
- Docker Compose

## Setup for Apple Silicon Mac Users

If you are using an Apple Silicon Mac, you need to set the Docker default platform to `linux/x86_64` before starting the containers. Run the following command:

```shell
export DOCKER_DEFAULT_PLATFORM=linux/x86_64
```

## Building and Running the DS-Lab Environment
1. Clone this repository:
    ```shell
    git clone https://github.com/tkm5/ds-env.git
    cd ds-env
    git checkout ds-env
    ```
2. Build and start the DS-Lab container:
    ```shell
    docker-compose up
    ```
    Once the container is up and running, you can access JupyterLab by navigating to `http://localhost:8888` in your web browser.

## Directory Structure
- The `Dockerfile` contains the instructions to build the DS-Lab Docker image.
- The `docker-compose.yml` file defines the services, networks, and volumes for the DS-Lab environment.
- The `docker/work` directory on your host machine is mapped to the `/work` directory inside the container. You can place your notebooks and data files in this directory to access them from JupyterLab.

## Customizing JupyterLab Settings
The provided configuration files allow you to customize JupyterLab's appearance and behavior. The settings are located in the `settings` directory and are copied to the appropriate locations inside the container during the build process.

## Conclusion
This DS-Lab environment provides a consistent and reproducible workspace for data science projects. If you encounter any issues or have suggestions for improvements, please raise an issue or submit a pull request.
