CREATE OR REPLACE TABLE mart.fact_order_items AS
SELECT
  i.order_id,
  i.order_item_id,
  i.product_id,
  i.seller_id,
  o.customer_id,
  o.purchase_date,
  i.price,
  i.freight_value,
  i.total_item_value
FROM staging.order_items AS i
JOIN staging.orders AS o
  ON i.order_id = o.order_id;
