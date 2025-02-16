#!/bin/bash

sed_commands='
s/\[label="responsibility=transportation department"\]/[style="bold"]/;
s/\[label="responsibility=finance department"\]/[style="dashed"]/;
s/\[label="responsibility=customer service department"\]/[style="filled"]/;
s/\[label="responsibility=human resources department"\]/[style="diagonals"]/;
s/\[label="responsibility=it department"\]/[style="dotted"]/;
s/\[label="responsibility=top management"\]/[style="solid"]/;
'

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
                    sed \
                            "$sed_commands" \
                            "$file_path" \
                        | awk \
                            --file split-labels-contents.awk
                ) \
                > "${file_path}.png"
        done

# ./ instead of . for readability
eog \
    --fullscreen \
    ./
