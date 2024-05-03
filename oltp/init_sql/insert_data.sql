LOAD DATA INFILE '/home/dataset/olist_geolocation_dataset.csv' IGNORE INTO TABLE `geolocation` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `zip_code_prefix`,
    `latitude`,
    `longitude`,
    `city`,
    `state`
);
LOAD DATA INFILE '/home/dataset/olist_sellers_dataset.csv' IGNORE INTO TABLE `seller` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (`id`, `zip_code_prefix`, `city`, `state`);
LOAD DATA INFILE '/home/dataset/olist_products_dataset.csv' IGNORE INTO TABLE `product` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `id`,
    `category_name`,
    `name_length`,
    `description_length`,
    `photos_qty`,
    `weight_g`,
    `length_cm`,
    `height_cm`,
    `width_cm`
);
LOAD DATA INFILE '/home/dataset/olist_orders_dataset.csv' IGNORE INTO TABLE `order` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `id`,
    `customer_id`,
    `status`,
    `purchase_timestamp`,
    `approved_at`,
    `delivered_carrier_date`,
    `delivered_customer_date`,
    `estimated_delivery_date`
);
LOAD DATA INFILE '/home/dataset/olist_customers_dataset.csv' IGNORE INTO TABLE `customer` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `order_customer_id`,
    `id`,
    `zip_code_prefix`,
    `city`,
    `state`
);
LOAD DATA INFILE '/home/dataset/olist_order_items_dataset.csv' IGNORE INTO TABLE `order_item` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `order_id`,
    `order_item_sequential`,
    `product_id`,
    `seller_id`,
    `shipping_limit_date`,
    `price`,
    `freight_value`
);
LOAD DATA INFILE '/home/dataset/olist_order_payments_dataset.csv' IGNORE INTO TABLE `payment` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `order_id`,
    `payment_sequential`,
    `payment_type`,
    `payment_installments`,
    `payment_value`
);
LOAD DATA INFILE '/home/dataset/olist_order_reviews_dataset.csv' IGNORE INTO TABLE `review` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (
    `id`,
    `order_id`,
    `score`,
    `comment_title`,
    `comment_message`,
    `creation_date`,
    `answer_timestamp`
);