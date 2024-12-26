FROM --platform=linux/amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y; \
    apt install -y build-essential cmake gcc gcc-arm-none-eabi libnewlib-arm-none-eabi \
    wget tar git

WORKDIR /opt

RUN git clone --recursive --depth 1 --branch 1.5.1 https://github.com/raspberrypi/pico-sdk

## NB: patch tinyusb
RUN sed -i 's/OSAL_TIMEOUT_WAIT_FOREVER/OSAL_TIMEOUT_NORMAL/g' ./pico-sdk/lib/tinyusb/src/tusb.c; \
    cat ./pico-sdk/lib/tinyusb/src/tusb.c | grep osal_mutex

ENV PICO_SDK_PATH=/opt/pico-sdk

workdir /root