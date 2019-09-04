# Docker-Mongo-RPi
This is a MongoDB Docker conteiner created specifically for Raspberry Pi.

It's the `3.0.14` version on MongoDB.

## Usage

```
docker push theoriginaltonystark/mongo-rpi:latest

docker run -p 27017:27017 -e MONGO_INITDB_DATABASE=your_init_db \
-e MONGO_INITDB_ROOT_USERNAME=your_root_id \
-e MONGO_INITDB_ROOT_PASSWORD=root_id_pwd \
--name give_a_name \
theoriginaltonystark/mongo-rpi
```

## Environment parameter

This Docker image has three environmental parameters that can be set during the `docker run command`.

```
MONGO_INITDB_DATABASE = your initial database
MONGO_INITDB_ROOT_USERNAME = your root id
MONGO_INITDB_ROOT_PASSWORD = your root id password
```

Those env parameters are optional. In case you want to use them, you have to specify all of them.

## Special folders

The folder `/docker-entrypoint-initdb.d/` is the special folder that this Docker has as usually.

Every file within that folder will be used during the initial startup using the logic below.

| File extension | Command |
| :--- | :--- | 
| .sh | `$f` | Just running `$f` as normal bash script | 
| .js | `mongo admin $f` |
| . mongo | `cat $f | mongo` | 

## Logic

1. Starting mongod deamon
* Handling initial `MONGO_INITDB_*` environment parameters
* Handling files within `/docker-entrypoint-initdb.d/`
* Restarting mongod


## Credits

* bin files are from [github.com/andresvidal](https://github.com/andresvidal/rpi3-mongodb3)
* travis build suggestions are from [blog.hypriot.com](https://blog.hypriot.com/post/setup-simple-ci-pipeline-for-arm-images/)

