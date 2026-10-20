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

## Key insights
- Monthly revenue grew from about 120K (Jan 2017) to about 990K (Apr 2018), then levelled off through Aug 2018. Sep 2016, Dec 2016 and Sep 2018 have almost no data and are excluded from trend analysis.
- Top category by revenue is health_beauty (about 1.26M), followed by watches_gifts (about 1.20M). watches_gifts earns that revenue from far fewer orders, so its revenue per order is much higher.
- 6.77% of delivered orders arrived after the estimated date.
- Late orders averaged a review score of 2.27 versus 4.29 for on-time orders, so late delivery is strongly associated with lower customer satisfaction.
- - Month-over-month growth is only meaningful from Feb 2017 onward. Early 2016 months and Sep 2018 have too little data, so their percentages (for example +21,312% in Oct 2016) are artifacts of a tiny base.
  - - The top 10 sellers (of about 3,095) generate roughly 13% of total revenue; the #1 seller alone earned about 229K.
    - - A single-day revenue spike of about 150K on Black Friday (24 Nov 2017) is roughly 4x a normal day.
- Delivery is slowest to remote northern states (RR about 29 days, AP about 27, AM about 26) and fastest in the southeast. São Paulo (SP) is about 8 to 9 days.
