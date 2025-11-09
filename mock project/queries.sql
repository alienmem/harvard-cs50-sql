-- inserts

-- Add a new store
INSERT INTO Stores (store_id, store_name, location)
VALUES (1, 'Titanic Titles Porto', 'Rua das Videotapes 123, Porto');

-- Add a new customer
INSERT INTO Customers (customer_id, full_name, email, phone, address)
VALUES (101, 'Ana Costa', 'ana.costa@example.com', '912345678', 'Avenida das Locadoras, 456');

-- Add a new product category
INSERT INTO Categories (category_id, name)
VALUES (1, 'Movie');

-- Add a new format
INSERT INTO Formats (format_id, name)
VALUES (1, 'VHS');

-- Add a new product
INSERT INTO Products (product_id, name, category_id, description, price, is_new, is_rentable)
VALUES (301, 'Back to the Future', 1, 'Classic time-travel adventure', 2.99, 1, 1);

-- Associate product with format
INSERT INTO ProductFormats (product_format_id, product_id, format_id)
VALUES (1, 301, 1);

-- Add stock to inventory
INSERT INTO Inventory (inventory_id, store_id, product_format_id, quantity)
VALUES (1, 1, 1, 5);

-- Add a membership
INSERT INTO Memberships (membership_id, customer_id, membership_type, start_date)
VALUES (1, 101, 'Premium', DATE('now'));

-- Record a rental
INSERT INTO Rentals (rental_id, customer_id, product_format_id, rental_date, due_date)
VALUES (1001, 101, 1, DATE('now'), DATE('now', '+3 days'));

-- Record a sale
INSERT INTO Sales (sale_id, customer_id, product_id, sale_date, quantity)
VALUES (2001, 101, 301, DATE('now'), 1);

-- Log a payment
INSERT INTO Payments (payment_id, customer_id, payment_type, amount, payment_date, rental_id)
VALUES (3001, 101, 'Card', 2.99, DATE('now'), 1001);






-- selects

-- List all active members
SELECT c.customer_id, c.full_name, m.membership_type
FROM Customers c
JOIN Memberships m ON c.customer_id = m.customer_id
WHERE m.end_date IS NULL OR m.end_date > DATE('now');

-- List all rentals due today
SELECT c.full_name AS customer_name, p.name AS product_name, r.due_date
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN ProductFormats pf ON r.product_format_id = pf.product_format_id
JOIN Products p ON pf.product_id = p.product_id
WHERE r.return_date IS NULL AND r.due_date = DATE('now');

-- Check stock of a product in all stores
SELECT s.store_name AS store, i.quantity, f.name AS format
FROM Inventory i
JOIN Stores s ON i.store_id = s.store_id
JOIN ProductFormats pf ON i.product_format_id = pf.product_format_id
JOIN Formats f ON pf.format_id = f.format_id
WHERE pf.product_id = 301;

-- View all overdue rentals
SELECT c.full_name, p.name, r.due_date, r.return_date
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN ProductFormats pf ON r.product_format_id = pf.product_format_id
JOIN Products p ON pf.product_id = p.product_id
WHERE r.return_date IS NOT NULL AND r.return_date > r.due_date;





--updates

-- Return a rented movie
UPDATE Rentals
SET return_date = DATE('now')
WHERE rental_id = 1001;

-- Update stock after return
UPDATE Inventory
SET quantity = quantity + 1
WHERE store_id = 1 AND product_format_id = 1;

-- Extend membership
UPDATE Memberships
SET end_date = DATE('now', '+1 year')
WHERE membership_id = 1;

-- Update product price
UPDATE Products
SET price = 3.49
WHERE product_id = 301;






--deletes

-- Remove a customer
DELETE FROM Customers
WHERE customer_id = 101;

-- Delete a product from inventory
DELETE FROM Inventory
WHERE store_id = 1 AND product_format_id = 1;

-- Cancel a rental
DELETE FROM Rentals
WHERE rental_id = 1001;

-- Remove a product format association
DELETE FROM ProductFormats
WHERE product_id = 301 AND format_id = 1;





-- aggregates

-- Top 5 most rented movies
SELECT p.name, COUNT(*) AS times_rented
FROM Rentals r
JOIN ProductFormats pf ON r.product_format_id = pf.product_format_id
JOIN Products p ON pf.product_id = p.product_id
GROUP BY p.name
ORDER BY times_rented DESC
LIMIT 5;

-- Total revenue per store (from sales only)
SELECT s.store_name, SUM(sales.quantity * p.price) AS total_revenue
FROM Sales sales
JOIN Products p ON sales.product_id = p.product_id
JOIN Stores s ON sales.customer_id IS NOT NULL
JOIN Customers c ON sales.customer_id = c.customer_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- Number of rentals per customer
SELECT c.full_name, COUNT(*) AS rental_count
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
GROUP BY c.full_name
ORDER BY rental_count DESC;


-- subqueries

--Products Never Sold
SELECT name
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM Sales
);

--Customers Who Spent More Than the Average
SELECT full_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Payments
    GROUP BY customer_id
    HAVING SUM(amount) > (
        SELECT AVG(total)
        FROM (
            SELECT SUM(amount) AS total
            FROM Payments
            GROUP BY customer_id
        )
    )
);



