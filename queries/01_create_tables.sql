
CREATE TABLE customers (
    customer_id         VARCHAR PRIMARY KEY,
    customer_unique_id  VARCHAR,
    customer_zip_code   VARCHAR,
    customer_city       VARCHAR,
    customer_state      VARCHAR
);


CREATE TABLE orders (
    order_id                        VARCHAR PRIMARY KEY,
    customer_id                     VARCHAR,
    order_status                    VARCHAR,
    order_purchase_timestamp        TIMESTAMP,
    order_approved_at               TIMESTAMP,
    order_delivered_carrier_date    TIMESTAMP,
    order_delivered_customer_date   TIMESTAMP,
    order_estimated_delivery_date   TIMESTAMP
);


CREATE TABLE order_items (
    order_id             VARCHAR,
    order_item_id        INT,
    product_id           VARCHAR,
    seller_id            VARCHAR,
    shipping_limit_date  TIMESTAMP,
    price                NUMERIC,
    freight_value        NUMERIC
);


CREATE TABLE order_payments (
    order_id              VARCHAR,
    payment_sequential    INT,
    payment_type          VARCHAR,
    payment_installments  INT,
    payment_value         NUMERIC
);


CREATE TABLE order_reviews (
    review_id               VARCHAR,
    order_id                VARCHAR,
    review_score            INT,
    review_comment_title    VARCHAR,
    review_comment_message  TEXT,
    review_creation_date    TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);


CREATE TABLE products (
    product_id                  VARCHAR PRIMARY KEY,
    product_category_name       VARCHAR,
    product_name_length         INT,
    product_description_length  INT,
    product_photos_qty          INT,
    product_weight_g            NUMERIC,
    product_length_cm           NUMERIC,
    product_height_cm           NUMERIC,
    product_width_cm            NUMERIC
);


CREATE TABLE sellers (
    seller_id          VARCHAR PRIMARY KEY,
    seller_zip_code    VARCHAR,
    seller_city        VARCHAR,
    seller_state       VARCHAR
);


CREATE TABLE geolocation (
    geolocation_zip_code  VARCHAR,
    geolocation_lat       NUMERIC,
    geolocation_lng       NUMERIC,
    geolocation_city      VARCHAR,
    geolocation_state     VARCHAR
);


CREATE TABLE category_translation (
    product_category_name          VARCHAR,
    product_category_name_english  VARCHAR
);



SELECT * FROM customers;
-- Should return ~99,000 rows