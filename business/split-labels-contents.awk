#!/bin/awk

# TODO Fix cases like the printing of "of the" on a separate line.

function get_longest_element_length( array, n )
{
    max = 0
    max_index = -1
    for( n = 1 ; n <= length( array ) ; ++n )
    {
        if( max < length( array[ n ] ) )
        {
            max = length( array[ n ] )
            max_index = n
        }
    }
    return max
}
{
    if( $0 !~ /^[ ]*\[label="[^"]*"\]$/ )
    {
        print
    }
    else
    {
        split( $0, line_parts, "\"" )
        label_text = line_parts[ 2 ]
        split( label_text, words, " " )
        if( length( words ) == 1 )
        {
            print
            next
        }
        for( k = 2 ; k <= length( words ) ; ++k )
        {
            # The condition includes all the articles.
            if( length( words[ k - 1 ] ) <= 3 )
            {
                words[ k - 1 ] = words[ k - 1 ] " " words[ k ]
                words[ k ] = ""
                ++k
            }
        }
        # For cases like "A good place to work in"
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
                ++k
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
            ++k
        }
        n = 1
        for( k = 1 ; k <= length( words ) ; ++k )
        {
            if( words[ k ] != "" )
            {
                words1[ n ] = words[ k ]
                ++n
            }
        }
        printf( line_parts[ 1 ] "\"" )
        for( k = 1 ; k <= length( words1 ) ; ++k )
        {
            printf( words1[ k ] )
            if( k < length( words1 ) )
            {
                printf( "\n" )
            }
        }
        print "\"" line_parts[ 3 ]
        # We get rid of the arrays for it seems AWK does not do it itself after processing a line.
        delete line_parts
        delete words
        delete words1
    }
}
