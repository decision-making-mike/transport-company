create
    table orders (
        id integer primary key generated always as identity,
        total_cargo_weight_in_kg integer not null
    );

create
    table vehicles (
        id integer primary key generated always as identity
    );

create
    table parameters (
        id integer primary key generated always as identity,
        name varchar,
        value varchar
    );

create
    table parcels (
        id integer primary key generated always as identity,
        order_id integer not null references orders
    );
