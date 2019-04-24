# Original Dockerfile taken from https://bitbucket.org/mswinarski/atlassian-docker

FROM ubuntu:18.04
MAINTAINER Jason Underhill, jason@junderhill.com

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y openjdk-8-jdk

WORKDIR /atlassian

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

#install linux tools
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y mc && \
  apt-get install -y nano && \
  apt-get install -y vim && \
  apt-get install -y tree && \
  apt-get install -y zip && \
  apt-get install -y wget

#install dev tools
RUN apt-get update && \
  apt-get install -y git && \
  apt-get install -y mercurial && \
  apt-get install -y subversion

RUN apt-get -qy autoremove

CMD ["bash"]

ENV LANG C.UTF-8
ENV FECRU_VERSION 4.7.0
ENV FISHEYE_HOME /atlassian/apps/crucible
ENV FISHEYE_INST /atlassian/data/crucible
ENV FISHEYE_OPTS -Dfecru.configure.from.env.variables=true

# Crucible configuration from environment variables
# ENV FECRU_CONFIGURE_LICENSE_FISHEYE=
# ENV FECRU_CONFIGURE_LICENSE_CRUCIBLE=
# ENV FECRU_CONFIGURE_ADMIN_PASSWORD=
# ENV FECRU_CONFIGURE_DB_TYPE=
# ENV FECRU_CONFIGURE_DB_HOST=
# ENV FECRU_CONFIGURE_DB_PORT=
# ENV FECRU_CONFIGURE_DB_NAME=
# ENV FECRU_CONFIGURE_DB_USER=
# ENV FECRU_CONFIGURE_DB_PASSWORD=
# ENV FECRU_CONFIGURE_DB_MIN_POOL_SIZE=
# ENV FECRU_CONFIGURE_DB_MAX_POOL_SIZE=

RUN echo "Atlassian - Crucible ${FECRU_VERSION} applications runtime environment"

WORKDIR /atlassian/apps

# download and install fisheye to /atlassian/apps/fisheye
ADD http://www.atlassian.com/software/crucible/downloads/binary/crucible-${FECRU_VERSION}.zip /atlassian/apps/

RUN unzip crucible-${FECRU_VERSION}.zip && rm crucible-${FECRU_VERSION}.zip
RUN mv fecru-${FECRU_VERSION} crucible
RUN mkdir -p /atlassian/data/crucible

ADD configure.sh ${FISHEYE_HOME}/
RUN chmod +x ${FISHEYE_HOME}/configure.sh
ADD start.sh ${FISHEYE_HOME}/
RUN chmod +x ${FISHEYE_HOME}/start.sh

VOLUME ${FISHEYE_INST}

EXPOSE 8080

WORKDIR ${FISHEYE_HOME}/

CMD ["./start.sh"]
