#!/bin/bash

DIR=/home/nat/mosquitto-repo

CONTAINER_NAME=mosquitto
VOL_LOG=mosquitto_log 
VOL_DATA=mosquitto_data
docker volume create $VOL_LOG
docker volume create $VOL_DATA

# docker inspect mosquitto -f {{.HostConfig.Binds}}
docker run  -d -it --restart=always -p 1883:1883 -p 9001:9001 --name $CONTAINER_NAME -v $DIR/mosquitto.conf:/mosquitto/config/mosquitto.conf -v $VOL_DATA:/mosquitto/data -v $VOL_LOG:/mosquitto/log eclipse-mosquitto

docker inspect $CONTAINER_NAME -f {{.HostConfig.Binds}}
#sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"
