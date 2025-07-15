SELECT 
    c.category_cleaned_id,
    SUM(f.total_sales) AS total_sales,
    SUM(f.total_sales - f.total_cost) AS total_profit
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_category c ON p.category_cleaned_id = c.category_cleaned_id
GROUP BY c.category_cleaned_id
ORDER BY total_sales DESC;

SELECT 
    d.year,
    d.month,
    SUM(f.total_sales - f.total_cost) AS monthly_profit
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

SELECT 
    l.region_cleaned AS region,
    SUM(f.total_sales - f.total_cost) AS total_profit
FROM fact_sales f
JOIN dim_location l ON f.location_id = l.location_id
GROUP BY l.region_cleaned
ORDER BY total_profit DESC;

SELECT 
    p.product_name,
    SUM(f.quantity) AS units_sold
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 10;

SELECT 
    p.segment_id,
    p.product_name,
    SUM(f.total_sales - f.total_cost) AS profit
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.segment_id, p.product_name
ORDER BY profit DESC;