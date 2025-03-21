do $$
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
                -- Selecting vehicle ID at random, with uniform distribution assumed, means the number of parcels for every vehicle approaches the same number as the total number of parcels increases. This I guess to be unlikely in the real world, but a suitable amount given the current lack of information about routes.
                random (
                    1,
                    number_of_vehicles
                ),
                id
                from parcels;
    end;
$$;
