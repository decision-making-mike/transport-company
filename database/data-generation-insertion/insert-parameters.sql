do
$$
    declare
        service_price integer := random (100, 200);
        max_parcel_weight_in_kg integer := random (5, 50);
    begin
        insert
            into parameters (name, value)
            values
                ('service_price', service_price),
                ('max_parcel_weight_in_kg', max_parcel_weight_in_kg);
    end;
$$;
