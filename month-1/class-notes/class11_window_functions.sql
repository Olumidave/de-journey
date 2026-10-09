-- Number each sale within each city
-- Most expensive sale in each city gets number 1
SELECT
    city,
    product,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY city
        ORDER BY amount DESC
    ) AS sale_rank
FROM sales
ORDER BY city, sale_rank;


-- Get ONLY the highest sale in each city
-- Step 1: Rank sales within each city
-- Step 2: Filter where rank = 1

WITH ranked_sales AS (
    SELECT
        city,
        product,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY amount DESC
        ) AS sale_rank
    FROM sales
)
SELECT city, product, amount
FROM ranked_sales
WHERE sale_rank = 1
ORDER BY amount DESC;

SELECT
    city,
    amount,
    ROW_NUMBER()  OVER (ORDER BY amount DESC) AS row_num,
    RANK()        OVER (ORDER BY amount DESC) AS rank_num,
    DENSE_RANK()  OVER (ORDER BY amount DESC) AS dense_rank
FROM sales
ORDER BY amount DESC;


-- Running total of sales by date
SELECT
    sale_date,
    city,
    amount,
    SUM(amount) OVER (
        ORDER BY sale_date
    ) AS running_total
FROM sales
ORDER BY sale_date;


-- Running total WITHIN each city separately
SELECT
    city,
    sale_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY city
        ORDER BY sale_date
    ) AS city_running_total
FROM sales
ORDER BY city, sale_date;


-- Show each sale compared to its city average
SELECT
    city,
    product,
    amount,
    ROUND(AVG(amount) OVER (PARTITION BY city), 0) AS city_avg,
    amount - ROUND(AVG(amount) OVER (PARTITION BY city), 0) AS diff_from_avg
FROM sales
ORDER BY city, amount DESC;

-- Compare each day's total sales to the previous day
SELECT
    sale_date,
    SUM(amount) AS daily_total,
    LAG(SUM(amount)) OVER (ORDER BY sale_date) AS previous_day,
    SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY sale_date) AS day_over_day_change
FROM sales
GROUP BY sale_date
ORDER BY sale_date;


-- Step 1: Calculate city totals (CTE)
WITH city_totals AS (
    SELECT
        city,
        SUM(amount) AS total_revenue,
        COUNT(*)    AS num_sales
    FROM sales
    GROUP BY city
),

-- Step 2: Calculate overall average (second CTE)
overall_avg AS (
    SELECT AVG(total_revenue) AS avg_revenue
    FROM city_totals
)

-- Step 3: Use both CTEs in final query
SELECT
    ct.city,
    ct.total_revenue,
    oa.avg_revenue,
    CASE
        WHEN ct.total_revenue > oa.avg_revenue THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM city_totals ct, overall_avg oa
ORDER BY ct.total_revenue DESC;


SELECT
    city,
    amount,
    CASE
        WHEN amount >= 500000 THEN 'Premium Sale'
        WHEN amount >= 100000 THEN 'Standard Sale'
        WHEN amount >= 10000  THEN 'Small Sale'
        ELSE 'Micro Sale'
    END AS sale_category
FROM sales
ORDER BY amount DESC;


-- 1. Rank all sales by amount (highest first)
SELECT
    city,
    product,
    amount,
    RANK() OVER (ORDER BY amount DESC) AS overall_rank
FROM sales;

-- 2. Top sale per city
WITH ranked AS (
    SELECT
        city,
        product,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY amount DESC
        ) AS rn
    FROM sales
)
SELECT city, product, amount
FROM ranked
WHERE rn = 1;

-- 3. Each sale vs city average
SELECT
    city,
    product,
    amount,
    ROUND(AVG(amount) OVER (PARTITION BY city), 0) AS city_avg,
    CASE
        WHEN amount > AVG(amount) OVER (PARTITION BY city)
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS vs_average
FROM sales
ORDER BY city, amount DESC;

-- 4. Running total by date
SELECT
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date) AS running_total
FROM sales
ORDER BY sale_date;

-- 5. City performance label
SELECT
    city,
    SUM(amount) AS total,
    CASE
        WHEN SUM(amount) > 1000000 THEN 'Top Performer'
        WHEN SUM(amount) > 500000  THEN 'Mid Performer'
        ELSE 'Needs Attention'
    END AS performance
FROM sales
GROUP BY city
ORDER BY total DESC;
