-- 02_insert_data.sql

COPY countries(country_name)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/countries.csv'
DELIMITER ','
CSV HEADER;

COPY cities(city_name, country_id)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/cities.csv'
DELIMITER ','
CSV HEADER;

COPY customers(customer_name, email, city_id)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/customers.csv'
DELIMITER ','
CSV HEADER;

COPY restaurants(restaurant_name, cuisine_type, city_id)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/restaurants.csv'
DELIMITER ','
CSV HEADER;

COPY orders(customer_id, restaurant_id, order_date, total_amount, status)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/orders.csv'
DELIMITER ','
CSV HEADER;

COPY items(order_id, item_name, quantity, price)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/items.csv'
DELIMITER ','
CSV HEADER;

COPY deliveries(order_id, delivery_date, delivery_status)
FROM 'C:/Postgres Project/restaurant-delivery-sql/data/deliveries.csv'
DELIMITER ','
CSV HEADER;
