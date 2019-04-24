# Atlassian Crucible

## Overview

This Docker container makes it easy to get an instance of Crucible up and running.

This dockerfile is based off the [mswinarski/atlassian-crucible](https://hub.docker.com/r/mswinarski/atlassian-crucible) docker image, source code found here: [https://bitbucket.org/mswinarski/atlassian-docker](https://bitbucket.org/mswinarski/atlassian-docker)

## Basic Information

* using OpenJDK 1.8
* application is in /atlassian/apps/crucible
* data is in /atlassian/data/crucible and is set as VOLUME
* application running on port 8080

## Usage

In order to get the latest Crucible image run:

```
docker pull jasonunderhill/atlassian-crucible:latest   
```
then run Crucible with:
```
docker run -d -p 8080:8080 --name crucible1 jasonunderhill/atlassian-crucible:latest
```
or when mapping Crucible data directory (FISHEYE_INST) to /your/crucible/data directory:
```
docker run -d -p 8080:8080 -v /your/crucible/data:/atlassian/data/crucible --name crucible1 jasonunderhill/atlassian-crucible:latest
```
Check in the logs if Crucible is running:
```
docker logs -f crucible1
```
and you should see something like:
```
INFO  - Welcome to Crucible!
INFO  - 
INFO  - You need to configure an admin password and enter your
INFO  - license key. You can do this by accessing FishEye through
INFO  - a web browser, once the server has started:
INFO  - 
INFO  - http://7731b28dd6e3:8080
...
INFO  - Server started on :8080 (http) (control port on 127.0.0.1:8059)
```

## Configuration Options

### Licence

Environment variable names:

* FECRU_CONFIGURE_LICENSE_FISHEYE
* FECRU_CONFIGURE_LICENSE_CRUCIBLE

Example:
```
docker run -d -p 8080:8080 --name crucible1 -e 'FECRU_CONFIGURE_LICENSE_FISHEYE=[fisheye licence]' -e 'FECRU_CONFIGURE_LICENSE_CRUCIBLE=[crucible licence]' jasonunderhill/atlassian-crucible:latest
```
### Admin Password

Environment variable name:

* FECRU_CONFIGURE_ADMIN_PASSWORD

Example:
```
docker run -d -p 8080:8080 --name crucible1 -e 'FECRU_CONFIGURE_ADMIN_PASSWORD=password' jasonunderhill/atlassian-crucible:latest
```
### Database

Environment variable name:

* FECRU_CONFIGURE_DB_TYPE
* FECRU_CONFIGURE_DB_HOST
* FECRU_CONFIGURE_DB_PORT
* FECRU_CONFIGURE_DB_USER
* FECRU_CONFIGURE_DB_PASSWORD

Example:
```
docker run -d -p 8080:8080 --name crucible1 -e 'FECRU_CONFIGURE_DB_TYPE=postgresql' -e 'FECRU_CONFIGURE_DB_HOST=db' -e 'FECRU_CONFIGURE_DB_PORT=5432' -e 'FECRU_CONFIGURE_DB_USER=postgres' -e 'FECRU_CONFIGURE_DB_PASSWORD=password' jasonunderhill/atlassian-crucible:latest
```
