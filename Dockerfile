# Custom Ubuntu Image with pre installed git
# docker build -t my-custom-ubuntu .
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git