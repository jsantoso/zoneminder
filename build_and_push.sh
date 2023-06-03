#!/bin/bash

docker login

docker pull ubuntu:22.04

docker build -t jsantoso/zoneminder:latest .

docker push jsantoso/zoneminder:latest
