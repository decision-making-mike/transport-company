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

a1=(
    'orders '
    'vehicles '
    'parameters '
    'parcels '
    'shipments '
    'deliveries '
    'made_payments '
    'fuel_expenses '
)

a2=(
    'data-generation-insertion/insert-orders.sql'
    'data-generation-insertion/insert-vehicles.sql'
    'data-generation-insertion/insert-parameters.sql'
    'data-generation-insertion/insert-parcels.sql'
    'data-generation-insertion/insert-shipments.sql'
    'data-generation-insertion/insert-deliveries.sql'
    'data-generation-insertion/insert-made-payments.sql'
    'data-generation-insertion/insert-fuel-expenses.sql'
)

a3=(
    'select count (*) from orders;'
    'select count (*) from vehicles;'
    'select count (*) from parameters;'
    'select count (*) from parcels;'
    'select count (*) from shipments;'
    'select count (*) from deliveries;'
    'select count (*) from made_payments;'
    'select count (*) from fuel_expenses;'
)

for (( k = 0 ; k < "${#a1}" ; ++k ))
do
    >> "$data_insertion_times_log_file" \
        echo \
        -n \
        "${a1[k]}" \
            && /bin/time \
            -ao "$data_insertion_times_log_file" \
            --format '%E' \
                psql \
                -U 'postgres' \
                -p "$port" \
                'transport-company' \
                -f "${a2[k]}" \
                    && >> "$data_insertion_times_log_file" \
                        psql \
                        --no-align \
                        --quiet \
                        --tuples-only \
                        --username postgres \
                        'transport-company' \
                        --command "${a3[k]}" \
                            || exit 1
done
