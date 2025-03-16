do
$$
    declare number_of_rows integer := 10000;
    begin
        -- Note empty "select" list. We want only the default value of the column "id" to be inserted. Details at https://www.postgresql.org/docs/current/sql-select.html.
        insert
            into vehicles
            select
            from generate_series (1, number_of_rows);
    end;
$$;
