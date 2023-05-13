#!/usr/bin/env bash

function usage() {
    echo "usage: $0 start|stop|down|restart|recreate|status|front"
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
recreate)
    docker compose down
    docker compose up -d $SERVICE
    ;;
front)
    docker compose up $SERVICE
    ;;
status)
    docker compose ps $SERVICE
    ;;
*)
    usage
    exit 3
esac
