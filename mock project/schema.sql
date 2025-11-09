-- Tony's Titanic Titles
-- Represents a video store chain's core model

-- Stores basic information about each customer.
CREATE TABLE Customers (
    customer_id INTEGER,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    address TEXT,
    PRIMARY KEY(customer_id)
);

-- Tracks membership status of customers, including type and start/end dates.
CREATE TABLE Memberships (
    membership_id INTEGER,
    customer_id INTEGER NOT NULL,
    membership_type TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY(membership_id),
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

-- Represents the video store locations in the chain.
CREATE TABLE Stores (
    store_id INTEGER,
    store_name TEXT NOT NULL,
    location TEXT NOT NULL,
    PRIMARY KEY(store_id)
);

-- Defines product categories like Movie, Snack, Beverage, or Merchandise.
CREATE TABLE Categories (
    category_id INTEGER,
    name TEXT UNIQUE NOT NULL,
    PRIMARY KEY(category_id)
);

-- Lists valid movie formats such as VHS, DVD, Blu-Ray, and 4K UHD.
CREATE TABLE Formats (
    format_id INTEGER,
    name TEXT UNIQUE NOT NULL,
    PRIMARY KEY(format_id)
);

-- Centralized list of all sellable and rentable items in the store.
CREATE TABLE Products (
    product_id INTEGER,
    name TEXT NOT NULL,
    category_id INTEGER NOT NULL,
    description TEXT,
    price DECIMAL(6,2) NOT NULL,
    is_new INTEGER DEFAULT 1,
    is_rentable INTEGER DEFAULT 0,
    PRIMARY KEY(product_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Associates movie products with a specific format (e.g., Titanic on Blu-Ray).
CREATE TABLE ProductFormats (
    product_format_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    product_id INTEGER NOT NULL,
    format_id INTEGER NOT NULL,
    UNIQUE(product_id, format_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (format_id) REFERENCES Formats(format_id)
);

-- Tracks the stock quantity of each movie format or product in each store.
CREATE TABLE Inventory (
    inventory_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    store_id INTEGER NOT NULL,
    product_format_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    UNIQUE(store_id, product_format_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_format_id) REFERENCES ProductFormats(product_format_id)
);

-- Represents a rental transaction made by a member for a specific movie format.
CREATE TABLE Rentals (
    rental_id INTEGER,
    customer_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL
    product_format_id INTEGER NOT NULL,
    rental_date DATE DEFAULT CURRENT_DATE,
    due_date DATE,
    return_date DATE,
    PRIMARY KEY(rental_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_format_id) REFERENCES ProductFormats(product_format_id)
);

-- Records a product sale, which may be made by either a member or non-member.
CREATE TABLE Sales (
    sale_id INTEGER,
    customer_id INTEGER,
    product_id INTEGER NOT NULL,
    sale_date DATE DEFAULT CURRENT_DATE,
    quantity INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY(sale_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Logs payments made by customers for rentals or purchases.
CREATE TABLE Payments (
    payment_id INTEGER,
    customer_id INTEGER NOT NULL,
    payment_type TEXT NOT NULL,
    amount DECIMAL(6,2) NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
    rental_id INTEGER,
    sale_id INTEGER,
    PRIMARY KEY(payment_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);


--                  VIEWS


-- Displays available products in stock per store and their formats.
CREATE VIEW View_Available_Inventory AS
SELECT 
    s.store_name,
    p.name AS product,
    f.name AS format,
    i.quantity
FROM Inventory i
JOIN Stores s ON i.store_id = s.store_id
JOIN ProductFormats pf ON i.product_format_id = pf.product_format_id
JOIN Products p ON pf.product_id = p.product_id
LEFT JOIN Formats f ON pf.format_id = f.format_id
WHERE i.quantity > 0;

-- Shows all rentals that have not yet been returned by the due date.
CREATE VIEW View_Current_Rentals AS
SELECT 
    c.full_name AS customer,
    p.name AS movie,
    f.name AS format,
    r.rental_date,
    r.due_date
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN ProductFormats pf ON r.product_format_id = pf.product_format_id
JOIN Products p ON pf.product_id = p.product_id
JOIN Formats f ON pf.format_id = f.format_id
WHERE r.return_date IS NULL;

-- Lists customers with active membership subscriptions.
CREATE VIEW View_Member_Status AS
SELECT 
    c.customer_id,
    c.full_name,
    m.membership_type,
    m.start_date,
    m.end_date
FROM Memberships m
JOIN Customers c ON m.customer_id = c.customer_id
WHERE m.end_date IS NULL OR m.end_date > DATE('now');


--               INDEXES


-- Optimizes lookup of stock by store and product format.
CREATE INDEX idx_inventory_store_product ON Inventory(store_id, product_format_id);

-- Speeds up access to rentals by customer.
CREATE INDEX idx_rentals_customer ON Rentals(customer_id);

-- Speeds up access to sales by customer.
CREATE INDEX idx_sales_customer ON Sales(customer_id);

-- Optimizes lookup of product formats by product and format.
CREATE INDEX idx_productformats_product_format ON ProductFormats(product_id, format_id);





--              TRIGGERS
-- Decrease inventory when a rental is made
CREATE TRIGGER trg_decrement_inventory_on_rental
AFTER INSERT ON Rentals
BEGIN
    UPDATE Inventory
    SET quantity = quantity - 1
    WHERE product_format_id = NEW.product_format_id
      AND quantity > 0;
END;

--  Increase inventory when a rental is returned
CREATE TRIGGER trg_increment_inventory_on_return
AFTER UPDATE OF return_date ON Rentals
WHEN NEW.return_date IS NOT NULL
BEGIN
    UPDATE Inventory
    SET quantity = quantity + 1
    WHERE product_format_id = NEW.product_format_id;
END;

--  Decrease inventory when a sale is made
CREATE TRIGGER trg_decrement_inventory_on_sale
AFTER INSERT ON Sales
BEGIN
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_format_id = (
        SELECT product_format_id
        FROM ProductFormats
        WHERE product_id = NEW.product_id
        LIMIT 1
    )
    AND quantity >= NEW.quantity;
END;

--  Prevent rental if item is out of stock
CREATE TRIGGER trg_prevent_rental_if_out_of_stock
BEFORE INSERT ON Rentals
BEGIN
    SELECT CASE
        WHEN (SELECT quantity FROM Inventory WHERE product_format_id = NEW.product_format_id) <= 0
        THEN RAISE(ABORT, 'Cannot rent: item is out of stock')
    END;
END;

--  Prevent sale if insufficient stock
CREATE TRIGGER trg_prevent_sale_if_out_of_stock
BEFORE INSERT ON Sales
BEGIN
    SELECT CASE
        WHEN (
            SELECT quantity
            FROM Inventory
            WHERE product_format_id = (
                SELECT product_format_id
                FROM ProductFormats
                WHERE product_id = NEW.product_id
                LIMIT 1
            )
        ) < NEW.quantity
        THEN RAISE(ABORT, 'Cannot sell: insufficient stock')
    END;
END;
