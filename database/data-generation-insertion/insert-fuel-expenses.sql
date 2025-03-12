do
$$
    declare
        count integer := 10000;
        max_amount integer := 500;
        min_amount integer := 100;
        amount integer;
        k integer;
    begin
        for k in 1..count loop
            amount := random (min_amount, max_amount);
            insert
                into fuel_expenses (amount)
                values (amount);
        end loop;
    end;
$$;
