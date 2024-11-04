FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime AS base

# Install project dependencies
# -------------------------------------------------------------------------------------------- #

# OpenCV & mysqlclient dependencies
RUN apt update && apt install -y \
        build-essential \
        default-libmysqlclient-dev \
        ffmpeg \
        libsm6 \
        libxext6 \
        pkg-config \
        python3-dev \
        # python3-pip \
    && apt clean

COPY ./requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip \
        pip install -r requirements.txt

# Create an user
# -------------------------------------------------------------------------------------------- #
ENV UID 1000
ENV GID 1000

RUN addgroup --gid ${GID} --system user && \
    adduser --shell /bin/bash --disabled-password --uid ${UID} --system --group user

# ENTRYPOINT
# -------------------------------------------------------------------------------------------- #
USER user
COPY . /home/user/ws
WORKDIR /home/user/ws
CMD ["sleep","infinity"]