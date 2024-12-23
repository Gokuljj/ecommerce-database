-- 1) Database Creation
CREATE DATABASE ecommerce; -- Creates the main database for the e-commerce system.

-- 2) Customers Table Creation
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each customer
    name VARCHAR(255) NOT NULL, -- Customer's name
    email VARCHAR(255) NOT NULL, -- Customer's email address
    address TEXT -- Customer's address
);

-- 3) Orders Table Creation
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order
    customer_id INT NOT NULL, -- Links the order to a specific customer
    order_date DATE NOT NULL, -- The date the order was placed
    total_amount DECIMAL(10, 2) NOT NULL, -- Total amount for the order
    FOREIGN KEY (customer_id) REFERENCES customers(id) -- Establishes a relationship with the 'customers' table
);

-- 4) Products Table Creation
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each product
    name VARCHAR(255) NOT NULL, -- Name of the product
    price DECIMAL(10, 2) NOT NULL, -- Price of the product
    description TEXT, -- Description of the product
    discount DECIMAL(10, 2) DEFAULT 0.00 -- Discount applied to the product (optional)
);

-- 5) Insert values into customers table
INSERT INTO customers (name, email, address) VALUES
('Rajesh Kumar', 'rajesh.kumar@example.com', 'Delhi, India'), -- Adds a customer named Rajesh
('Priya Sharma', 'priya.sharma@example.com', 'Mumbai, India'), -- Adds a customer named Priya
('Anil Gupta', 'anil.gupta@example.com', 'Bengaluru, India'), -- Adds a customer named Anil
('Sunita Mehta', 'sunita.mehta@example.com', 'Chennai, India'), -- Adds a customer named Sunita
('Vikas Singh', 'vikas.singh@example.com', 'Kolkata, India'); -- Adds a customer named Vikas

-- 6) Insert values into products table
INSERT INTO products (name, price, description) VALUES
('Product A', 25.00, 'Description of Product A'), -- Adds Product A
('Product B', 35.00, 'Description of Product B'), -- Adds Product B
('Product C', 50.00, 'Description of Product C'), -- Adds Product C
('Product D', 75.00, 'Description of Product D'), -- Adds Product D
('Product E', 100.00, 'Description of Product E'); -- Adds Product E

-- 7) Insert values into orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-12-01', 60.00), -- Order for Rajesh placed on Dec 1
(2, '2024-12-05', 35.00), -- Order for Priya placed on Dec 5
(3, '2024-12-10', 100.00), -- Order for Anil placed on Dec 10
(4, '2024-12-15', 75.00), -- Order for Sunita placed on Dec 15
(5, '2024-12-20', 160.00), -- Order for Vikas placed on Dec 20
(3, '2024-12-22', 200.00); -- New order for Anil placed on Dec 22

-- 8) Retrieve all customers who placed an order in the last 30 days
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY; -- Filters orders from the last 30 days

-- 9) Get the total amount of all orders placed by each customer
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name; -- Groups results by customer name

-- 10) Update the price of Product C to 45.00
UPDATE products
SET price = 45.00
WHERE name = 'Product C'; -- Changes the price of Product C

-- 11) Add a new column discount to the products table
ALTER TABLE products
ADD COLUMN discount DECIMAL(10, 2) DEFAULT 0.00; -- Adds a discount column with a default value of 0

-- 12) Retrieve the top 3 products with the highest price
SELECT *
FROM products
ORDER BY price DESC -- Sorts products by price in descending order
LIMIT 3; -- Retrieves the top 3 most expensive products

-- 13) Normalize the database by creating the order_items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each order item
    order_id INT NOT NULL, -- Links the item to a specific order
    product_id INT NOT NULL, -- Links the item to a specific product
    quantity INT NOT NULL, -- Quantity of the product in the order
    FOREIGN KEY (order_id) REFERENCES orders(id), -- Links to the 'orders' table
    FOREIGN KEY (product_id) REFERENCES products(id) -- Links to the 'products' table
);

-- 14) Insert sample data into order_items table
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2), -- Order 1 includes 2 units of Product A
(1, 2, 1), -- Order 1 includes 1 unit of Product B
(2, 3, 1), -- Order 2 includes 1 unit of Product C
(3, 4, 1), -- Order 3 includes 1 unit of Product D
(4, 5, 2), -- Order 4 includes 2 units of Product E
(5, 2, 4), -- Order 5 includes 4 units of Product B
(5, 1, 1); -- Order 5 includes 1 unit of Product A

-- 15) Get the names of customers who ordered Product A
SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A'; -- Filters for customers who ordered Product A

-- 16) Join orders and customers to retrieve names and order dates
SELECT c.name AS customer_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.id; -- Retrieves customer names with corresponding order dates

-- 17) Retrieve orders with a total amount greater than 150.00
SELECT *
FROM orders
WHERE total_amount > 150.00; -- Filters orders where the total exceeds 150

-- 18) Retrieve the average total of all orders
SELECT AVG(total_amount) AS average_order_total
FROM orders; -- Calculates the average total of all orders to analyze spending trends
