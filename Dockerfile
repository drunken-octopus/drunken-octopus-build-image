FROM python:3.8.3-buster
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y \
      time \
      ccache \
      git \
      make \
      rename \
      gcc-avr \
      avr-libc \
      gcc-arm-none-eabi && \
  apt-get clean
RUN pip3 install -U platformio

RUN groupadd -g 994 docker
RUN useradd --uid 1000 -m -G docker jenkins

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

USER jenkins
