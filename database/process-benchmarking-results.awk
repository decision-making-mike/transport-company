BEGIN {
    FS = "="
}
{
    name = $1
    time = $2

    split( time , time_pieces , ":" )
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

    total_times[ name ] += total_seconds
    ++ counts[ name ]
}
END {
    row_count[ "single_order_generation_and_insertion_average_time_in_seconds" ] = 1000
    row_count[ "single_vehicle_generation_and_insertion_average_time_in_seconds" ] = 10000
    row_count[ "single_parameter_generation_and_insertion_average_time_in_seconds" ] = 2
    row_count[ "single_parcel_generation_and_insertion_average_time_in_seconds" ] = 1000 * ( 1 + int( ( 1 / 50 + 1000 / 5 ) / 2 ) )
    row_count[ "single_shipment_generation_and_insertion_average_time_in_seconds" ] = 1000
    row_count[ "single_delivery_generation_and_insertion_average_time_in_seconds" ] = 1000
    row_count[ "single_made_payment_generation_and_insertion_average_time_in_seconds" ] = 2000
    row_count[ "single_fuel_expense_generation_and_insertion_average_time_in_seconds" ] = 10000
    for ( name in total_times ) {
        average = total_times[ name ] / counts[ name ]
        normalized_average = average / row_count[ name ]
        printf( "%s is %f.\n" , name , normalized_average )
    }
}
