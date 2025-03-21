do $$
    declare
        -- Given the lack of currency, the range to generate the service price should be treated as random, even if the result price will happen to resemble some real-world service prices.
        service_price_per_kilogram_of_cargo integer
            := random (
                1,
                10
            );
        -- If we assumed the company operates drones and trucks, then the less maximum parcel weight, the more the company would be going to use drones, and the less trucks. The term "parcel" shall mean any "unit", so it may refer to a 1-kg cardboard box, as well as to a 1000-kg EUR-pallet.
        max_parcel_weight_in_kilograms integer
            := random (
                500,
                1000
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
