do
$$
    declare
        number_of_orders integer := 100000;
        max_total_cargo_weight_in_kilograms integer := 1000;
    begin
        insert
            into orders (total_cargo_weight_in_kilograms)
            select
                random (
                    1,
                    max_total_cargo_weight_in_kilograms
                )
            from
                generate_series (
                    1,
                    number_of_orders
                );
    end;
$$;
