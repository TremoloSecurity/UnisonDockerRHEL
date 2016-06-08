FROM rhel7

MAINTAINER Tremolo Security, Inc. - Docker <docker@tremolosecurity.com>

LABEL Name Unison
LABEL Version 1.0.7
LABEL Release 2016-06-08
LABEL Vendor Tremolo Security, Inc.
LABEL RUN /usr/bin/docker run -d registry-tremolosecurity/unison-rhel:1.0.7




EXPOSE 9090
EXPOSE 8080
EXPOSE 8443
EXPOSE 9093

ENV UNISON_VERSION 1.0.7
ENV MYSQL_JDBC_VERSION 5.1.38



USER root
ADD scripts/firstStart.sh /tmp/firstStart.sh
ADD scripts/startUnisonInDocker.sh /tmp/startUnisonInDocker.sh
ADD conf/log4j2.xml /tmp/log4j2.xml

RUN   yum -y install yum-utils && \
  yum-config-manager --enable rhel-7-server-optional-rpms rhel-7-server-extras-rpms && \
  yum -y install wget which;cd /etc/yum.repos.d;wget https://www.tremolosecurity.com/docs/tremolosecurity-docs/configs/tremolosecurity-beta.repo;yum -y install unison-$UNISON_VERSION && \
  userdel tremoloadmin && \
  groupadd -r tremoloadmin -g 433 && \
  useradd  -u 431 -r -g tremoloadmin -d /usr/local/tremolo/tremolo-service -s /sbin/nologin -c "Unison Docker image user" tremoloadmin && \
  mv /tmp/log4j2.xml /usr/local/tremolo/tremolo-service/conf/log4j2.xml && \
  mkdir /tmp/drivers && \
  cd /tmp/drivers && \
  curl -L -O http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar && \
  mkdir /usr/local/tremolo/tremolo-service/external && \
  mv /tmp/firstStart.sh /usr/local/tremolo/tremolo-service/bin/ && \
  mv /tmp/startUnisonInDocker.sh /usr/local/tremolo/tremolo-service/bin/ && \
  chmod +x /usr/local/tremolo/tremolo-service/bin/startUnisonInDocker.sh && \
  chmod +x /usr/local/tremolo/tremolo-service/bin/firstStart.sh && \
  chown -R tremoloadmin:tremoloadmin /usr/local/tremolo && \
  chmod -R ugo+rw /usr/local/tremolo && \
  chmod -R ugo+rw /tmp/drivers && \
  yum -y clean all

VOLUME /usr/local/tremolo/tremolo-service/external


USER 431
WORKDIR /usr/local/tremolo/tremolo-service
ENV JAVA_OPTS -XX:+UseParallelGC  -Djava.security.egd=file:/dev/./urandom


CMD /usr/local/tremolo/tremolo-service/bin/firstStart.sh
