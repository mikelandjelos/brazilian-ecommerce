----------------------------------------------------------
-- DIMENSION TABLES
----------------------------------------------------------
-- Date dimension DDL
CREATE TABLE "date_dim" (
    "date_dim_id" NUMBER PRIMARY KEY,
    "order_date" DATE NOT NULL,
    "order_hour_day" NUMBER,
    "order_day_month" NUMBER NOT NULL,
    "order_month" NUMBER NOT NULL,
    "order_year" NUMBER NOT NULL,
    "order_quarter" NUMBER NOT NULL,
    CONSTRAINT "check_order_hour_day" CHECK (
        "order_hour_day" BETWEEN 0 AND 23
    ),
    CONSTRAINT "check_order_day_month" CHECK (
        "order_day_month" BETWEEN 1 AND 31
    ),
    CONSTRAINT "check_order_month" CHECK (
        "order_month" BETWEEN 1 AND 12
    ),
    CONSTRAINT "check_order_quarter" CHECK (
        "order_quarter" BETWEEN 1 AND 4
    )
);
-- Date dimension sequence
CREATE SEQUENCE "date_dim_s";
-- Date dimension  trigger
CREATE OR REPLACE TRIGGER "date_dim_on_insert" BEFORE
INSERT ON "date_dim" FOR EACH ROW BEGIN
SELECT "date_dim_s".NEXTVAL INTO :NEW. "date_dim_id"
FROM DUAL;
END;
----------------------------------------------------------
-- Customer dimension
CREATE TABLE "customer_dim" (
    "customer_dim_id" NUMBER(*, 0) PRIMARY KEY,
    "customer_id" VARCHAR(50) UNIQUE NOT NULL,
    "zip_code" VARCHAR(5) NOT NULL,
    "city" VARCHAR(100) NOT NULL,
    "state" VARCHAR(2) NOT NULL,
    "latitude" NUMBER(10, 8) NOT NULL,
    "longitude" NUMBER(11, 8) NOT NULL,
    "date_from" DATE NOT NULL,
    "date_to" DATE
);
-- Customer dimension sequence
CREATE SEQUENCE "customer_dim_s";
-- Customer dimension trigger
CREATE OR REPLACE TRIGGER "customer_dim_on_insert" BEFORE
INSERT ON "customer_dim" FOR EACH ROW BEGIN
SELECT "customer_dim_s".NEXTVAL INTO :NEW. "customer_dim_id"
FROM DUAL;
END;
----------------------------------------------------------
-- Seller dimension
CREATE TABLE "seller_dim" (
    "seller_dim_id" NUMBER(*, 0) PRIMARY KEY,
    "seller_id" VARCHAR(50) UNIQUE NOT NULL,
    "zip_code" VARCHAR(5) NOT NULL,
    "city" VARCHAR(100) NOT NULL,
    "state" VARCHAR(2) NOT NULL,
    "latitude" NUMBER(10, 8) NOT NULL,
    "longitude" NUMBER(11, 8) NOT NULL,
    "date_from" DATE NOT NULL,
    "date_to" DATE
);
-- Seller dimension sequence
CREATE SEQUENCE "seller_dim_s";
-- seller dimension trigger
CREATE OR REPLACE TRIGGER "seller_dim_on_insert" BEFORE
INSERT ON "seller_dim" FOR EACH ROW BEGIN
SELECT "seller_dim_s".NEXTVAL INTO :NEW. "seller_dim_id"
FROM DUAL;
END;
----------------------------------------------------------
-- Product dimension
CREATE TABLE "product_dim" (
    "product_dim_id" NUMBER(*, 0),
    "product_id" VARCHAR(50) UNIQUE NOT NULL,
    "category_name" VARCHAR(100) NOT NULL,
    "name_length" NUMBER(*, 0) NOT NULL,
    "description_length" NUMBER(*, 0) NOT NULL,
    "photos_quantity" NUMBER(*, 0) NOT NULL,
    "date_from" DATE NOT NULL,
    "date_to" DATE
);
-- Product dimension sequence
CREATE SEQUENCE "product_dim_s";
-- Product dimension trigger
CREATE OR REPLACE TRIGGER "product_dim_on_insert" BEFORE
INSERT ON "product_dim" FOR EACH ROW BEGIN
SELECT "product_dim_s".NEXTVAL INTO :NEW. "product_dim_id"
FROM DUAL;
END;
----------------------------------------------------------
-- FACT TABLE
----------------------------------------------------------
CREATE TABLE "order_item_fact" (
    "order_id" VARCHAR(50) NOT NULL,
    "order_item_sequential" NUMBER(*, 0) NOT NULL,
    "product_dim_id" NUMBER(*, 0) NOT NULL,
    "seller_dim_id" NUMBER(*, 0) NOT NULL,
    "customer_dim_id" NUMBER(*, 0) NOT NULL,
    "date_dim_id" NUMBER(*, 0) NOT NULL,
    "review_score" NUMBER(*, 0) NOT NULL,
    "price" NUMBER NOT NULL,
    "freight_value" NUMBER NOT NULL,
    PRIMARY KEY (
        "order_id",
        "order_item_sequential",
        "product_dim_id",
        "seller_dim_id",
        "customer_dim_id",
        "date_dim_id"
    )
);