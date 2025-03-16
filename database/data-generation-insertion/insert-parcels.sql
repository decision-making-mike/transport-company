do
$$
    declare
        max_parcel_weight_in_kg integer
            := (
                select value
                from parameters
                where
                    name
                    = 'max_parcel_weight_in_kg'
            );
    begin
        insert
            into parcels (order_id)
            select id
            from orders
            cross join generate_series (
                1,
                cast (
                    ceiling (
                        total_cargo_weight_in_kg
                        / max_parcel_weight_in_kg
                    )
                    as integer
                )
            );
    end;
$$
