psql -h 192.168.6.215 -U postgres

CREATE ROLE replicator login replication password 'Aa123456';

pg_basebackup -F p --progress -D /app/postgresql-archive -h 192.168.6.215 -p 5432 -U replicator --password