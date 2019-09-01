FROM resin/rpi-raspbian:stretch

# Original: https://github.com/andresvidal/rpi3-mongodb3

LABEL created_by=https://github.com/mlsmrc/Docker-Mongo-RPi
LABEL binaries=https://andyfelong.com/2017/08/mongodb-3-0-14-for-raspbian-stretch
LABEL mongod_version=3.0.14

# Process binaries
ADD bin/mongodb_stretch_3_0_14_core.tar.gz /usr/bin/
ADD bin/mongodb_stretch_3_0_14_tools.tar.gz /usr/bin/

# Add mongodb user
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

# Copy files into the container
COPY entrypoint.sh /data/entrypoint.sh
COPY initDB.mongo  /data/initDB.mongo
COPY mongod.conf /etc/mongod.conf

# Create directory and assign ownership / adding entrypoint file
RUN mkdir -p \
    /data/db \
    /data/configdb \
    /var/log/mongodb \
    /docker-entrypoint-initdb.d \
&& chown -R mongodb:mongodb \
    /usr/bin/mongo* \
    /data/db \
    /data/configdb \
    /var/log/mongodb \
    /docker-entrypoint-initdb.d/ \
&&  chmod +x /data/entrypoint.sh

# Define mountable directories
VOLUME /data/db /data/configdb

# Define working directory
WORKDIR /data

# Expose ports
# - 27017: process
# - 28017: http
EXPOSE 27017
EXPOSE 28017

ENTRYPOINT ["/bin/sh","-c","./entrypoint.sh"]