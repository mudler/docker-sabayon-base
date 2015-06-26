#!/bin/bash

mkdir -p /var/lib/entropy/client/database/amd64
cd /var/lib/entropy/client/database/amd64
cat /equo.sql | sqlite3 equo.db

# remove files used to generate a correct equo db
rm -rfv /equo.sql
rm -rfv /generate-equo-db.sh
