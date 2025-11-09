# Design Document

By Antonio Cardoso

Video overview: None available. A Powerpoint is presented instead.

## Scope

The purpose of this database is to manage basic operations of a video store chain called Tony's Titanic Titles. The database tracks information about store locations, customers, inventory, products, transactions. It is much in the vain of the now extinct Blockbuster video store chain.

As such, included in the database's scope are:

- Store locations and details  
- Customer profiles and membership subscriptions  
- Product catalog, categories and formats  
- Stock levels per store and format  
- Rental transactions (with due dates and returns)  
- Sales transactions  
- Payment records for rentals and purchases  

Out of scope are:

- Employee, supplier or vendor management     
- Customer ratings or product reviews  
- Full accounting functionality  

---

## Functional Requirements

Users should be able to:

1. Register new customers and update contact details  
2. Create and manage membership subscriptions (start/end dates, types)  
3. Define store locations, product categories and available formats  
4. Add new products and link them to one or more formats  
5. View and adjust inventory per store & format  
6. Process rentals (issue items, enforce “out of stock” checks)  
7. Record returns (update stock automatically via triggers)  
8. Process sales and decrement stock  
9. Log payments tied to rentals or sales  
10. Query available inventory, current rentals, and active memberships via views  

Users will not be able to:

- Maintain employee or HR data  
- Process debit/credit card transactions  
- Publish or moderate reviews and ratings 

---

## Representation

Entities are captured in SQLite tables with these schemas.

### Entities

#### Customers

- customer_id INTEGER PRIMARY KEY  
- full_name TEXT NOT NULL  
- email TEXT UNIQUE  
- phone TEXT  
- address TEXT  

#### Memberships

- membership_id INTEGER PRIMARY KEY  
- customer_id INTEGER NOT NULL → Customers(customer_id)  
- membership_type TEXT NOT NULL  
- start_date DATE NOT NULL  
- end_date DATE  

#### Stores

- store_id INTEGER PRIMARY KEY  
- store_name TEXT NOT NULL  
- location TEXT NOT NULL  

#### Categories

- category_id INTEGER PRIMARY KEY  
- name TEXT UNIQUE NOT NULL  

#### Formats

- format_id INTEGER PRIMARY KEY  
- name TEXT UNIQUE NOT NULL  

#### Products

- product_id INTEGER PRIMARY KEY  
- name TEXT NOT NULL  
- category_id INTEGER NOT NULL → Categories(category_id)  
- description TEXT  
- price DECIMAL(6,2) NOT NULL  
- is_new INTEGER DEFAULT 1  
- is_rentable INTEGER DEFAULT 0  

#### ProductFormats

- product_format_id INTEGER PRIMARY KEY  
- product_id INTEGER NOT NULL → Products(product_id)  
- format_id INTEGER NOT NULL → Formats(format_id)  
- UNIQUE(product_id, format_id)  

#### Inventory

- inventory_id INTEGER PRIMARY KEY  
- store_id INTEGER NOT NULL → Stores(store_id)  
- product_format_id INTEGER NOT NULL → ProductFormats(product_format_id)  
- quantity INTEGER NOT NULL CHECK(quantity >= 0)  
- UNIQUE(store_id, product_format_id)  

#### Rentals

- rental_id INTEGER PRIMARY KEY  
- customer_id INTEGER NOT NULL → Customers(customer_id)  
- store_id INTEGER NOT NULL → Stores(store_id)  
- product_format_id INTEGER NOT NULL → ProductFormats(product_format_id)  
- rental_date DATE DEFAULT CURRENT_DATE  
- due_date DATE  
- return_date DATE  

#### Sales

- sale_id INTEGER PRIMARY KEY  
- customer_id INTEGER → Customers(customer_id)  
- product_id INTEGER NOT NULL → Products(product_id)  
- sale_date DATE DEFAULT CURRENT_DATE  
- quantity INTEGER NOT NULL DEFAULT 1  

#### Payments

- payment_id INTEGER PRIMARY KEY  
- customer_id INTEGER NOT NULL → Customers(customer_id)  
- payment_type TEXT NOT NULL  
- amount DECIMAL(6,2) NOT NULL  
- payment_date DATE DEFAULT CURRENT_DATE  
- rental_id INTEGER → Rentals(rental_id)  
- sale_id INTEGER → Sales(sale_id)  

---

## Relationships

![Tonys Titanic Titles](TonysTitanictitles.png)
- Each customer may have zero or many memberships, rentals, sales and payments.  
- Each membership ties to exactly one customer.  
- Each store stocks many product-formats via Inventory; each inventory row belongs to one store and one product-format.  
- Products are classified by one category and can link to many formats (VHS, DVD, Blu-Ray).  
- Rentals link one customer, one store and one product-format; they decrement stock upon issue and increment on return.  
- Sales link one customer (optional), one product, and decrement stock across an arbitrary format via a lookup.  
- Payments attach to exactly one customer and to one rental or one sale.  

