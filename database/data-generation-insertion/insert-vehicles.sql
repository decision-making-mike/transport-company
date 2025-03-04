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
