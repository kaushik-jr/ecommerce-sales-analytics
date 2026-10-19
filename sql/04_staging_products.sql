CREATE OR REPLACE TABLE staging.products AS
SELECT
  p.product_id,
  COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category_english,
  p.product_weight_g AS weight_g,
  p.product_photos_qty AS photos_qty
FROM raw.products AS p
LEFT JOIN raw.category_translation AS t
  ON p.product_category_name = t.product_category_name;
