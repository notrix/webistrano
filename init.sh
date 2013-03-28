#! /bin/bash

# WEBISTRANO
# Maintainer: @jverdeyen
# App Version: 1.0

### BEGIN INIT INFO
# Provides:          webistrano
# Required-Start:    $local_fs $remote_fs $network $syslog redis-server
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Webistrano automated deploys
# Description:       Webistrano automated deploys
### END INIT INFO


APP_ROOT="/opt/webistrano/"
DAEMON_OPTS="-c $APP_ROOT/config/unicorn.rb -E production -D"
NAME="webistrano"
DESC="Webistrano service"
PID="$APP_ROOT/tmp/pids/unicorn.pid"
USER="YOUR_USERNAME_OR_ROOT_WHATEVER_YOU_LIKE"

case "$1" in
  start)
        CD_TO_APP_DIR="cd $APP_ROOT"
        START_DAEMON_PROCESS="bundle exec unicorn_rails $DAEMON_OPTS"
  
	echo -n "Starting $DESC: "	
 	if [ `whoami` = root ]; then
          su - $USER -c "$CD_TO_APP_DIR > /dev/null 2>&1 && $START_DAEMON_PROCESS"
        else
          $CD_TO_APP_DIR > /dev/null 2>&1 && $START_DAEMON_PROCESS
        fi
        #$CD_TO_APP_DIR && $START_DAEMON_PROCESS
        echo "$NAME."
        ;;
  stop)
        echo -n "Stopping $DESC: "
        kill -QUIT `cat $PID`
        echo "$NAME."
        ;;
  restart)
        echo -n "Restarting $DESC: "
        kill -USR2 `cat $PID`
        echo "$NAME."
        ;;
  reload)
        echo -n "Reloading $DESC configuration: "
        kill -HUP `cat $PID`
        echo "$NAME."
        ;;
  *)
        echo "Usage: $NAME {start|stop|restart|reload}" >&2
        exit 1
        ;;
esac

exit 0
