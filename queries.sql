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
