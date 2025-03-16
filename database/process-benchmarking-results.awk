{
    table_name = $1
    time = $2
    getline next_line

    split( \
        time , \
        time_pieces , \
        ":" \
    )
    if( length( time_pieces ) == 3 ){
        hours = time_pieces[ 1 ]
        minutes = time_pieces[ 2 ]
        seconds = time_pieces[ 3 ]
    }else{
        hours = 0
        minutes = time_pieces[ 1 ]
        seconds = time_pieces[ 2 ]
    }

    total_seconds = seconds + minutes * 60 + hours * 3600

    if( FILENAME == ARGV[ 1 ] ){
        total_times_before_optimization[ table_name ] += total_seconds
        ++ numbers_of_measurements_before_optimization[ table_name ]
        number_of_measurements_before_optimization \
            = numbers_of_measurements_before_optimization[ table_name ]
        total_row_counts_before_optimization[ table_name ] += next_line
    }else{
        total_times_after_optimization[ table_name ] += total_seconds
        ++ numbers_of_measurements_after_optimization[ table_name ]
        number_of_measurements_after_optimization \
            = numbers_of_measurements_after_optimization[ table_name ]
        total_row_counts_after_optimization[ table_name ] += next_line
    }

    next
}

END{
    if( length( total_times_after_optimization ) == 0 ){
        printf( "Number of measurements = %d\n" , number_of_measurements_before_optimization )
        printf( "\n" )
        printf( "| Table. | Average time per 1 row (seconds).\n" )
        printf( "| - | -\n" )
    }else{
        printf( "Number of measurements before optimization = %d\n" , number_of_measurements_before_optimization )
        printf( "Number of measurements after optimization = %d\n" , number_of_measurements_after_optimization )
        printf( "\n" )
        printf( "| Table. | Average time per 1 row before optimization (seconds). | Average time per 1 row after optimization (seconds). | Change percent.\n" )
        printf( "| - | - | - | -\n" )
    }
    for( table_name in total_times_before_optimization ){
        average_before_optimization \
            = total_times_before_optimization[ table_name ] \
            / total_row_counts_before_optimization[ table_name ]
        if( length( total_times_after_optimization ) == 0 ){
            printf( \
                "| `%s` | %f\n" , \
                table_name , \
                average_before_optimization \
            )
        }else{
            average_after_optimization \
                = total_times_after_optimization[ table_name ] \
                / total_row_counts_after_optimization[ table_name ]
            printf( \
                "| `%s` | %f | %f | %.0f\n" , \
                table_name , \
                average_before_optimization , \
                average_after_optimization , \
                ( average_before_optimization - average_after_optimization ) \
                    / average_before_optimization \
                    * 100 \
            )
        }
    }
}
