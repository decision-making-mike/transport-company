do $$
    declare
        -- 1000 seems a good number of vehicles for a big company with operations in many countries, provided I haven't defined what a "vehicle" should mean. Most of the time it means a truck to me, but as I see it now, it could be a truck, a drone, a train, even a ship (Wikipedia says in https://en.wikipedia.org/wiki/Vehicle that "[t]he term 'vehicle' (…) more broadly also includes (…) watercraft (ships, boats and underwater vehicles) (…)"). If we assumed 20 countries, there would be 50 vehicles in an average country.
        number_of_vehicles integer := 1000;
        min_max_cargo_weight_in_kilograms integer := 10;
        max_max_cargo_weight_in_kilograms integer := 10000;
    begin
        insert
            into vehicles (max_cargo_weight_in_kilograms)
                select
                    random (
                        min_max_cargo_weight_in_kilograms,
                        max_max_cargo_weight_in_kilograms
                    )
                    from
                        generate_series (
                            1,
                            number_of_vehicles
                        );
    end;
$$;
