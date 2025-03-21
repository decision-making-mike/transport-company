do $$
    declare
        -- It seems reasonable to assume 1 refueling per 1 transit.
        number_of_refuelings integer := (
            select count (*)
                from shipments
        );
        -- If we assumed all vehicles' being trucks and having tank capacity of slightly more than 200 liters on average, and that an average refueling is 200 liters, then, for example, 600 of an expense would mean a price of 3 per 1 liter (the lack of currency is intentional). So, a range of 400 to 600 means some service stations charge less than 3, which I find a reasonable assumption.
        min_fuel_expense_amount integer := 400;
        max_fuel_expense_amount integer := 600;
    begin
        insert
            into fuel_expenses (amount)
            select
                random (
                    min_amount,
                    max_amount
                )
                from
                    generate_series (
                        1,
                        number_of_refuelings
                    );
    end;
$$;
