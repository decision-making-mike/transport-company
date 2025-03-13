#!/bin/bash

set \
-e \
-o 'pipefail'

log="$1"

port=5432

if [[ -z "$log" ]]
then
    >&2 echo 'Error, log file not provided, exiting'

    exit 1
fi

data_insertion_file='reset-database.bash'

benchmarking_results_processing_file='process-benchmarking-results.awk'

if [[ ! -f "$data_insertion_file" || ! -f "$benchmarking_results_processing_file" ]]
then
    >&2 echo 'Error, file missing, exiting'

    exit 1
fi

for (( k = 0 ; k < 10 ; ++k ))
do
    bash \
    "$data_insertion_file" \
    "$port" \
    "$log"
done

gawk \
-f "$benchmarking_results_processing_file" \
"$log"
