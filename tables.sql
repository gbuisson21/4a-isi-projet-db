PRAGMA foreign_keys = ON;

CREATE TABLE products
(
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    price_cents INTEGER NOT NULL CHECK (price_cents >= 0), /* Price in cents to avoid floating point issues with SQLite */
    stock       INTEGER NOT NULL CHECK (stock >= 0),
    active      INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0, 1))
);

CREATE TABLE menus
(
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    price_cents INTEGER NOT NULL CHECK (price_cents >= 0), /* Price in cents to avoid floating point issues with SQLite */
    start_date  TEXT    NOT NULL, /* 'YYYY-MM-DD' : first day the menu is available */
    end_date    TEXT    NOT NULL, /* 'YYYY-MM-DD' : last day the menu is available (= start_date for a one-day menu) */
    active      INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0, 1)),
    CHECK (end_date >= start_date)
);

CREATE TABLE menu_items
(
    id         INTEGER PRIMARY KEY,
    menu_id    INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    UNIQUE (menu_id, product_id),
    FOREIGN KEY (menu_id) REFERENCES menus (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE TABLE users
(
    id     INTEGER PRIMARY KEY,
    name   TEXT    NOT NULL,
    admin  INTEGER NOT NULL DEFAULT 0 CHECK (admin IN (0, 1)),
    locked INTEGER NOT NULL DEFAULT 0 CHECK (locked IN (0, 1))
);

CREATE TABLE user_auth
(
    id            INTEGER PRIMARY KEY,
    username      TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL, /* bcrypt/argon2id, sel inclus dans le hash */
    FOREIGN KEY (id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE orders
(
    id                INTEGER PRIMARY KEY,
    user_id           INTEGER NOT NULL,
    total_price_cents INTEGER NOT NULL CHECK (total_price_cents >= 0),
    status            TEXT    NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'confirmed', 'ready', 'completed', 'cancelled')),
    reservation_date  TEXT, /* 'YYYY-MM-DD HH:MM:SS' -> No Date type in SQLite*/
    created_at        TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE order_items
(
    id               INTEGER PRIMARY KEY,
    order_id         INTEGER NOT NULL,
    product_id       INTEGER NOT NULL,
    quantity         INTEGER NOT NULL CHECK (quantity > 0),
    unit_price_cents INTEGER NOT NULL CHECK (unit_price_cents >= 0), /* Price in cents to avoid floating point issues with SQLite */
    UNIQUE (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE TABLE order_menu
(
    id               INTEGER PRIMARY KEY,
    order_id         INTEGER NOT NULL,
    menu_id          INTEGER NOT NULL,
    quantity         INTEGER NOT NULL CHECK (quantity > 0),
    unit_price_cents INTEGER NOT NULL CHECK (unit_price_cents >= 0),  /* Price in cents to avoid floating point issues with SQLite */
    UNIQUE (order_id, menu_id),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menus (id)
);

CREATE TABLE closings
(
    id           INTEGER PRIMARY KEY,
    closing_date TEXT NOT NULL UNIQUE, /* 'YYYY-MM-DD' -> No Date type in SQLite*/
    reason       TEXT /* Optional reason shown in the planning */
);

CREATE INDEX idx_orders_user ON orders (user_id);
CREATE INDEX idx_orders_reservation ON orders (reservation_date);
CREATE INDEX idx_menus_dates ON menus (start_date, end_date);