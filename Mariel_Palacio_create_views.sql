CREATE VIEW vw_product_seasonality AS
SELECT
    p.product_id,
    p.product_name,
    d.month,
    d.year,
    SUM(f.quantity) AS total_units_sold,
    SUM(f.total_sales) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY p.product_id, p.product_name, d.month, d.year;

CREATE VIEW vw_discount_impact_analysis AS
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(f.discount_amount / NULLIF(f.total_sales, 0)), 3) AS avg_discount_pct,
    SUM(f.total_sales - f.total_cost) AS total_profit,
    SUM(f.total_sales) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_name;

CREATE VIEW vw_customer_order_patterns AS
SELECT
    c.customer_id,
    s.segment,
    COUNT(*) AS order_count,
    AVG(f.total_sales) AS avg_order_value,
    SUM(f.total_sales - f.total_cost) AS total_profit
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
JOIN dim_segment s ON c.segment_id = s.segment_id
GROUP BY c.customer_id, s.segment;

CREATE VIEW vw_channel_margin_report AS
SELECT
    f.order_mode_id AS sales_channel,
    SUM(f.total_sales) AS total_sales,
    SUM(f.total_cost) AS total_cost,
    SUM(f.total_sales - f.total_cost) AS total_profit,
    ROUND(SUM(f.total_sales - f.total_cost) * 100.0 / SUM(f.total_sales), 2) AS profit_margin_pct
FROM fact_sales f
GROUP BY f.order_mode_id;

CREATE VIEW vw_region_category_rankings AS
SELECT
    l.region_cleaned AS region,
    c.category_cleaned_id AS category,
    SUM(f.total_sales - f.total_cost) AS total_profit,
    RANK() OVER (
        PARTITION BY l.region_cleaned
        ORDER BY SUM(f.total_sales - f.total_cost) DESC
    ) AS category_rank
FROM fact_sales f
JOIN dim_location l ON f.location_id = l.location_id
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_category c ON p.category_cleaned_id = c.category_cleaned_id
GROUP BY region, category;
