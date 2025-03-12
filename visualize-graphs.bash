#!/bin/bash

find \
-name '*.dot' \
-print0 \
    | \
        while
            read \
            -d '' \
            file_path
        do
            > "${file_path}.png" \
            dot \
            -T 'png' \
            <( \
                awk \
                --file 'split-labels-contents.awk' \
                "$file_path"
            )
        done

find \
-name '*.png' \
-print0 \
    | \
        grep \
        --null-data \
        --invert-match \
        '/archive/' \
    | \
        xargs \
        --null \
            eog \
            -f
