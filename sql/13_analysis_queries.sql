-- Q1: Monthly revenue and orders
SELECT
  FORMAT_DATE('%Y-%m', purchase_date) AS month,
  COUNT(DISTINCT order_id) AS orders,
  ROUND(SUM(price), 2) AS revenue
FROM mart.fact_order_items
GROUP BY month
ORDER BY month;

-- Q2: Top 10 categories by revenue
SELECT
  p.category_english,
  ROUND(SUM(i.price), 2) AS revenue,
  COUNT(DISTINCT i.order_id) AS orders
FROM mart.fact_order_items AS i
JOIN mart.dim_product AS p ON i.product_id = p.product_id
GROUP BY p.category_english
ORDER BY revenue DESC
LIMIT 10;

-- Q3: Average delivery days by state
SELECT
  c.state,
  ROUND(AVG(o.delivery_days), 1) AS avg_delivery_days,
  COUNT(*) AS delivered_orders
FROM mart.fact_orders AS o
JOIN mart.dim_customer AS c ON o.customer_id = c.customer_id
WHERE o.delivery_days IS NOT NULL
GROUP BY c.state
ORDER BY avg_delivery_days DESC;

-- Q4: Late delivery percentage
SELECT
  ROUND(100 * COUNTIF(is_late) / COUNTIF(is_late IS NOT NULL), 2) AS late_delivery_pct
FROM mart.fact_orders;

-- Q5: Review score, late vs on-time
SELECT
  is_late,
  ROUND(AVG(review_score), 2) AS avg_review_score,
  COUNT(*) AS orders
FROM mart.fact_orders
WHERE is_late IS NOT NULL AND review_score IS NOT NULL
GROUP BY is_late;

-- Q6: Month-over-month revenue growth
WITH monthly AS (
  SELECT
    DATE_TRUNC(purchase_date, MONTH) AS month,
    SUM(price) AS revenue
  FROM mart.fact_order_items
  GROUP BY month
)
SELECT
  month,
  ROUND(revenue, 2) AS revenue,
  ROUND(100 * (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month), 1) AS mom_growth_pct
FROM monthly
ORDER BY month;

-- Q7: Top 10 sellers by revenue
SELECT
  seller_id,
  ROUND(SUM(price), 2) AS revenue,
  RANK() OVER (ORDER BY SUM(price) DESC) AS revenue_rank
FROM mart.fact_order_items
GROUP BY seller_id
ORDER BY revenue_rank
LIMIT 10;
