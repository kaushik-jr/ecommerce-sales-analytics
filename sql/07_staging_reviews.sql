CREATE OR REPLACE TABLE staging.reviews AS
SELECT
  order_id,
  SAFE_CAST(review_score AS INT64) AS review_score
FROM raw.reviews
WHERE SAFE_CAST(review_score AS INT64) BETWEEN 1 AND 5
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY order_id
  ORDER BY review_answer_timestamp DESC
) = 1;
