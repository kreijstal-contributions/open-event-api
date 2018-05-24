FROM python:3.6-slim
LABEL maintainer="Niranjan Rajendran <me@niranjan.io>"

ENV INSTALL_PATH /open_event
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

# apt-get update and update some packages
RUN apt-get update && apt-get install -y wget git ca-certificates curl && update-ca-certificates && apt-get clean -y


# install deps
RUN apt-get install -y --no-install-recommends build-essential python3-dev libpq-dev libevent-dev libmagic-dev && apt-get clean -y

# copy just requirements
COPY requirements.txt requirements.txt
COPY requirements requirements

# install requirements
RUN pip3 install --no-cache-dir -r requirements.txt 
RUN pip3 install eventlet

# copy remaining files
COPY . .

CMD bash scripts/docker_run.sh
