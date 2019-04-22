#!/bin/sh
if [[ "$REDIS_SERVER" == "localhost" ]] ; then
    redis-server --port $REDIS_PORT &
fi
python $CONFIG -H $REDIS_SERVER -p $REDIS_PORT -j /etc/influxdb-proxy/config.json
/usr/bin/influxdb-proxy -redis $REDIS_SERVER:$REDIS_PORT
