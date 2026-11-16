-- Create sales table
CREATE TABLE sales (
    sale_id     INTEGER,
    store_id    INTEGER,
    city        VARCHAR(100),
    product     VARCHAR(100),
    category    VARCHAR(50),
    amount      INTEGER,
    sale_date   DATE,
    salesperson VARCHAR(100)
);

-- Insert sales data
INSERT INTO sales VALUES (1, 101, 'Lagos', 'Laptop Dell', 'Electronics', 450000, '2024-01-05', 'Olumide');
INSERT INTO sales VALUES (2, 101, 'Lagos', 'Wireless Mouse', 'Accessories', 8500, '2024-01-05', 'Olumide');
INSERT INTO sales VALUES (3, 102, 'Abuja', 'iPhone 15', 'Electronics', 890000, '2024-01-06', 'Amaka');
INSERT INTO sales VALUES (4, 102, 'Abuja', 'USB Hub', 'Accessories', 4200, '2024-01-06', 'Amaka');
INSERT INTO sales VALUES (5, 103, 'Kano', 'Samsung TV', 'Electronics', 380000, '2024-01-07', 'Chidi');
INSERT INTO sales VALUES (6, 103, 'Kano', 'Keyboard', 'Accessories', 12000, '2024-01-07', 'Chidi');
INSERT INTO sales VALUES (7, 104, 'Ibadan', 'MacBook Pro', 'Electronics', 1200000, '2024-01-08', 'Fatima');
INSERT INTO sales VALUES (8, 104, 'Ibadan', 'Phone Case', 'Accessories', 2500, '2024-01-08', 'Fatima');
INSERT INTO sales VALUES (9, 105, 'Port Harcourt', 'HP Laptop', 'Electronics', 420000, '2024-01-09', 'Emeka');
INSERT INTO sales VALUES (10, 105, 'Port Harcourt', 'Monitor LG', 'Electronics', 185000, '2024-01-09', 'Emeka');
INSERT INTO sales VALUES (11, 101, 'Lagos', 'AirPods', 'Electronics', 95000, '2024-01-10', 'Olumide');
INSERT INTO sales VALUES (12, 102, 'Abuja', 'iPad Air', 'Electronics', 650000, '2024-01-10', 'Amaka');
INSERT INTO sales VALUES (13, 103, 'Kano', 'Flash Drive', 'Accessories', 3500, '2024-01-11', 'Chidi');
INSERT INTO sales VALUES (14, 104, 'Ibadan', 'Samsung S24', 'Electronics', 780000, '2024-01-11', 'Fatima');
INSERT INTO sales VALUES (15, 105, 'Port Harcourt', 'Headphones', 'Accessories', 45000, '2024-01-12', 'Emeka');


-- How many sales do we have total?
SELECT COUNT(*) AS total_sales
FROM sales;

-- How many sales were in Lagos?
SELECT COUNT(*) AS lagos_sales
FROM sales
WHERE city = 'Lagos';

-- Count distinct cities
SELECT COUNT(DISTINCT city) AS number_of_cities
FROM sales;

-- What is the total revenue from all sales?
SELECT SUM(amount) AS total_revenue
FROM sales;

-- Total revenue from Electronics only
SELECT SUM(amount) AS electronics_revenue
FROM sales
WHERE category = 'Electronics';

-- What is the average sale amount?
SELECT AVG(amount) AS average_sale
FROM sales;

-- What was the biggest single sale?
SELECT MAX(amount) AS highest_sale
FROM sales;

-- What was the smallest single sale?
SELECT MIN(amount) AS lowest_sale
FROM sales;

-- Show both together with total and average
SELECT
    COUNT(*)        AS total_transactions,
    SUM(amount)     AS total_revenue,
    AVG(amount)     AS average_sale,
    MAX(amount)     AS highest_sale,
    MIN(amount)     AS lowest_sale
FROM sales;

-- Total revenue per city
SELECT
    city,
    SUM(amount) AS total_revenue
FROM sales
GROUP BY city;


-- Number of sales per city
SELECT
    city,
    COUNT(*) AS number_of_sales
FROM sales
GROUP BY city;


-- Multiple aggregations per group
SELECT
    city,
    COUNT(*)        AS num_sales,
    SUM(amount)     AS total_revenue,
    AVG(amount)     AS avg_sale,
    MAX(amount)     AS best_sale
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- Revenue per city AND category
SELECT
    city,
    category,
    COUNT(*)    AS num_sales,
    SUM(amount) AS total_revenue
FROM sales
GROUP BY city, category
ORDER BY city, total_revenue DESC;

-- Show only cities with total revenue above 500,000
SELECT
    city,
    SUM(amount) AS total_revenue
FROM sales
GROUP BY city
HAVING SUM(amount) > 500000
ORDER BY total_revenue DESC;


-- Sales performance report by city
-- Only show active categories
-- Only show cities with more than 1 sale
-- Sort by best performing city
SELECT
    city,
    category,
    COUNT(*)            AS num_transactions,
    SUM(amount)         AS total_revenue,
    AVG(amount)         AS avg_transaction,
    MAX(amount)         AS biggest_sale,
    MIN(amount)         AS smallest_sale
FROM sales
WHERE category = 'Electronics'
GROUP BY city, category
HAVING COUNT(*) > 1
ORDER BY total_revenue DESC
LIMIT 5;