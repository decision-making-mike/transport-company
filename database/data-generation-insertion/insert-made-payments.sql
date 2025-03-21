do $$
    declare
        service_price_per_kilogram_of_cargo integer := (
            select value
                from parameters
                where name = 'service_price_per_kilogram_of_cargo'
        );
    begin
        insert
            into made_payments (amount)
                -- Advances.
                select
                    total_cargo_weight_in_kilograms
                    * service_price_per_kilogram_of_cargo
                    from orders
            union all
                -- Remaining money to pay for the service. The multiplication by "count" is to provide a reasonable differentiation between an advance and the remaining money to pay for the service. I don't know yet how a business should differentiate them.
                select
                    total_cargo_weight_in_kilograms
                    * service_price_per_kilogram_of_cargo
                    * count (shipments.id)
                    from orders
                        join parcels
                            on parcels.order_id = orders.id
                        join shipments
                            on shipments.parcel_id = parcels.id
                    group by total_cargo_weight_in_kilograms;
    end;
$$;
