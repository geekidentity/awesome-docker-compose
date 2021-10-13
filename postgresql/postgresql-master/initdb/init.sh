#!/usr/bin/env bash

psql -U postgres -c "CREATE ROLE replicator login replication password 'Aa123456';"

psql -U postgres -c "create user smartlink with password 'Aa123456';"

psql -U postgres -c "create database smartlink_sqc owner smartlink;"

psql -U postgres -c "create database smartlink_auth owner smartlink;"


psql -U smartlink -d smartlink_sqc -f /var/lib/sql/smartlink-sqc-db.sql

psql -U smartlink -d smartlink_auth -f /var/lib/sql/smartlink_auth.sql

psql -U smartlink -d smartlink_auth -f /var/lib/sql/smartlink_auth_deploy_initialize.sql