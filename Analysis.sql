use pizza_db;

SELECT 
    *
FROM
    pizza_sales;

-- Total Revenue
SELECT 
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM
    pizza_sales;

-- Average order value 
SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id),
            2) AS Avg_order_value
FROM
    pizza_sales;

-- Total pizza sold
SELECT 
    SUM(quantity) AS Total_pizza_sold
FROM
    pizza_sales;

-- Total order placed 
SELECT 
    COUNT(DISTINCT order_id) AS Total_order_placed
FROM
    pizza_sales;

-- Average pizza per order
SELECT 
    ROUND(SUM(quantity) / COUNT(DISTINCT order_id),
            2) AS Avg_pizza_per_order
FROM
    pizza_sales;

-- Daily Trend
SELECT 
    DAYNAME(order_date) AS Day,
    COUNT(DISTINCT order_id) AS Total_order
FROM
    pizza_sales
GROUP BY DAYNAME(order_date);

-- Hourly trend
SELECT 
    HOUR(order_time) AS 'Time',
    COUNT(DISTINCT order_id) AS Total_order
FROM
    pizza_sales
GROUP BY HOUR(order_time);



-- 				Pizza Category Analysis

SELECT 
    pizza_category,
    ROUND(COUNT(pizza_category) * 100 / (SELECT 
                    COUNT(quantity)
                FROM
                    pizza_sales),
            2) AS Percentage_quantity_by_category
FROM
    pizza_sales
GROUP BY pizza_category;

-- Percentage of sale by pizza catergory
SELECT 
    pizza_category,
    ROUND(SUM(total_price) * 100 / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales),
            2) AS Percentage_sale_by_category
FROM
    pizza_sales
GROUP BY pizza_category;

-- Percentage of quantity by pizza catergory, by month
SELECT 
    pizza_category,
    ROUND(COUNT(pizza_category) * 100 / (SELECT 
                    COUNT(quantity)
                FROM
                    pizza_sales
                WHERE
                    MONTH(order_date) = 1),
            2) AS Percentage_quantity_by_category_by_month
FROM
    pizza_sales
WHERE
    MONTH(order_date) = 1
GROUP BY pizza_category;



-- 			Pizza Size Analysis

SELECT 
    pizza_size,
    ROUND(COUNT(pizza_size) * 100 / (SELECT 
                    COUNT(quantity)
                FROM
                    pizza_sales),
            2) AS Percentage_quantity_by_size
FROM
    pizza_sales
GROUP BY pizza_size;



-- Percentage of quantity by pizza size by month
SELECT 
    pizza_size,
    ROUND(COUNT(pizza_size) * 100 / (SELECT 
                    COUNT(quantity)
                FROM
                    pizza_sales
                WHERE
                    MONTH(order_date) = 1),
            2) AS Percentage_quantity_by_size_by_month
FROM
    pizza_sales
WHERE
    MONTH(order_date) = 1
GROUP BY pizza_size;


-- Total pizza sold by category
SELECT 
    pizza_category, SUM(quantity) AS Total_sold
FROM
    pizza_sales
GROUP BY pizza_category;

-- Top 5 pizza sold with total_sold
SELECT 
    pizza_name, SUM(quantity) AS Total_sold
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_sold DESC
LIMIT 5;

-- Bottom 5 pizza sold with total_sold
SELECT 
    pizza_name, SUM(quantity) AS Total_sold
FROM
    pizza_sales
WHERE
    pizza_name NOT LIKE '%The Pepperoni, Mushroom, and Peppers Pizza%' -- some data was missing and was replaced some radom text containing these string
GROUP BY pizza_name
ORDER BY Total_sold
LIMIT 5;











