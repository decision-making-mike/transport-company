do
$$
    declare
        service_price_per_kilogram_of_cargo integer
            := random (
                10,
                20
            );
        max_parcel_weight_in_kilograms integer
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
                    'service_price_per_kilogram_of_cargo',
                    service_price_per_kilogram_of_cargo
                ),
                (
                    'max_parcel_weight_in_kilograms',
                    max_parcel_weight_in_kilograms
                );
    end;
$$;
