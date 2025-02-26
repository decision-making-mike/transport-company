-- Generation and insertion of orders.

do
$$
    declare
        count integer := 1000;
        max_total_cargo_weight_in_kg integer := 1000;
        total_cargo_weight_in_kg integer;
        k integer;
    begin
        for k in 1..count loop
            total_cargo_weight_in_kg := random (1, max_total_cargo_weight_in_kg);
            insert
                into orders (total_cargo_weight_in_kg)
                values (total_cargo_weight_in_kg);
        end loop;
    end;
$$;

-- Generation and insertion of vehicles.

do
$$
    declare
        count integer := 10000;
        k integer;
    begin
        for k in 1..count loop
            insert
                into vehicles
                default values;
        end loop;
    end;
$$;

-- Generation and insertion of parameters.

do
$$
    declare
        service_price integer := random (100, 200);
        max_parcel_weight_in_kg integer := random (5, 50);
    begin
        insert
            into parameters (name, value)
            values
                ('service_price', service_price),
                ('max_parcel_weight_in_kg', max_parcel_weight_in_kg);
    end;
$$;

-- Generation and insertion of parcels.

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
$$
