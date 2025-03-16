do
$$
    declare
        number_of_rows integer := 10000;
        min_amount integer := 100;
        max_amount integer := 500;
    begin
        insert
            into fuel_expenses (amount)
            select random (min_amount, max_amount)
            from generate_series (1, number_of_rows);
    end;
$$;
