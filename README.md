# E-Commerce Sales Analytics (BigQuery + SQL + Power BI)

## Goal
Build a cloud data warehouse from the Olist Brazilian e-commerce dataset, clean and model it with SQL, and analyze sales and delivery performance.

## Tools
Google BigQuery (sandbox), SQL, Excel, Power BI Desktop, GitHub

## Dataset
[Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
The raw CSV files are not stored in this repo.

## Architecture
CSV files → BigQuery `raw` → `staging` (cleaned) → `mart` (star schema) → Power BI

## Raw table row counts
| Table | Rows loaded |
|---|---|
| customers | 99,441 |
| orders | 99,441 |
| order_items | 112,650 |
| payments | 103,886 |
| reviews | 99,224 |
| products | 32,951 |
| sellers | 3,095 |
| geolocation | 1,000,163 |
| category_translation | 71 |

## Issues found and fixed
- `category_translation` first loaded 72 rows because auto-detect treated the header as data. Fixed by reloading with an explicit schema and skipping the header row. Final count: 71.

## Decisions
- Cancelled and unavailable orders were excluded from staging because they generated no delivered revenue.
- Reviews were deduplicated to the latest one per order.
- Payments were aggregated to one row per order.
- Missing product categories were labeled "unknown".

## Validation
Mart revenue reconciles exactly with staging revenue (about 13.49M). Row counts: 98,207 orders and 112,101 order items.

## How to rebuild
Run the SQL files in the `sql/` folder in numbered order (01 to 12).
