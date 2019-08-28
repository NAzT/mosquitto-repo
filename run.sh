#!/bin/bash

docker volume create mosquitto_log 
docker volume create mosquitto_data

DIR=/home/nat/mosquitto-repo
docker run  -d -it --restart=always -p 1883:1883 -p 9001:9001 --name mosquitto -v $DIR/mosquitto.conf:/mosquitto/config/mosquitto.conf -v mosquitto_data:/mosquitto/data -v mosquitto_log:/mosquitto/log eclipse-mosquitto
