do
$$
    begin
        insert
            into deliveries (shipment_id)
            select id
            from shipments;
    end;
$$;
