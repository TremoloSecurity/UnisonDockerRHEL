#!/bin/bash

export DISPLAY=:0.0
export TREMOLO_ROOT="/usr/local/tremolo"
export TREMOLO_HOME="$TREMOLO_ROOT/tremolo-service"
export TREMOLO_PROXY_HOME="$TREMOLO_HOME/external/apps/proxy"
export TREMOLO_ADMIN_HOME="$TREMOLO_HOME/external/apps/tremolo-admin"
export TREMOLO_WS_HOME="$TREMOLO_HOME/external/apps/webservices"
export TREMOLO_SSH_KEYS="$TREMOLO_ROOT/.ssh"
export TREMOLO_QUARTZ_DIR="$TREMOLO_HOME/external/conf/quartz"
export TREMOLO_LOG="$TREMOLO_HOME/logs/tremolo.log"
export TREMOLO_ACTIVEMQ="$TREMOLO_HOME/activemq"
export TREMOLO_EXTERNAL="$TREMOLO_HOME/external/ext-lib"


JAVA_CMD=`which java`
if [ ! $JAVA_CMD ]; then
  echo -e "Java could not be found. Please install Java and try again.\n"
  exit 1
fi

export CLASSPATH=$CLASSPATH:$TREMOLO_HOME/libs/*:$TREMOLO_HOME/jars/*:$TREMOLO_HOME/external/ext-lib/*:$TREMOLO_QUARTZ_DIR

TREMOLO_CMD="$JAVA_CMD -Dorg.eclipse.jetty.server.Request.maxFormContentSize=-1 -Dcom.tremolosecurity.openunison.activemqdir=$TREMOLO_ACTIVEMQ -Dcom.tremolosecurity.openunison.quartzdir=$TREMOLO_QUARTZ_DIR $JAVA_OPTS -server com.tremolosecurity.server.Server"

echo "Starting Xvfb..."

#Start Xvfb
/usr/bin/Xvfb :0.0 >& /dev/null &

echo "Starting Unison..."
exec $TREMOLO_CMD 2>&1
