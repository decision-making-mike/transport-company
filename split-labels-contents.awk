#!/bin/awk

# The "n" and "max" variables are specified as parameters only for making them local.
function get_longest_element_length( array, n, max )
{
    max = 0
    for( n = 1 ; n <= length( array ) ; ++ n )
    {
        if( max < length( array[ n ] ) )
        {
            max = length( array[ n ] )
        }
    }
    return max
}
{
    if( $0 !~ /^[ ]*\[label ?= ?".*"\]$/ )
    {
        print
    }
    else
    {
        split( $0, line_parts, "=" )
        sub( /^ ?"/, "", line_parts[ 2 ] )
        sub( /"\]/, "", line_parts[ 2 ] )
        label_content = line_parts[ 2 ]
        split( label_content, words, " " )
        if( length( words ) == 1 )
        {
            print
            next
        }
        # The code below handles all the articles, among others.
        n = 1
        for( k = 1 ; k <= length( words ) ; ++ k )
        {
            if( length( words[ k ] ) > 3 )
            {
                for( m = n + 1 ; m <= k ; ++ m )
                {
                    words[ n ] = words[ n ] " " words[ m ]
                    words[ m ] = ""
                }
                n = k + 1
            }
        }
        # For cases like "A good place to work in", where the last word is too short to be on a separate line.
        if( length( words[ length( words ) ] ) >= 1 && length( words[ length( words ) ] ) <= 3 )
        {
            n = length( words ) - 1
            # We check if "n > 1" because the content of the label might consists of spaces only, and then all the words would be empty strings.
            while( n > 1 && words[ n ] == "" )
            {
                --n
            }
            words[ n ] = words[ n ] " " words[ length( words ) ]
            words[ length( words ) ] = ""
        }
        k = 2
        while( k <= length( words ) )
        {
            if( words[ k ] == "" || words[ k - 1 ] == "" )
            {
                ++ k
                continue
            }
            longest_length = get_longest_element_length( words )
            if( length( words[ k ] ) + length( words[ k - 1 ] ) <= longest_length || length( words[ k - 1 ] ) <= 3 )
            {
                words[ k - 1 ] = words[ k - 1 ] " " words[ k ]
                words[ k ] = ""
                k = 2
                continue
            }
            ++ k
        }
        n = 1
        for( k = 1 ; k <= length( words ) ; ++ k )
        {
            if( words[ k ] != "" )
            {
                words1[ n ] = words[ k ]
                ++ n
            }
        }
        printf( line_parts[ 1 ] "=\"" )
        for( k = 1 ; k <= length( words1 ) ; ++ k )
        {
            printf( words1[ k ] )
            if( k < length( words1 ) )
            {
                printf( "\\n" )
            }
        }
        print "\"]"
        # We get rid of the arrays for it seems AWK does not do it itself after processing a line.
        delete line_parts
        delete words
        delete words1
    }
}
