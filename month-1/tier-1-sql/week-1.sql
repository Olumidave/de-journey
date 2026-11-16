-- =====================================================
-- DAY 1: BUILD THE DATABASE TABLE
-- =====================================================

-- Day 1: Remove old orders table (so the script can be re-run)
DROP TABLE IF EXISTS orders;

-- Day 1: Create the orders table
CREATE TABLE orders (
    order_id      INTEGER,
    customer_name VARCHAR(100),
    product       VARCHAR(100),
    amount        INTEGER,
    city          VARCHAR(100),
    order_date    DATE
);

-- Day 1: Insert the first 5 orders
INSERT INTO orders VALUES (1, 'Olumide David', 'Samsung TV', 380000, 'Lagos', '2024-01-15');
INSERT INTO orders VALUES (2, 'Amaka Okonkwo', 'iPhone 15', 890000, 'Abuja', '2024-01-16');
INSERT INTO orders VALUES (3, 'Chidi Nwosu', 'Laptop Dell', 450000, 'Kano', '2024-01-17');
INSERT INTO orders VALUES (4, 'Fatima Ali', 'Wireless Mouse', 8500, 'Lagos', '2024-01-18');
INSERT INTO orders VALUES (5, 'Emeka Obi', 'MacBook Pro', 1200000, 'Port Harcourt', '2024-01-19');

-- Day 1: Show everything in the orders table (expect 5 rows)
SELECT * FROM orders;


-- =====================================================
-- DAY 2: SELECT, WHERE, ORDER BY
-- =====================================================

-- Day 2: Reset the table (removes all rows, keeps the table)
DELETE FROM orders;

-- Day 2: Insert 10 fresh orders
INSERT INTO orders VALUES
(1, 'Olumide David', 'Samsung TV', 380000, 'Lagos', '2024-01-15'),
(2, 'Amaka Okonkwo', 'iPhone 15', 890000, 'Abuja', '2024-01-16'),
(3, 'Chidi Nwosu', 'Laptop Dell', 450000, 'Kano', '2024-01-17'),
(4, 'Fatima Ali', 'Wireless Mouse', 8500, 'Lagos', '2024-01-18'),
(5, 'Emeka Obi', 'MacBook Pro', 1200000, 'Port Harcourt', '2024-01-19'),
(6, 'Ngozi Eze', 'Phone Case', 2500, 'Enugu', '2024-01-20'),
(7, 'Tunde Bakare', 'Samsung TV', 380000, 'Lagos', '2024-01-21'),
(8, 'Aisha Bello', 'Keyboard', 12000, 'Kano', '2024-01-22'),
(9, 'Segun Adeyemi', 'iPad Air', 650000, 'Ibadan', '2024-01-23'),
(10, 'Blessing Okafor', 'Headphones', 45000, 'Lagos', '2024-01-24');

-- Day 2: Show all 10 orders
SELECT * FROM orders;

-- Day 2: Choose only certain columns
SELECT customer_name, product FROM orders;

-- Day 2: Filter rows - only Lagos orders (expect 4 rows)
SELECT customer_name, product, amount
FROM orders
WHERE city = 'Lagos';

-- Day 2: The capital letter trap - 'lagos' returns ZERO rows
SELECT * FROM orders WHERE city = 'lagos';

-- Day 2: Filter numbers - orders above 100,000 (expect 6 rows)
SELECT customer_name, product, amount
FROM orders
WHERE amount > 100000;

-- Day 2: AND - Lagos AND above 100,000 (expect 2 rows)
SELECT customer_name, city, amount
FROM orders
WHERE city = 'Lagos' AND amount > 100000;

-- Day 2: OR - Lagos OR Abuja (expect 5 rows)
SELECT customer_name, city, amount
FROM orders
WHERE city = 'Lagos' OR city = 'Abuja';

-- Day 2: Sort by amount, biggest first
SELECT customer_name, product, amount
FROM orders
ORDER BY amount DESC;

-- Day 2: Manager question - Lagos orders above 10,000, biggest first (expect 3 rows)
SELECT customer_name, product, amount
FROM orders
WHERE city = 'Lagos' AND amount > 10000
ORDER BY amount DESC;


-- =====================================================
-- DAY 3: COUNT, SUM, AVG, GROUP BY, HAVING
-- =====================================================

-- Day 3: Count all orders (expect 10)
SELECT COUNT(*) FROM orders;

-- Day 3: Count with a nickname (alias)
SELECT COUNT(*) AS total_orders FROM orders;

-- Day 3: Total revenue (expect 4018000)
SELECT SUM(amount) AS total_revenue FROM orders;

-- Day 3: Average order, many decimals
SELECT AVG(amount) AS average_order FROM orders;

-- Day 3: Average order, rounded (expect 401800)
SELECT ROUND(AVG(amount), 0) AS average_order FROM orders;

-- Day 3: Biggest and smallest order
SELECT MAX(amount) AS biggest_order, MIN(amount) AS smallest_order
FROM orders;

-- Day 3: Count and total for Lagos only (expect 4 and 813500)
SELECT COUNT(*) AS lagos_orders, SUM(amount) AS lagos_revenue
FROM orders
WHERE city = 'Lagos';

-- Day 3: GROUP BY - total revenue for each city
SELECT city, SUM(amount) AS total_revenue
FROM orders
GROUP BY city;

-- Day 3: Full manager report per city
SELECT
    city,
    COUNT(*)               AS number_of_orders,
    SUM(amount)            AS total_revenue,
    ROUND(AVG(amount), 0)  AS average_order
