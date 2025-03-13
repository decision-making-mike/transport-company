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
    'single_order_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-orders.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_vehicle_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-vehicles.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_parameter_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-parameters.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_parcel_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-parcels.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_shipment_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-shipments.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_delivery_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-deliveries.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_made_payment_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-made-payments.sql' \
                || exit 1

>> "$data_insertion_times_log_file" \
    echo \
    -n \
    'single_fuel_expense_generation_and_insertion_average_time_in_seconds=' \
        && /bin/time \
        -ao "$data_insertion_times_log_file" \
        -f '%E' \
            psql \
            -U 'postgres' \
            -p "$port" \
            'transport-company' \
            -f 'data-generation-insertion/insert-fuel-expenses.sql' \
                || exit 1
