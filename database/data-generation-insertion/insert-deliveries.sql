do $$
    declare
        average_vehicle_max_cargo_weight_in_kilograms integer
            := (
                select avg (max_cargo_weight_in_kilograms)
                    from vehicles
            );
        average_number_of_parcels_in_transit_per_vehicle_in_transit integer
            := random (
                0,
                average_vehicle_max_cargo_weight_in_kilograms
            );
        total_number_of_vehicles integer
            := (
                select count (*)
                    from vehicles
            );
        number_of_vehicles_in_transit integer
            := random (
                0,
                total_number_of_vehicles
            );
        number_of_parcels_in_transit integer
            := average_number_of_parcels_in_transit_per_vehicle_in_transit
            * number_of_vehicles_in_transit;
        total_number_of_parcels integer
            := (
                select count (*)
                    from parcels
            );
        percentage_of_parcels_in_transit integer
            := number_of_parcels_in_transit / total_number_of_parcels;
    begin
        insert
            into deliveries (shipment_id)
                select id
                    from shipments
                    where random () >= percentage_of_parcels_in_transit;
    end;
$$;