FROM orders
GROUP BY city
ORDER BY total_revenue DESC;

-- Day 3: HAVING - only cities with revenue above 500,000 (expect 4 cities)
SELECT city, SUM(amount) AS total_revenue
FROM orders
GROUP BY city
HAVING SUM(amount) > 500000
ORDER BY total_revenue DESC;

-- Day 3: (OPTIONAL - this one ERRORS on purpose, it shows the GROUP BY golden rule.
-- Remove the two dashes at the start of each line to try it.)
-- SELECT city, product, SUM(amount)
-- FROM orders
-- GROUP BY city;


-- =====================================================
-- DAY 4: JOINS (customers and purchases tables)
-- =====================================================

-- Day 4: Remove old tables (so the script can be re-run)
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS customers;

-- Day 4: Create the customers table
CREATE TABLE customers (
    customer_id  INTEGER,
    full_name    VARCHAR(100),
    city         VARCHAR(100)
);

-- Day 4: Insert 6 customers
INSERT INTO customers VALUES
(1, 'Olumide David', 'Lagos'),
(2, 'Amaka Okonkwo', 'Abuja'),
(3, 'Chidi Nwosu', 'Kano'),
(4, 'Fatima Ali', 'Lagos'),
(5, 'Emeka Obi', 'Port Harcourt'),
(6, 'Ngozi Eze', 'Enugu');

-- Day 4: Create the purchases table
CREATE TABLE purchases (
    purchase_id    INTEGER,
    customer_id    INTEGER,
    product        VARCHAR(100),
    amount         INTEGER,
    purchase_date  DATE
);

-- Day 4: Insert 7 purchases (Ngozi has none, purchase 107 belongs to a customer who does not exist)
INSERT INTO purchases VALUES
(101, 1,  'Samsung TV',     380000,  '2024-01-15'),
(102, 1,  'Wireless Mouse', 8500,    '2024-01-16'),
(103, 2,  'iPhone 15',      890000,  '2024-01-17'),
(104, 3,  'Laptop Dell',    450000,  '2024-01-18'),
(105, 4,  'Keyboard',       12000,   '2024-01-19'),
(106, 5,  'MacBook Pro',    1200000, '2024-01-20'),
(107, 99, 'Headphones',     45000,   '2024-01-21');

-- Day 4: Check the customers table (expect 6 rows)
SELECT * FROM customers;

-- Day 4: Check the purchases table (expect 7 rows)
SELECT * FROM purchases;

-- Day 4: INNER JOIN - only rows that match on both sides (expect 6 rows)
SELECT c.full_name, c.city, p.product, p.amount
FROM customers c
INNER JOIN purchases p
    ON c.customer_id = p.customer_id;

-- Day 4: LEFT JOIN - all customers, even those with no purchases (expect 7 rows)
SELECT c.full_name, c.city, p.product, p.amount
FROM customers c
LEFT JOIN purchases p
    ON c.customer_id = p.customer_id;

-- Day 4: Customers who have never bought anything (expect Ngozi Eze)
SELECT c.full_name, c.city
FROM customers c
LEFT JOIN purchases p
    ON c.customer_id = p.customer_id
WHERE p.purchase_id IS NULL;

-- Day 4: RIGHT JOIN - all purchases, even those with no customer (expect 7 rows)
SELECT c.full_name, p.product, p.amount
FROM customers c
RIGHT JOIN purchases p
    ON c.customer_id = p.customer_id;

-- Day 4: FULL JOIN - everything from both tables (expect 8 rows)
SELECT c.full_name, p.product, p.amount
FROM customers c
FULL JOIN purchases p
    ON c.customer_id = p.customer_id;

-- Day 4: JOIN + GROUP BY - how much has each customer spent?
SELECT
    c.full_name,
    COUNT(p.purchase_id)  AS number_of_purchases,
    SUM(p.amount)         AS total_spent
FROM customers c
LEFT JOIN purchases p
    ON c.customer_id = p.customer_id
GROUP BY c.full_name
ORDER BY c.full_name;

-- Day 4: JOIN + GROUP BY - which city brings in the most money?
SELECT c.city, SUM(p.amount) AS total_revenue
FROM customers c
INNER JOIN purchases p
    ON c.customer_id = p.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;


-- =====================================================
-- DAY 5: WINDOW FUNCTIONS AND CTEs
-- =====================================================

-- Day 5: RANK - rank every order from biggest to smallest
SELECT
    customer_name,
    amount,
    RANK() OVER (ORDER BY amount DESC) AS amount_rank
FROM orders;

-- Day 5: DENSE_RANK - same ranking, but no skipped numbers after a tie
SELECT
    customer_name,
    amount,
    DENSE_RANK() OVER (ORDER BY amount DESC) AS amount_rank
FROM orders;

-- Day 5: PARTITION BY - a separate ranking inside each city
SELECT
    city,
    customer_name,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY city
        ORDER BY amount DESC, order_id
    ) AS rank_in_city
FROM orders
ORDER BY city, rank_in_city;

-- Day 5: CTE - the biggest order in each city (expect 6 rows)
WITH ranked_orders AS (
    SELECT
        city,
        customer_name,
        product,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY amount DESC, order_id
        ) AS rank_in_city
    FROM orders
)
SELECT city, customer_name, product, amount
FROM ranked_orders
WHERE rank_in_city = 1
ORDER BY amount DESC;

-- Day 5: Running total of revenue by date (last row should be 4018000)
SELECT
    order_date,
    amount,
    SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders
ORDER BY order_date;