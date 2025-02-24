-- Generation and insertion of orders.

do
$$
    declare
        count integer := 10000;
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
                ("service_price", service_price),
                ("max_parcel_weight_in_kg", max_parcel_weight_in_kg);
    end;
$$;
