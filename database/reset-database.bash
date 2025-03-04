#!/bin/bash

set -eo 'pipefail'

port="$1"
if [[ -z "$port" ]]
then port=5432
fi
data_insertion_times_log_file="$2"
tables_creation_file='create-tables.sql'
data_insertion_file='insert-data.bash'

if [[ ! -f "$tables_creation_file" || ! -f "$data_insertion_file" ]]
then
    echo 1>&2 "File missing error"
    exit 1
fi

psql \
        -U 'postgres' \
        -p "$port" \
        'template1' \
        -c 'drop database "transport-company";' \
        -c 'create database "transport-company";' \
    || {
        echo 1>&2 "Error when dropping or creating the database, exiting"
        exit 1
    }

psql \
        -U 'postgres' \
        -p "$port" \
        'transport-company' \
        -f "$tables_creation_file" \
    || {
        echo 1>&2 "Error when creating tables, exiting"
        exit 1
    }

bash \
    "$data_insertion_file" \
    "$port" \
    "$data_insertion_times_log_file" \
        || {
            echo 1>&2 "Error when inserting data, exiting"
            exit 1
        }
