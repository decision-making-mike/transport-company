do $$
    declare
        max_parcel_weight_in_kilograms integer
            := (
                select value
                    from parameters
                        where name = 'max_parcel_weight_in_kilograms'
            );
    begin
        insert
            into parcels (order_id)
            select id
                from orders
                    cross join
                        generate_series (
                            1,
                            cast (
                                ceiling (
                                    total_cargo_weight_in_kilograms
                                    / cast (max_parcel_weight_in_kilograms as double precision)
                                )
                                as integer
                            )
                        );
    end;
$$