---

## Optimizations

#### Views

- **View_Available_Inventory**  
  Lists all products in stock (> 0) by store and format.  

- **View_Current_Rentals**  
  Shows active rentals (no return_date) with customer, movie and due date.  

- **View_Member_Status**  
  Lists customers whose memberships have not expired.  

#### Indexes

- **idx_inventory_store_product** on Inventory(store_id, product_format_id)  
- **idx_rentals_customer** on Rentals(customer_id)  
- **idx_sales_customer** on Sales(customer_id)  
- **idx_productformats_product_format** on ProductFormats(product_id, format_id)  

#### Triggers

- **trg_decrement_inventory_on_rental**  
  After INSERT on Rentals, subtracts 1 from Inventory.quantity.  

- **trg_increment_inventory_on_return**  
  After UPDATE of return_date on Rentals, adds 1 back to Inventory.quantity.  

- **trg_decrement_inventory_on_sale**  
  After INSERT on Sales, subtracts sold quantity from Inventory via ProductFormats lookup.  

- **trg_prevent_rental_if_out_of_stock**  
  Before INSERT on Rentals, aborts if Inventory.quantity <= 0.  

- **trg_prevent_sale_if_out_of_stock**  
  Before INSERT on Sales, aborts if Inventory.quantity < quantity being sold.  

---

## Limitations

- No employee, supplier or vendor records.  
- No product reviews, ratings or customer satisfaction metrics.  
- No multi-currency pricing or exchange-rate management.  
- Batch-level stock details (lot numbers, purchase costs) are not tracked.  
- Rental “rewind” logic is not modeled (no tape-specific flags).  
- No built-in accounting, invoicing or tax reporting.  





















Out of scope are elements like Employee management, customer ratings, payment methods, accounting and other non-core attributes. 

## Functional Requirements

Users should be able to:

*Register new customers and update their information
*Track product inventory per store
*Record transactions (rentals and sales)
*Track rented product due dates and returns
*Log and resolve rule violations
*View summaries such as top rented movies, late returns, and inventory by store

Users will not be able to:

*Manage employees or HR data
*Leave reviews or rate products
*Process real-time payments

## Representation
Entities are captured in SQLite tables with the following schema.


### Entities

#### Store

The store table includes:

store_id, which uniquely identifies each store as an INTEGER. This column is the PRIMARY KEY.
name, a TEXT value representing the store name. It is NOT NULL.
address, a TEXT field for the store’s address, marked as NOT NULL.
city, a TEXT field specifying the store’s city, NOT NULL.
currency, a TEXT value restricted via a CHECK constraint to 'Dollar' or 'Euro'.

#### Customer

The customer table includes:

customer_id, which uniquely identifies each customer as an INTEGER. This column is the PRIMARY KEY.
taxpayer_id, a TEXT field representing a unique national identifier (e.g., NIF). It has a UNIQUE and NOT NULL constraint.
name, the customer’s full name, stored as TEXT and marked as NOT NULL.
address, the customer’s address stored as TEXT. It is optional and may be NULL.
membership_status, a TEXT field with a default of 'Active', constrained to allowed values ('Active', 'On Hold', 'Temporary', 'Banned').
membership_start_date, stored as DATE, defaulting to the current date.
membership_points, an INTEGER, defaulting to 0.
membership_type, a TEXT field indicating the type of membership. It defaults to 'Regular' and is constrained to 'Regular' or 'Temporary'.

#### Stores

The store table includes:

store_id, which uniquely identifies each store as an INTEGER. This column is the PRIMARY KEY.
name, a TEXT value representing the store name. It is NOT NULL.
address, a TEXT field for the store’s address, marked as NOT NULL.
city, a TEXT field specifying the store’s city, NOT NULL.
currency, a TEXT value restricted via a CHECK constraint to 'Dollar' or 'Euro'.

#### Products

The product table includes:

product_id, which uniquely identifies a product as an INTEGER. This is the PRIMARY KEY.
name, stored as TEXT and marked NOT NULL.
category, stored as TEXT, constrained to 'Movie', 'Snack', 'Beverage', or 'Paraphernalia'.
format, stored as TEXT, optional depending on the category.
base_price, a NUMERIC(6,2) value for pricing, NOT NULL.

#### Inventory

The inventory table includes:

