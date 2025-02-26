#!/bin/bash

set -eo 'pipefail'

port="$1"
if [[ -z "$port" ]]
then port=5432
fi

echo '=============='
echo 'Table "Orders"'
echo '=============='
psql \
        -U 'postgres' \
        -p "$port" \
        'transport-company' \
        -c "select * from orders limit 10;" \
    || {
        echo 1>&2 "Error when performing query, exiting"
        exit 1
    }

echo '================'
echo 'Table "Vehicles"'
echo '================'
psql \
        -U 'postgres' \
        -p "$port" \
        'transport-company' \
        -c "select * from vehicles limit 10;" \
    || {
        echo 1>&2 "Error when performing query, exiting"
        exit 1
    }

echo '=================='
echo 'Table "Parameters"'
echo '=================='
psql \
        -U 'postgres' \
        -p "$port" \
        'transport-company' \
        -c "select * from parameters;" \
    || {
        echo 1>&2 "Error when performing query, exiting"
        exit 1
    }

echo '=================='
echo 'Table "Parcels"'
echo '=================='
psql \
        -U 'postgres' \
        -p "$port" \
        'transport-company' \
        -c "select * from parcels limit 10;" \
    || {
        echo 1>&2 "Error when performing query, exiting"
        exit 1
    }
