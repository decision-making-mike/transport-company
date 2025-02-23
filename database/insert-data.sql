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
