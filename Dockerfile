FROM alpine:3.9
MAINTAINER nalsas <nalsasdai@hotmail.com>

ENV REDIS_SERVER=localhost
ENV REDIS_PORT=6379
ENV CONFIG=/etc/influxdb-proxy/config.py

ADD docker/start.sh /start.sh

RUN apk add --no-cache --virtual .build-deps \
    git \
    musl-dev \
    go && \
    export GOPATH=/root/go && \
    export PATH=$PATH:$GOPATH/bin && \
    mkdir -p  $GOPATH/src/github.com/shell909090/influx-proxy/ && \
    cd ~ && git clone https://github.com/nalsas/influx-proxy && cd influx-proxy && git checkout master && mkdir /etc/influxdb-proxy && cp config.py /etc/influxdb-proxy/ && cd .. && \
    cp -r influx-proxy $GOPATH/src/github.com/shell909090/ && \
    go get -u github.com/shell909090/influx-proxy/service && \
    go install github.com/shell909090/influx-proxy/service && \
    mv $GOPATH/bin/service /usr/bin/influxdb-proxy && \
    apk del .build-deps && rm -rf $GOPATH && \
    apk add redis python py-pip && pip install redis

CMD ["/start.sh"]
