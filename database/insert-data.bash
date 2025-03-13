#!/bin/bash

set \
-e \
-o 'pipefail'

port="$1"

if [[ -z "$port" ]]
then port=5432
fi

data_insertion_times_log_file="$2"

if [[ -z "$data_insertion_times_log_file" ]]
then data_insertion_times_log_file='/dev/null'
fi

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'orders ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-orders.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from orders;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'vehicles ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-vehicles.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from vehicles;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'parameters ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-parameters.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from parameters;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'parcels ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-parcels.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from parcels;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'shipments ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-shipments.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from shipments;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'deliveries ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-deliveries.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from deliveries;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'made_payments ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-made-payments.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from made_payments;' \
                        || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'fuel_expenses ' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        --format '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-fuel-expenses.sql' \
                && >> "$data_insertion_times_log_file" \
                    psql \
                    --no-align \
                    --quiet \
                    --tuples-only \
                    --username postgres \
                    'transport-company' \
                    --command 'select count (*) from fuel_expenses;' \
                        || exit 1
