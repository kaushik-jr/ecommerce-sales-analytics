CREATE OR REPLACE TABLE staging.order_items AS
SELECT
  i.order_id,
  i.order_item_id,
  i.product_id,
  i.seller_id,
  i.price,
  i.freight_value,
  i.price + i.freight_value AS total_item_value
FROM raw.order_items AS i
JOIN staging.orders AS o
  ON i.order_id = o.order_id;
