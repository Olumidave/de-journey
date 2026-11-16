-- Create the stores table
CREATE TABLE stores (
    store_id    INTEGER,
    city        VARCHAR(100),
    revenue     INTEGER,
    manager     VARCHAR(100),
    is_active   BOOLEAN,
    date_opened DATE
);


-- Add store records
INSERT INTO stores VALUES (101, 'Lagos', 125000, 'Olumide David', TRUE, '2022-01-15');
INSERT INTO stores VALUES (102, 'Abuja', 89000, 'Amaka Okonkwo', TRUE, '2022-03-20');
INSERT INTO stores VALUES (103, 'Kano', 204000, 'Chidi Nwosu', FALSE, '2021-11-05');
INSERT INTO stores VALUES (104, 'Ibadan', 67000, 'Fatima Abdullahi', TRUE, '2023-07-10');
INSERT INTO stores VALUES (105, 'Port Harcourt', 204000, 'Emeka Obi', TRUE, '2021-08-30');
INSERT INTO stores VALUES (106, 'Enugu', 45000, 'Ngozi Eze', FALSE, '2023-01-20');
INSERT INTO stores VALUES (107, 'Benin City', 178000, 'Tunde Bakare', TRUE, '2022-09-14');

select *
from stores


DELETE FROM stores
WHERE ctid IN (
    SELECT ctid
    FROM stores
    ORDER BY ctid
    OFFSET 7
);


-- Get only specific columns
SELECT city, revenue FROM stores;


-- Calculate tax and final revenue
SELECT
    city,
    revenue,
    revenue * 0.075 AS tax,
    revenue * 1.075 AS revenue_after_tax
FROM stores;


-- Show unique cities only (no duplicates)
SELECT DISTINCT city FROM stores;


-- Show only active stores
SELECT * FROM stores
WHERE is_active = TRUE;

-- Show stores with revenue above 100,000
SELECT city, revenue FROM stores
WHERE revenue > 100000;

-- Show stores in Lagos only
SELECT * FROM stores
WHERE city = 'Lagos';


-- AND - both conditions must be true
SELECT city, revenue FROM stores
WHERE is_active = TRUE
AND revenue > 100000;


-- OR - at least one condition must be true
SELECT city, revenue FROM stores
WHERE city = 'Lagos'
OR city = 'Abuja';


-- IN - match any value in a list (cleaner than multiple ORs)
SELECT city, revenue FROM stores
WHERE city IN ('Lagos', 'Abuja', 'Kano');

-- BETWEEN - within a range
SELECT city, revenue FROM stores
WHERE revenue BETWEEN 80000 AND 150000;

-- LIKE - pattern matching (% means "anything")
SELECT * FROM stores
WHERE manager LIKE 'A%';
-- Gets all managers whose name starts with A


-- IS NULL - find missing values
SELECT * FROM stores
WHERE manager IS NULL;


-- Sort by revenue lowest to highest (ASC = ascending)
SELECT city, revenue FROM stores
ORDER BY revenue ASC;

-- Sort by revenue highest to lowest (DESC = descending)
SELECT city, revenue FROM stores
ORDER BY revenue DESC;

-- Sort by city name alphabetically
SELECT city, revenue FROM stores
ORDER BY city ASC;

-- Sort by multiple columns
-- First by is_active, then by revenue within each group
SELECT city, revenue, is_active FROM stores
ORDER BY is_active DESC, revenue DESC;


-- Show active stores with revenue above 100,000
-- Display city and revenue
-- Sort by highest revenue first
SELECT
    city,
    revenue,
    revenue * 1.075 AS revenue_after_tax,
    manager
FROM stores
WHERE is_active = TRUE
AND revenue > 100000
ORDER BY revenue DESC;


-- Get only the top 3 stores by revenue
SELECT city, revenue FROM stores
ORDER BY revenue DESC
LIMIT 3;


-- 1. Show all stores
SELECT * FROM stores;

-- 2. Show only city and revenue, sorted by revenue descending
SELECT city, revenue FROM stores
ORDER BY revenue DESC;

-- 3. Show only inactive stores
SELECT city, manager FROM stores
WHERE is_active = FALSE;

-- 4. Show stores opened after 2022
SELECT city, date_opened FROM stores
WHERE date_opened > '2022-01-01'
ORDER BY date_opened ASC;

-- 5. Show top 3 highest revenue stores
SELECT city, revenue FROM stores
ORDER BY revenue DESC
LIMIT 3;

-- 6. Show stores in Kano or Lagos
SELECT * FROM stores
WHERE city IN ('Kano', 'Lagos');

-- 7. Show stores where revenue is between 80000 and 200000
SELECT city, revenue FROM stores
WHERE revenue BETWEEN 80000 AND 200000
ORDER BY revenue DESC;

-- 8. Show all managers whose name starts with letter A through E
SELECT manager, city FROM stores
WHERE manager BETWEEN 'A' AND 'F'
ORDER BY manager;