FROM ubuntu:latest

USER root
RUN apt-get update
RUN apt-get install sudo apt-utils  -y
RUN apt-get install python software-properties-common  -y
RUN apt-get install git curl xvfb  -y
RUN apt-get install libglib2.0-0 libgtk-3-0 -y
RUN apt-get install psmisc -y
RUN apt-get install locales locales-all -y
ENV LC_ALL en_US.UTF-8
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
USER docker
WORKDIR /home/docker/project
ENTRYPOINT ["/entrypoint.sh"]
