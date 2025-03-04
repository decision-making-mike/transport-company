do
$$
    declare
        parcel_array integer [] := array (
            select id
            from parcels
        );
        parcel_array_length integer := array_length (
            parcel_array,
            1
        );
        vehicle_count integer := (
            select count (*)
            from vehicles
        );
        k integer;
        vehicle_id integer;
    begin
        for k in 1..parcel_array_length loop
            vehicle_id := random (1, vehicle_count);
            insert
                into shipments (vehicle_id, parcel_id)
                values (vehicle_id, k);
        end loop;
    end;
$$;
