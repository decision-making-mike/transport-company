do
$$
    declare
        number_of_rows integer
            := 1000;
        max_total_cargo_weight_in_kg integer
            := 1000;
    begin
        insert
            into orders (total_cargo_weight_in_kg)
            select
                random (
                    1,
                    max_total_cargo_weight_in_kg
                )
            from
                generate_series (
                    1,
                    number_of_rows
                );
    end;
$$;
