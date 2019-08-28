#!/bin/bash

DIR=/home/nat/mosquitto-repo

CONTAINER_NAME=mosquitto

VOL_LOG=mosquitto_log 
VOL_DATA=mosquitto_data
VOL_PASSWD=mosquitto_passwd

docker volume create $VOL_LOG
docker volume create $VOL_DATA

docker volume create $VOL_PASSWD 
# docker inspect mosquitto -f {{.HostConfig.Binds}}
docker run -d -it --restart=always -p 1883:1883 -p 9001:9001 --name $CONTAINER_NAME \
	-v $DIR/mosquitto.conf:/mosquitto/config/mosquitto.conf\
	-v $VOL_DATA:/mosquitto/data\
	-v $VOL_PASSWD:/mosquitto/passwords\
       	-v $VOL_LOG:/mosquitto/log\
       	eclipse-mosquitto

docker cp "$DIR/user-space/passwd" mosquitto:/mosquitto/passwords/
docker inspect $CONTAINER_NAME -f {{.HostConfig.Binds}}
#sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"
#sudo sh -c "ls -ahl /var/lib/docker/containers/*/*-json.log"
