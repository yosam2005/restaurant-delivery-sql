-- 03_analysis_queries.sql

-- 1. Check order totals
SELECT
    o.order_id,
    SUM(i.quantity * i.price) AS calculated_order_total,
    o.total_amount AS recorded_order_total
FROM orders o
JOIN items i ON o.order_id = i.order_id
GROUP BY o.order_id, o.total_amount
ORDER BY o.order_id;


-- 2. Revenue per restaurant
SELECT
    r.restaurant_name,
    SUM(i.quantity * i.price) AS total_revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN items i ON o.order_id = i.order_id
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC;


-- 3. Total orders per city and cuisine
SELECT
    c.city_name,
    r.cuisine_type,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN cities c ON r.city_id = c.city_id
GROUP BY c.city_name, r.cuisine_type
ORDER BY c.city_name, total_orders DESC;


-- 4. Total orders per city, unique customers, and average orders per customer
SELECT
    c.city_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(
        COUNT(o.order_id)::numeric / COUNT(DISTINCT o.customer_id),
        2
    ) AS avg_orders_per_customer
FROM orders o
JOIN customers cu ON o.customer_id = cu.customer_id
JOIN cities c ON cu.city_id = c.city_id
GROUP BY c.city_name
ORDER BY total_orders DESC;


-- 5. Order completion rate
SELECT
    c.city_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN o.status = 'completed' THEN 1 END) AS completed_orders,
    ROUND(
        COUNT(CASE WHEN o.status = 'completed' THEN 1 END)::numeric
        / COUNT(o.order_id),
        2
    ) AS completion_rate
FROM orders o
JOIN customers cu ON o.customer_id = cu.customer_id
JOIN cities c ON cu.city_id = c.city_id
GROUP BY c.city_name
ORDER BY completion_rate DESC;