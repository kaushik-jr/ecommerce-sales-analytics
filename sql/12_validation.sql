SELECT
  (SELECT COUNT(*) FROM mart.fact_orders) AS fact_orders_rows,
  (SELECT COUNT(*) FROM mart.fact_order_items) AS fact_items_rows,
  (SELECT ROUND(SUM(price), 2) FROM staging.order_items) AS staging_revenue,
  (SELECT ROUND(SUM(price), 2) FROM mart.fact_order_items) AS mart_revenue;
