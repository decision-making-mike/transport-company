do
$$
    declare
        service_price integer := (
            select value
            from parameters
            where name = 'service_price'
        );
        total_cargo_weight_in_kg_array integer [] := array (
            select total_cargo_weight_in_kg
            from orders
        );
        total_cargo_weight_in_kg_array_length integer := array_length (
            total_cargo_weight_in_kg_array,
            1
        );
        k integer;
        advance integer;
        order_shipment_count integer;
        remaining_money_to_pay_for_the_service integer;
    begin
        for k in 1..total_cargo_weight_in_kg_array_length loop
            advance := total_cargo_weight_in_kg_array [k] * service_price;
            order_shipment_count := (
                select count (shipments.id)
                from orders
                    join parcels
                        on parcels.order_id = orders.id
                    join shipments
                        on shipments.parcel_id = parcels.id
                where orders.id = k
            );
            remaining_money_to_pay_for_the_service :=
                total_cargo_weight_in_kg_array [k]
                * service_price
                * order_shipment_count;
            insert
                into made_payments (amount)
                values
                    (advance),
                    (remaining_money_to_pay_for_the_service);
        end loop;
    end;
$$;
