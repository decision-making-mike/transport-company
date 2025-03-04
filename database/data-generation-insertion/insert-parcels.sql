do
$$
    declare
        max_parcel_weight_in_kg integer := (
            select value
            from parameters
            where name = 'max_parcel_weight_in_kg'
        );
        k integer;
        m integer;
        parcel_count integer;
        total_cargo_weight_in_kg_array integer [] := array (
            select total_cargo_weight_in_kg
            from orders
        );
        total_cargo_weight_in_kg_array_length integer := array_length (
            total_cargo_weight_in_kg_array,
            1
        );
    begin
        for k in 1..total_cargo_weight_in_kg_array_length loop
            parcel_count := ceiling (total_cargo_weight_in_kg_array [k] / max_parcel_weight_in_kg);
            for m in 1..parcel_count loop
                insert
                    into parcels (order_id)
                    values
                        (k);
            end loop;
        end loop;
    end;
$$;
