#!/bin/bash

set \
-e \
-o 'pipefail'

get_queries_results_sql_file='get-queries-results.sql'

if [[ ! -f "$get_queries_results_sql_file" ]]
then
    >&2 \
    echo \
    'File missing error'

    exit \
    1
fi

psql \
-U 'postgres' \
'transport-company' \
-f "$get_queries_results_sql_file" \
    || {
        >&2 \
        echo \
        'Error when dropping or creating the database, exiting'

        exit \
        1
    }
