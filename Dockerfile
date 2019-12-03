FROM ubuntu:latest

USER root
RUN apt-get update
RUN apt-get install --no-install-recommends sudo apt-utils  -y
RUN apt-get install --no-install-recommends python software-properties-common  -y
RUN apt-get install --no-install-recommends git curl xvfb  -y
RUN apt-get install --no-install-recommends libglib2.0-0 libgtk-3-0 -y
RUN apt-get install --no-install-recommends psmisc -y
RUN apt-get install --no-install-recommends locales locales-all -y

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV SUBLIME_TEXT_VERSION=3

ENV DISPLAY=:1
COPY xvfb /etc/init.d/xvfb
RUN chmod +x /etc/init.d/xvfb
COPY docker.sh /docker.sh
RUN chmod +x /docker.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod 666 /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# for github actions
RUN sudo mkdir -p /github
RUN sudo chown -R docker:docker /github

USER docker
RUN mkdir -p /home/docker/project
RUN mkdir -p /github/home
RUN mkdir -p /github/workspace
RUN mkdir -p /github/workflow

WORKDIR /home/docker/project
ENTRYPOINT ["/entrypoint.sh"]
