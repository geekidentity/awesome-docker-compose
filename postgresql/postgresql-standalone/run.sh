#!/usr/bin/env bash

function usage() {
    echo "usage: $0 start|stop|down|restart|status|front"
}

function network_config() {
    case $1 in
    init)
        ;;
    status)
        docker network ls
        ;;
    remove)
        ;;
    *)
        ;;
    esac
}

SERVICE=$2

case $1 in
start)
    docker compose up -d $SERVICE
    ;;
stop)
    docker compose stop $SERVICE
    ;;
down)
    docker compose down
    ;;
restart)
    docker compose restart $SERVICE
    ;;
front)
    docker compose up $SERVICE
    ;;
status)
    docker compose ps $SERVICE
    ;;
enter)
    if [ -z $SERVICE ]; then
        echo "./run.sh enter must specify container name"
        echo "e.g.   ./run.sh enter nginx"
        exit 3
    fi
    docker exec -it $SERVICE /bin/sh
    ;;
*)
    usage
    exit 3
esac
