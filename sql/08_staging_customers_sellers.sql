CREATE OR REPLACE TABLE staging.customers AS
SELECT
  customer_id,
  customer_unique_id,
  customer_city AS city,
  customer_state AS state
FROM raw.customers;

CREATE OR REPLACE TABLE staging.sellers AS
SELECT
  seller_id,
  seller_city AS city,
  seller_state AS state
FROM raw.sellers;
