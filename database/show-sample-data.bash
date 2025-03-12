#!/bin/bash

set \
-e \
-o 'pipefail'

port="$1"

if [[ -z "$port" ]]
then port=5432
fi

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo orders' \
-c 'select * from orders limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo vehicles' \
-c 'select * from vehicles limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo parameters' \
-c 'select * from parameters;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo parcels' \
-c 'select * from parcels limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo shipments' \
-c 'select * from shipments limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo deliveries' \
-c 'select * from deliveries limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo made_payments' \
-c 'select * from made_payments limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }

psql \
-U 'postgres' \
-p "$port" \
'transport-company' \
-c '\echo fuel_expenses' \
-c 'select * from fuel_expenses limit 10;' \
    || {
        >&2 echo 'Error when performing query, exiting'

        exit 1
    }
