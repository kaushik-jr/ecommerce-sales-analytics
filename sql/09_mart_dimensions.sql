CREATE OR REPLACE TABLE mart.dim_date AS
SELECT
  d AS full_date,
  EXTRACT(YEAR FROM d) AS year,
  EXTRACT(MONTH FROM d) AS month,
  FORMAT_DATE('%B', d) AS month_name,
  EXTRACT(QUARTER FROM d) AS quarter,
  FORMAT_DATE('%A', d) AS weekday
FROM UNNEST(GENERATE_DATE_ARRAY('2016-01-01', '2018-12-31')) AS d;
CREATE OR REPLACE TABLE mart.dim_customer AS
SELECT customer_id, customer_unique_id, city, state
FROM staging.customers;
CREATE OR REPLACE TABLE mart.dim_product AS
SELECT product_id, category_english, weight_g
FROM staging.products;
CREATE OR REPLACE TABLE mart.dim_seller AS
SELECT seller_id, city, state
FROM staging.sellers;
