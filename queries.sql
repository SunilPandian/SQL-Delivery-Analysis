-- Total Restaurants
SELECT COUNT(DISTINCT restaurant) AS total_restaurants
FROM orders;

-- Average Delivery Time
SELECT AVG(delivery_time) AS avg_delivery_time
FROM orders;

-- Price Category Analysis
SELECT 
    CASE 
        WHEN price < 200 THEN 'Budget'
        WHEN price BETWEEN 200 AND 500 THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_category,
    COUNT(*) AS total_restaurants
FROM orders
GROUP BY price_category;

-- Rating vs Delivery Speed
SELECT 
    CASE 
        WHEN delivery_time <= 30 THEN 'Fast'
        WHEN delivery_time <= 50 THEN 'Moderate'
        ELSE 'Slow'
    END AS delivery_speed,
    ROUND(AVG(avg_ratings),2) AS avg_rating
FROM orders
GROUP BY delivery_speed;

-- ===============================
-- ADVANCED SQL QUERIES
-- ===============================

-- CTE: Above Average Rated Restaurants
WITH avg_rating_cte AS (
    SELECT AVG(avg_ratings) AS overall_avg_rating
    FROM orders
)
SELECT 
    restaurant,
    avg_ratings
FROM orders, avg_rating_cte
WHERE orders.avg_ratings > avg_rating_cte.overall_avg_rating
ORDER BY avg_ratings DESC;


-- Window Function: Ranking Restaurants
SELECT 
    restaurant,
    avg_ratings,
    RANK() OVER (ORDER BY avg_ratings DESC) AS ranking
FROM orders;


-- Top 3 Restaurants per City
WITH ranked_restaurants AS (
    SELECT 
        city,
        restaurant,
        avg_ratings,
        RANK() OVER (PARTITION BY city ORDER BY avg_ratings DESC) AS rank_in_city
    FROM orders
)
SELECT 
    city,
    restaurant,
    avg_ratings,
    rank_in_city
FROM ranked_restaurants
WHERE rank_in_city <= 3
ORDER BY city, rank_in_city;
