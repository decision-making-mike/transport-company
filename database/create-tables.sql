create
    table orders (
        id integer primary key generated always as identity,
        total_cargo_weight_in_kg integer not null
    );
