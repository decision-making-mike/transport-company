{
    table_name = $1
    time = $2
    getline next_line

    split( \
        time , \
        time_pieces , \
        ":" \
    )
    if ( length( time_pieces ) == 3 ) {
        hours = time_pieces[ 1 ]
        minutes = time_pieces[ 2 ]
        seconds = time_pieces[ 3 ]
    } else {
        hours = 0
        minutes = time_pieces[ 1 ]
        seconds = time_pieces[ 2 ]
    }

    total_seconds = seconds + minutes * 60 + hours * 3600

    total_times[ table_name ] += total_seconds
    ++ measurement_counts[ table_name ]

    total_row_counts[ table_name ] += next_line
    next
}
END {
    printf( "Total times.\n\n" )
    printf( "| Table. | Total time.\n" )
    printf( "| - | -\n" )
    for ( table_name in total_times ) {
        printf( \
            "| `%s` | %f\n" , \
            table_name , \
            total_times[ table_name ] \
        )
    }
    printf( "\n" )
    printf( "Measurement averages\n\n" )
    printf( "| Table. | Number of measurements. | Average time per 1 measurement.\n" )
    printf( "| - | - | -\n" )
    for ( table_name in total_times ) {
        average = total_times[ table_name ] / measurement_counts[ table_name ]
        printf( \
            "| `%s` | %d | %f\n" , \
            table_name , \
            measurement_counts[ table_name ] , \
            average \
        )
    }
    printf( "\n" )
    printf( "Row averages.\n\n" )
    printf( "| Table. | Total number of inserted rows. | Average time per 1 row.\n" )
    printf( "| - | - | -\n" )
    for ( table_name in total_times ) {
        normalized_average = total_times[ table_name ] / total_row_counts[ table_name ]
        printf( \
            "| `%s` | %d | %f\n" , \
            table_name , \
            total_row_counts[ table_name ] , \
            normalized_average \
        )
    }
}
