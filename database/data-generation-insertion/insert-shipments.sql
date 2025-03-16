do
$$
    declare
        number_of_vehicles integer := (
            select count (*)
            from vehicles
        );
    begin
        insert
            into
                shipments (
                    vehicle_id,
                    parcel_id
                )
            select
                random (
                    1,
                    number_of_vehicles
                ),
                id
            from parcels;
    end;
$$;
