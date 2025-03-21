create
    table orders (
        id integer primary key generated always as identity,
        total_cargo_weight_in_kilograms integer not null
    );

create
    table vehicles (
        id integer primary key generated always as identity,
        max_cargo_weight_in_kilograms integer not null
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

create
    table shipments (
        id integer primary key generated always as identity,
        vehicle_id integer not null references vehicles,
        parcel_id integer not null references parcels
    );

create
    table deliveries (
        id integer primary key generated always as identity,
        shipment_id integer not null references shipments
    );

create
    table made_payments (
        id integer primary key generated always as identity,
        amount integer not null
    );

create
    table fuel_expenses (
        id integer primary key generated always as identity,
        amount integer not null
    );
