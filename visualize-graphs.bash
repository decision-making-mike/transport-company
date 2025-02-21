#!/bin/bash

find \
        -name '*.dot' \
        -print0 \
    | while
        read \
            -d '' \
            file_path
        do
            dot \
                -T 'png' \
                <( \
                    awk \
                        --file split-labels-contents.awk \
                        "$file_path"
                ) \
                > "${file_path}.png"
        done

find \
        -name '*.png' \
        -print0 \
    | grep \
        --null-data \
        --invert-match \
        '/archive/' \
    | xargs \
        --null \
        eog \
            -f
