-- seller_dim
SELECT `id` as `seller_id`,
    `seller`.`zip_code_prefix` as `zip_code`,
    `seller`.`city` as `city`,
    `seller`.`state` as `state`,
    `latitude`,
    `longitude`
FROM seller
    JOIN geolocation ON seller.zip_code_prefix = geolocation.zip_code_prefix
LIMIT 50;
-- customer_order_dim?
