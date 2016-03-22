#!/bin/bash

if [ ! "$(ls -A /usr/local/tremolo/tremolo-service/apps/proxy/auth)" ] ; then
  mv /usr/local/tremolo/tremolo-service/stash/apps-proxy-auth/* /usr/local/tremolo/tremolo-service/apps/proxy/auth/
fi

if [ ! "$(ls -A /usr/local/tremolo/tremolo-service/conf)" ] ; then
  mv /usr/local/tremolo/tremolo-service/stash/conf/* /usr/local/tremolo/tremolo-service/conf/
fi

if [ ! "$(ls -A /usr/local/tremolo/tremolo-service/apps/proxy/WEB-INF)" ] ; then
  mv /usr/local/tremolo/tremolo-service/stash/apps-proxy-WEB-INF/* /usr/local/tremolo/tremolo-service/apps/proxy/WEB-INF/
fi

if [ ! "$(ls -A /usr/local/tremolo/tremolo-service/apps/tremolo-admin/WEB-INF)" ] ; then
  mv /usr/local/tremolo/tremolo-service/stash/apps-tremolo-admin-WEB-INF/* /usr/local/tremolo/tremolo-service/apps/tremolo-admin/WEB-INF/
fi

if [ ! "$(ls -A /usr/local/tremolo/tremolo-service/apps/webservices/WEB-INF)" ] ; then
  mv /usr/local/tremolo/tremolo-service/stash/webservices-WEB-INF/* /usr/local/tremolo/tremolo-service/apps/webservices/WEB-INF/
fi

rm -rf /usr/local/tremolo/tremolo-service/stash
exec /usr/local/tremolo/tremolo-service/bin/startUnisonInDocker.sh
