#!/bin/bash

DIR=/home/nat/mosquitto-repo

CONTAINER_NAME=mosquitto 

VOL_LOG=mosquitto_log 
VOL_USER=mosquitto_userspace

docker volume create $VOL_LOG
docker volume create $VOL_USER
# docker inspect mosquitto -f {{.HostConfig.Binds}}
docker run -d -it --restart=always -p 1883:1883 -p 9001:9001 --name $CONTAINER_NAME \
	-v $DIR/mosquitto.conf:/mosquitto/config/mosquitto.conf \
	-v $VOL_USER:/mosquitto/userspace \
       	-v $VOL_LOG:/mosquitto/log \
       	eclipse-mosquitto

docker cp "$DIR/user-space/passwd" mosquitto:/mosquitto/userspace/
docker cp "$DIR/user-space/bridges.d" mosquitto:/mosquitto/userspace/
docker inspect $CONTAINER_NAME -f {{.HostConfig.Binds}}

docker restart mosquitto
docker logs -f mosquitto
#sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log" 
#sudo sh -c "ls -ahl /var/lib/docker/containers/*/*-json.log"
