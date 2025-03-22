do $$
    declare
        percentage_of_parcels_in_transit double precision := 0.1;
    begin
        insert
            into deliveries (shipment_id)
                select id
                    from shipments
                    where random () >= percentage_of_parcels_in_transit;
    end;
$$;
