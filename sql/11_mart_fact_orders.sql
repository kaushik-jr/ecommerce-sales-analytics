CREATE OR REPLACE TABLE mart.fact_orders AS
SELECT
  o.order_id,
  o.customer_id,
  o.order_status,
  o.purchase_date,
  DATE(o.delivered_ts) AS delivered_date,
  DATE(o.estimated_ts) AS estimated_date,
  o.delivery_days,
  o.delay_days,
  CASE
    WHEN o.delivered_ts IS NULL THEN NULL
    WHEN o.delay_days > 0 THEN TRUE
    ELSE FALSE
  END AS is_late,
  p.payment_total,
  p.main_payment_type,
  r.review_score
FROM staging.orders AS o
LEFT JOIN staging.order_payments AS p ON o.order_id = p.order_id
LEFT JOIN staging.reviews AS r ON o.order_id = r.order_id;
