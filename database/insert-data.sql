-- Generation and insertion of orders.

do
$$
    declare
        count integer := 1000;
        max_total_cargo_weight_in_kg integer := 1000;
        total_cargo_weight_in_kg integer;
        k integer;
    begin
        for k in 1..count loop
            total_cargo_weight_in_kg := random (1, max_total_cargo_weight_in_kg);
            insert
                into orders (total_cargo_weight_in_kg)
                values (total_cargo_weight_in_kg);
        end loop;
    end;
$$;

-- Generation and insertion of vehicles.

do
$$
    declare
        count integer := 10000;
        k integer;
    begin
        for k in 1..count loop
            insert
                into vehicles
                default values;
        end loop;
    end;
$$;

-- Generation and insertion of parameters.

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

-- Generation and insertion of parcels.

do
$$
    declare
        max_parcel_weight_in_kg integer := (
            select value
            from parameters
            where name = 'max_parcel_weight_in_kg'
        );
        k integer;
        m integer;
        parcel_count integer;
        total_cargo_weight_in_kg_array integer [] := array (
            select total_cargo_weight_in_kg
            from orders
        );
        total_cargo_weight_in_kg_array_length integer := array_length (
            total_cargo_weight_in_kg_array,
            1
        );
    begin
        for k in 1..total_cargo_weight_in_kg_array_length loop
            parcel_count := ceiling (total_cargo_weight_in_kg_array [k] / max_parcel_weight_in_kg);
            for m in 1..parcel_count loop
                insert
                    into parcels (order_id)
                    values
                        (k);
            end loop;
        end loop;
    end;
$$;

-- Generation and insertion of shipments.

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

-- Generation and insertion of deliveries.

do
$$
    begin
        insert
            into deliveries (shipment_id)
            select id
            from shipments;
    end;
$$;

-- Generation and insertion of made payments.

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
