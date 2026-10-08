-- Create countries table
CREATE TABLE IF NOT EXISTS countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Create cities table
CREATE TABLE IF NOT EXISTS cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT fk_country
        FOREIGN KEY(country_id) REFERENCES countries(country_id)
);

-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    CONSTRAINT fk_city
        FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

-- Create restaurants table
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    city_id INT NOT NULL,
    CONSTRAINT fk_city_restaurant
        FOREIGN KEY(city_id) REFERENCES cities(city_id)
);


-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    CONSTRAINT fk_customer
        FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_restaurant
        FOREIGN KEY(restaurant_id) REFERENCES restaurants(restaurant_id)
);


-- Create items table
CREATE TABLE IF NOT EXISTS items (
    item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_order
        FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

-- Create deliveries table
CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    delivery_date DATE,
    delivery_time INTERVAL,
    delivery_status VARCHAR(50) DEFAULT 'pending',
    CONSTRAINT fk_order_delivery
        FOREIGN KEY(order_id) REFERENCES orders(order_id)
);