store_id, a foreign key referencing store(store_id).
product_id, a foreign key referencing product(product_id).
quantity_in_stock, an INTEGER defaulting to 0, and NOT NULL.
condition, a TEXT field constrained to 'New', 'Used', or 'Ex-Rented'.
This table uses a composite PRIMARY KEY on (store_id, product_id, condition).

#### Transactions

The transaction table includes:

transaction_id, an INTEGER serving as the PRIMARY KEY.
store_id, an INTEGER referencing the store where the transaction occurred.
customer_id, an INTEGER referencing the customer involved.
transaction_type, a TEXT value constrained to 'Sale' or 'Rental', NOT NULL.
transaction_date, a DATE defaulting to CURRENT_DATE.
total_amount, a NUMERIC(8,2) value defaulting to 0.00.

#### Transaction Lines

The transaction_line table includes:

line_id, an INTEGER that is the PRIMARY KEY.
transaction_id, a foreign key referencing transaction(transaction_id).
product_id, a foreign key referencing product(product_id).
quantity, an INTEGER indicating how many units were included, default 1, and NOT NULL.
unit_price, a NUMERIC(6,2) value specifying price per unit, NOT NULL.
due_date, a DATE field used for rentals.
return_date, a DATE representing when a product was returned.
fine_amount, a NUMERIC(6,2) field that stores any fine incurred.
rewind_required, an INTEGER acting as a boolean (0 = false, 1 = true), defaulting to 0.
rewind_done, an INTEGER acting as a boolean (0 = false, 1 = true), defaulting to 0.

#### Violations

The violation table includes:

violation_id, an INTEGER serving as the PRIMARY KEY.
customer_id, a foreign key referencing customer(customer_id).
type, a TEXT constrained to 'Late Return' or 'No Rewind'.
date, a DATE field defaulting to the current date.
fine, a NUMERIC(6,2) field defaulting to 0.00.
resolved, an INTEGER acting as a boolean (0 = unresolved, 1 = resolved), defaulting to 0.

Integers used for booleans (0 = false, 1 = true) to maintain SQL compatibility.
Constraints enforce primary keys, foreign keys, and non-null where necessary for data integrity.
Dates, numeric values, and text types chosen based on expected content.

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](TonysTitanicTitles.png)

As detailed by the diagram:

* A store is capable of stocking 0 to many inventory items. 0, if the store hasn’t received any stock yet, and many if it holds multiple products. Each inventory item is associated with one and only one store.

* A store is capable of handling 0 to many transactions. 0, if no purchases or rentals have been made yet at that location, and many if the store is has. Each transaction occurs at one and only one store.

* A customer is capable of making 0 to many transactions: 0 if they haven’t purchased or rented anything yet, and many if they have. A transaction is linked to one and only one customer.

* A customer can have 0 to many violations: 0 if they’ve always returned products on time and properly rewound, and many if they frequently violate store policies. Each violation is associated with one and only one customer.

* A transaction is associated with one and only one store. At the same time, a store can have 0 to many transactions: 0 if no sales or rentals have occurred there yet, and many if it had.

* A transaction consists of 1 to many transaction lines: 1 if it involves only a single product (e.g., renting one VHS tape), and many if multiple products were bought or rented in the same transaction. Each transaction line is associated with one and only one transaction, meaning it cannot belong to more than one transaction at a time.

* A product can exist in 0 to many inventory records: 0 if it hasn't been stocked yet, and many if it's available in multiple stores or conditions. Each inventory item is linked to one and only one product.

* A product can appear in 0 to many transaction lines: 0 if it hasn’t been bought or rented yet, and many if it has been transacted multiple times. Each transaction line references one and only one product.

* A customer may be responsible for 0 to many violations. A violation is tied to one and only one customer.


## Optimizations

#### Views

-view_active_customers: Lists all currently active customers

-view_rentals_due_today: Shows rentals due on the current date

-view_late_returns: Shows all overdue returns

-view_top_rented_movies: Highlights most rented movies

-view_inventory_by_store: Displays inventory per store

-view_membership_violations: Lists customer violations

#### Indexes

idx_customer_taxpayer: Speeds up customer lookup by taxpayer ID

idx_product_name_format: Optimizes product searches by name/format

idx_transaction_line_due_date and idx_transaction_line_return_date: Optimize lookups for rental timing

idx_store_city: Helps search for stores by city

idx_inventory_product_store: Helps fetch inventory by product and store quickly

## Limitations

-The database doesn't handle employees, suppliers, or vendors.
-No tracking of product reviews or customer satisfaction.
-Doesn't support multi-currency transactions within the same store.
-Fine-grained stock details like batch numbers or purchase costs are not tracked.
-Rewind and return logic is simplified to integer flags.
-No Accounting system


