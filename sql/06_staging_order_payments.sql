CREATE OR REPLACE TABLE staging.order_payments AS
SELECT
  order_id,
  SUM(payment_value) AS payment_total,
  ARRAY_AGG(payment_type ORDER BY payment_value DESC LIMIT 1)[OFFSET(0)] AS main_payment_type
FROM raw.payments
GROUP BY order_id;
