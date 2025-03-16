do
$$
    declare
        service_price_per_kg_of_cargo integer
            := random (
                10,
                20
            );
        max_parcel_weight_in_kg integer
            := random (
                5,
                50
            );
    begin
        insert
            into
                parameters (
                    name,
                    value
                )
            values
                (
                    'service_price_per_kg_of_cargo',
                    service_price_per_kg_of_cargo
                ),
                (
                    'max_parcel_weight_in_kg',
                    max_parcel_weight_in_kg
                );
    end;
$$;
