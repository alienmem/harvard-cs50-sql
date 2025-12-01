--Your task at hand is to create a SQLite database for Union Square Donuts from scratch, as by writing a set of CREATE TABLE statements in a schema.sql file. The implementation details are up to you, though you should minimally ensure that your database meets the team’s expectations and that it can represent the sample data.


CREATE TABLE "ingredients" (
    "id" INTEGER,
    "ingredient" TEXT NOT NULL,
    "price_per_unit" REAL NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" INTEGER NOT NULL,
    "price_per_donut" REAL NOT NULL,
     PRIMARY KEY("id")
);

CREATE TABLE "customers" (
    "customer_id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("customer_id")
);

CREATE TABLE "orders" (
    "order_number" INTEGER,
    "customer" INTEGER NOT NULL,
    "number_donuts" INTEGER NOT NULL,
    PRIMARY KEY("order_number"),
    FOREIGN KEY ("customer") REFERENCES "customers"("customer_id")
);

CREATE TABLE "ingdonuts" (
    "id_ingredients" INTEGER,
    "id_donuts" INTEGER,
    PRIMARY KEY("id_ingredients", "id_donuts"),
    FOREIGN KEY("id_ingredients") REFERENCES "ingredients"("id"),
    FOREIGN KEY("id_donuts") REFERENCES "donuts"("id")
);

CREATE TABLE "orderdonuts" (
    "id_donuts" INTEGER NOT NULL,
    "id_order" INTEGER NOT NULL,
    PRIMARY KEY("id_donuts", "id_order"),
    FOREIGN KEY("id_donuts") REFERENCES "donuts"("id"),
    FOREIGN KEY("id_order") REFERENCES "orders"("order_number")
);
