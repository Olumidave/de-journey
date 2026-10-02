-- Products table
CREATE TABLE products (
    product_id      INTEGER,
    product_name    VARCHAR(100),
    category        VARCHAR(50),
    unit_price      INTEGER,
    supplier        VARCHAR(100)
);

-- Customers table
CREATE TABLE customers (
    customer_id     INTEGER,
    full_name       VARCHAR(100),
    city            VARCHAR(100),
    email           VARCHAR(100),
    phone           VARCHAR(20)
);

-- Orders table (connects customers, stores and products)
CREATE TABLE orders (
    order_id        INTEGER,
    customer_id     INTEGER,
    store_id        INTEGER,
    product_id      INTEGER,
    quantity        INTEGER,
    order_date      DATE,
    status          VARCHAR(50)
);


-- Products
INSERT INTO products VALUES (1, 'Laptop Dell', 'Electronics', 450000, 'Dell Nigeria');
INSERT INTO products VALUES (2, 'Wireless Mouse', 'Accessories', 8500, 'Logitech NG');
INSERT INTO products VALUES (3, 'iPhone 15', 'Electronics', 890000, 'Apple Africa');
INSERT INTO products VALUES (4, 'Samsung TV', 'Electronics', 380000, 'Samsung NG');
INSERT INTO products VALUES (5, 'USB Hub', 'Accessories', 4200, 'Generic');
INSERT INTO products VALUES (6, 'MacBook Pro', 'Electronics', 1200000, 'Apple Africa');
INSERT INTO products VALUES (7, 'Keyboard Logitech', 'Accessories', 12000, 'Logitech NG');
INSERT INTO products VALUES (8, 'Monitor LG', 'Electronics', 185000, 'LG Nigeria');

-- Customers
INSERT INTO customers VALUES (1, 'Olumide David', 'Lagos', 'olumide@email.com', '08012345678');
INSERT INTO customers VALUES (2, 'Amaka Okonkwo', 'Abuja', 'amaka@email.com', '08023456789');
INSERT INTO customers VALUES (3, 'Chidi Nwosu', 'Kano', 'chidi@email.com', '08034567890');
INSERT INTO customers VALUES (4, 'Fatima Abdullahi', 'Ibadan', 'fatima@email.com', '08045678901');
INSERT INTO customers VALUES (5, 'Emeka Obi', 'Port Harcourt', 'emeka@email.com', '08056789012');
INSERT INTO customers VALUES (6, 'Ngozi Eze', 'Enugu', 'ngozi@email.com', '08067890123');

-- Orders
INSERT INTO orders VALUES (1, 1, 101, 1, 2, '2024-01-05', 'Completed');
INSERT INTO orders VALUES (2, 1, 101, 2, 1, '2024-01-05', 'Completed');
INSERT INTO orders VALUES (3, 2, 102, 3, 1, '2024-01-06', 'Completed');
INSERT INTO orders VALUES (4, 3, 103, 4, 1, '2024-01-07', 'Completed');
INSERT INTO orders VALUES (5, 4, 104, 6, 1, '2024-01-08', 'Completed');
INSERT INTO orders VALUES (6, 5, 105, 8, 2, '2024-01-09', 'Completed');
INSERT INTO orders VALUES (7, 2, 102, 3, 1, '2024-01-10', 'Pending');
INSERT INTO orders VALUES (8, 1, 101, 7, 3, '2024-01-10', 'Completed');
INSERT INTO orders VALUES (9, 6, 103, 5, 5, '2024-01-11', 'Cancelled');
INSERT INTO orders VALUES (10, 4, 104, 4, 2, '2024-01-12', 'Completed');
INSERT INTO orders VALUES (11, 3, 105, 1, 1, '2024-01-13', 'Pending');
INSERT INTO orders VALUES (12, 5, 101, 2, 2, '2024-01-14', 'Completed');


-- Get customer name with their orders
SELECT
    c.full_name,
    c.city,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Show ALL customers, even if they have no orders
SELECT
    c.full_name,
    c.city,
    o.order_id,
    o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT
    c.full_name,
    o.order_id,
    o.status
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

SELECT
    c.full_name,
    o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;


-- Get customer name + product name + order details
-- This joins customers, orders AND products together
SELECT
    c.full_name        AS customer,
    p.product_name     AS product,
    p.category,
    o.quantity,
    p.unit_price,
    (o.quantity * p.unit_price) AS total_amount,
    o.order_date,
    o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p  ON o.product_id  = p.product_id
ORDER BY o.order_date, c.full_name;

-- Total spending per customer
SELECT
    c.full_name,
    c.city,
    COUNT(o.order_id)               AS num_orders,
    SUM(p.unit_price * o.quantity)  AS total_spent
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p  ON o.product_id  = p.product_id
WHERE o.status = 'Completed'
GROUP BY c.full_name, c.city
ORDER BY total_spent DESC;

-- Best selling products
SELECT
    p.product_name,
    p.category,
    COUNT(o.order_id)               AS times_ordered,
    SUM(o.quantity)                 AS units_sold,
    SUM(p.unit_price * o.quantity)  AS total_revenue
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
WHERE o.status != 'Cancelled'
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC;

-- Find customers who have NEVER placed an order
-- This is a very common real world DE task
SELECT
    c.full_name,
    c.city,
    c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;



-- Complete store performance report
SELECT
    s.store_id,
    s.city                              AS store_city,
    s.manager,
    COUNT(o.order_id)                   AS total_orders,
    SUM(p.unit_price * o.quantity)      AS total_revenue,
    ROUND(AVG(p.unit_price * o.quantity), 0) AS avg_order_value,
    COUNT(DISTINCT o.customer_id)       AS unique_customers
FROM stores s
LEFT JOIN orders o  ON s.store_id  = o.store_id
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY s.store_id, s.city, s.manager
ORDER BY total_revenue DESC NULLS LAST;
