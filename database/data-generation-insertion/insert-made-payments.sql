do
$$
    declare
        service_price_per_kg_of_cargo integer := (
            select value
            from parameters
            where name = 'service_price_per_kg_of_cargo'
        );
    begin
        insert
            into made_payments (amount)
                -- Advances.
                select
                    total_cargo_weight_in_kg
                    * service_price_per_kg_of_cargo
                from orders
            union all
                -- Remaining money to pay for the service.
                select
                    total_cargo_weight_in_kg
                    * service_price_per_kg_of_cargo
                    * count (shipments.id)
                from orders
                    join parcels
                        on parcels.order_id = orders.id
                    join shipments
                        on shipments.parcel_id = parcels.id
                group by total_cargo_weight_in_kg;
    end;
$$;
