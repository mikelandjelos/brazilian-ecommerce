-- This dataset has information Brazilian zip codes and its lat/lng coordinates. 
-- Use it to plot maps and find distances between sellers and customers.
CREATE TABLE `geolocation` (
    `zip_code_prefix` VARCHAR(5) NOT NULL,
    `latitude` DECIMAL(10, 8),
    `longitude` DECIMAL(11, 8),
    `city` VARCHAR(100) NOT NULL,
    `state` VARCHAR(2) NOT NULL,
    PRIMARY KEY (`zip_code_prefix`)
);
-- This dataset includes data about the sellers that fulfilled orders made at Olist. 
-- Use it to find the seller location and to identify which seller fulfilled each product.
CREATE TABLE `seller` (
    `id` VARCHAR(50),
    `zip_code_prefix` VARCHAR(5) NOT NULL,
    `city` VARCHAR(100) NOT NULL,
    `state` VARCHAR(2) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`zip_code_prefix`) REFERENCES `geolocation` (`zip_code_prefix`)
);
-- This dataset includes data about the products sold by Olist.
CREATE TABLE `product` (
    `id` VARCHAR(50),
    `category_name` VARCHAR(100),
    `name_length` INT,
    `description_length` INT,
    `photos_qty` INT,
    `weight_g` INT,
    `length_cm` INT,
    `height_cm` INT,
    `width_cm` INT,
    PRIMARY KEY (`id`)
);
-- This is the core dataset. From each order you might find all other information.
CREATE TABLE `order` (
    `id` VARCHAR(50),
    `customer_id` VARCHAR(50) NOT NULL,
    `status` VARCHAR(50),
    `purchase_timestamp` DATETIME,
    `approved_at` DATETIME,
    `delivered_carrier_date` DATETIME,
    `delivered_customer_date` DATETIME,
    `estimated_delivery_date` DATETIME,
    PRIMARY KEY (`id`),
    UNIQUE (`customer_id`)
);
-- This dataset has information about the customer and its location. 
-- Use it to identify unique customers in the orders dataset and to find the orders delivery location.
-- At our system each order is assigned to a unique customer_id. 
-- This means that the same customer will get different ids for different orders. 
-- The purpose of having a customer_unique_id on the dataset is to allow you to identify customers that made repurchases at the store. 
-- Otherwise you would find that each order had a different customer associated with.
CREATE TABLE `customer` (
    `order_customer_id` VARCHAR(50) NOT NULL,
    `id` VARCHAR(50) NOT NULL,
    `zip_code_prefix` VARCHAR(5) NOT NULL,
    `city` VARCHAR(100) NOT NULL,
    `state` VARCHAR(2) NOT NULL,
    PRIMARY KEY (`order_customer_id`),
    FOREIGN KEY (`order_customer_id`) REFERENCES `order` (`customer_id`),
    FOREIGN KEY (`zip_code_prefix`) REFERENCES `geolocation` (`zip_code_prefix`)
);
-- This dataset includes data about the items purchased within each order.
CREATE TABLE `order_item` (
    `order_id` VARCHAR(50) NOT NULL,
    `order_item_sequential` INT NOT NULL,
    `product_id` VARCHAR(50) NOT NULL,
    `seller_id` VARCHAR(50) NOT NULL,
    `shipping_limit_date` DATETIME NOT NULL,
    `price` DOUBLE UNSIGNED NOT NULL,
    `freight_value` DOUBLE UNSIGNED NOT NULL,
    PRIMARY KEY (`order_id`, `order_item_sequential`),
    FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
    FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
    FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`)
);
-- This dataset includes data about the orders payment options.
CREATE TABLE `payment` (
    `order_id` VARCHAR(50) NOT NULL,
    `payment_sequential` INT NOT NULL,
    `payment_type` VARCHAR(255) NOT NULL,
    `payment_installments` INT NOT NULL,
    `payment_value` DOUBLE UNSIGNED NOT NULL,
    PRIMARY KEY (`order_id`, `payment_sequential`),
    FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
);
-- This dataset includes data about the reviews made by the customers.
-- After a customer purchases the product from Olist Store a seller gets notified to fulfill that order. 
-- Once the customer receives the product, or the estimated delivery date is due, 
-- the customer gets a satisfaction survey by email where he can give a note for the purchase experience and write down some comments.
CREATE TABLE `review` (
    `id` VARCHAR(50),
    `order_id` VARCHAR(50) NOT NULL,
    `score` INT NOT NULL,
    `comment_title` VARCHAR(255),
    `comment_message` TEXT,
    `creation_date` DATE NOT NULL,
    `answer_timestamp` TIMESTAMP NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
);