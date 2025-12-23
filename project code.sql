SELECT COUNT(*) FROM countries;
SELECT COUNT(*) FROM cities;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM restaurants;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM items;
SELECT COUNT(*) FROM deliveries;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


CREATE TABLE public.items (
    item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id)
        REFERENCES public.orders(order_id)
);

SELECT
    order_id,
    customer_id,
    restaurant_id,
    order_date,
    total_amount,
    status
FROM orders
ORDER BY order_id;

SELECT * FROM items;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'items'
ORDER BY ordinal_position;

SELECT order_id FROM orders ORDER BY order_id;

COPY items (order_id, item_name, quantity, price)
FROM 'C:/Postgres Project/items.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM items ORDER BY item_id;

SELECT
    o.order_id,
    SUM(i.quantity * i.price) AS calculated_order_total,
    o.total_amount AS recorded_order_total
FROM orders o
JOIN items i
    ON o.order_id = i.order_id
GROUP BY o.order_id, o.total_amount
ORDER BY o.order_id;

SELECT
    r.restaurant_name,
    SUM(i.quantity * i.price) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN items i
    ON o.order_id = i.order_id
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC;


SELECT
    c.city_name,
    r.cuisine_type,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN cities c
    ON r.city_id = c.city_id
GROUP BY c.city_name, r.cuisine_type
ORDER BY c.city_name, total_orders DESC;

SELECT
    c.city_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(
        COUNT(o.order_id)::numeric / COUNT(DISTINCT o.customer_id),
        2
    ) AS avg_orders_per_customer
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN cities c
    ON cu.city_id = c.city_id
GROUP BY c.city_name
ORDER BY avg_orders_per_customer DESC;

SELECT
    ci.city_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(
        COUNT(o.order_id)::numeric / COUNT(DISTINCT o.customer_id),
        2
    ) AS avg_orders_per_customer
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN cities ci
    ON cu.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY avg_orders_per_customer DESC;


SELECT
    r.restaurant_name,
    SUM(i.quantity * i.price) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN items i
    ON o.order_id = i.order_id
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC;


SELECT
    c.city_name,
    r.cuisine_type,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN cities c
    ON r.city_id = c.city_id
GROUP BY c.city_name, r.cuisine_type
ORDER BY c.city_name, total_orders DESC;


SELECT
    ci.city_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(
        COUNT(o.order_id)::numeric / COUNT(DISTINCT o.customer_id),
        2
    ) AS avg_orders_per_customer
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN cities ci
    ON cu.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY avg_orders_per_customer DESC;


SELECT
    ci.city_name,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
    ROUND(
        SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END)::numeric / COUNT(o.order_id), 
        2
    ) AS completion_rate
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN cities ci
    ON cu.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY completion_rate DESC;


SELECT
    cu.customer_name,
    ci.city_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers cu
JOIN orders o
    ON cu.customer_id = o.customer_id
JOIN cities ci
    ON cu.city_id = ci.city_id
GROUP BY cu.customer_name, ci.city_name
ORDER BY total_orders DESC, avg_order_value DESC;


SELECT
    o.order_id,
    SUM(i.quantity * i.price) AS calculated_order_total,
    o.total_amount AS recorded_order_total
FROM orders o
JOIN items i
    ON o.order_id = i.order_id
GROUP BY o.order_id, o.total_amount
ORDER BY o.order_id;



