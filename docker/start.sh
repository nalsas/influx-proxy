#!/bin/bash
if [[ "$REDIS_SERVER" == "localhost" ]] ; then
    redis-server --port $REDIS_PORT
fi
python $CONFIG
/usr/bin/influxdb-proxy -redis $REDIS_SERVER:$REDIS_PORT

