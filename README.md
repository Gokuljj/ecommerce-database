# E-commerce Database

This project contains the SQL scripts to create and manage a simple e-commerce database using MySQL. The database includes tables for customers, products, orders, and order items, with functionalities to handle basic e-commerce operations such as tracking customers, managing orders, and analyzing data.

## Features
- Customers table to store information about buyers.
- Products table to manage the catalog of items available for purchase.
- Orders table to track customer purchases and their total amounts.
- Order Items table to normalize the database and manage the relationship between orders and products.
- Sample queries for analytics and reporting, including:
  - Retrieving recent orders.
  - Summarizing total spending per customer.
  - Identifying popular products.

## Database Structure

### Tables and Columns

1. **Customers Table**:
   - `id`: Unique identifier for each customer (Primary Key, Auto Increment).
   - `name`: Name of the customer.
   - `email`: Email address of the customer.
   - `address`: Address of the customer.

2. **Products Table**:
   - `id`: Unique identifier for each product (Primary Key, Auto Increment).
   - `name`: Name of the product.
   - `price`: Price of the product.
   - `description`: Description of the product.
   - `discount`: Discount applicable to the product (default is 0).

3. **Orders Table**:
   - `id`: Unique identifier for each order (Primary Key, Auto Increment).
   - `customer_id`: Links the order to a specific customer (Foreign Key).
   - `order_date`: Date when the order was placed.
   - `total_amount`: Total value of the order.

4. **Order Items Table**:
   - `id`: Unique identifier for each order item (Primary Key, Auto Increment).
   - `order_id`: Links the item to a specific order (Foreign Key).
   - `product_id`: Links the item to a specific product (Foreign Key).
   - `quantity`: Number of units of the product in the order.

## Example Data
### Customers:
- Rajesh Kumar (Delhi, India)
- Priya Sharma (Mumbai, India)
- Anil Gupta (Bengaluru, India)
- Sunita Mehta (Chennai, India)
- Vikas Singh (Kolkata, India)

### Products:
- Product A (Price: ₹25.00)
- Product B (Price: ₹35.00)
- Product C (Price: ₹50.00)
- Product D (Price: ₹75.00)
- Product E (Price: ₹100.00)

### Orders:
- Order 1: Rajesh Kumar, Total: ₹60.00
- Order 2: Priya Sharma, Total: ₹35.00
- Order 3: Anil Gupta, Total: ₹100.00
- Order 4: Sunita Mehta, Total: ₹75.00
- Order 5: Vikas Singh, Total: ₹160.00
- Order 6: Anil Gupta, Total: ₹200.00

## Queries

### Retrieve All Customers Who Placed Orders in the Last 30 Days
```sql
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;
```

### Calculate Total Amount of Orders for Each Customer
```sql
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
```

### Update Product Price
```sql
UPDATE products
SET price = 45.00
WHERE name = 'Product C';
```

### Retrieve Top 3 Most Expensive Products
```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;
```

## Usage Instructions
1. Create the `ecommerce` database by running the script to create and populate the tables.
2. Use the provided queries for analytics or modify them to suit your requirements.
3. Ensure your MySQL server is configured correctly before executing the scripts.

## Future Improvements
- Add user authentication for secure access.
- Extend the schema to include shipping and payment details.
- Create views and stored procedures for complex analytics.

---


