do $$
    declare
        -- If we assumed 1000 orders a day on average, 100 000 orders would mean about 3 months of operation.
        number_of_orders integer := 100000;
        -- If we assumed that PostgreSQL's random() generates every number with the same probability (I'm talking about "assuming" since I don't see any mention of the distribution of random() in the documentation, at https://www.postgresql.org/docs/17/functions-math.html), then, for example, half the orders could be for 900 kg, and the other half for 100 kg, giving 500 kg on average.
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
