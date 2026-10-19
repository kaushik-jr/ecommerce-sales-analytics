CREATE OR REPLACE TABLE staging.orders AS
SELECT
  order_id,
  customer_id,
  order_status,
  order_purchase_timestamp      AS purchase_ts,
  order_approved_at             AS approved_ts,
  order_delivered_customer_date AS delivered_ts,
  order_estimated_delivery_date AS estimated_ts,
  DATE(order_purchase_timestamp) AS purchase_date,
  DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) AS delivery_days,
  DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS delay_days
FROM raw.orders
WHERE order_status NOT IN ('canceled', 'unavailable');
