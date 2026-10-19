-- Check 1: category_translation row count (expected 71)
SELECT COUNT(*) AS row_count FROM raw.category_translation;

-- Check 2: duplicate order IDs (expected: no rows)
SELECT order_id, COUNT(*) AS cnt
FROM raw.orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check 3: order status distribution
SELECT order_status, COUNT(*) AS orders
FROM raw.orders
GROUP BY order_status
ORDER BY orders DESC;

-- Check 4: missing values in orders
SELECT
  COUNTIF(order_delivered_customer_date IS NULL) AS missing_delivered_date,
  COUNTIF(order_approved_at IS NULL) AS missing_approved_date,
  COUNT(*) AS total_orders
FROM raw.orders;

-- Check 5: products with missing category
SELECT COUNTIF(product_category_name IS NULL) AS missing_category
FROM raw.products;

-- Check 6: duplicated review IDs
SELECT COUNT(*) AS duplicated_review_ids
FROM (
  SELECT review_id
  FROM raw.reviews
  GROUP BY review_id
  HAVING COUNT(*) > 1
);
