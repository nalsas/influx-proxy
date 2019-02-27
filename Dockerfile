FROM alpine:3.9
LABEL maintainer="Nalsas Dai <nalsasdai@hotmail.com>"

RUN apk add --no-cache --virtual .build-deps \
    git \
    musl-dev \
    go && \
    export GOPATH=/root/go && \
    export PATH=$PATH:$GOPATH/bin && \
    mkdir -p  $GOPATH/src/github.com/shell909090/influx-proxy/ && \
    cd ~ && git clone https://github.com/nalsas/influx-proxy && cd influx-proxy && git checkout dev && cd .. && \
    cp -r influx-proxy $GOPATH/src/github.com/shell909090/ && \
    go get -u github.com/shell909090/influx-proxy/service && \
    go install github.com/shell909090/influx-proxy/service && \
    mv $GOPATH/bin/service /usr/bin/influxdb-proxy && \
    apk del .build-deps && rm -rf $GOPATH && \
    apk add redis python && \
    redis-server --port 6379 && \
    cd influx-proxy && python config.py
CMD ["/usr/bin/influxdb-proxy -redis localhost:6379"]
