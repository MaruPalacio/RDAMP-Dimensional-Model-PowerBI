--Table Customer
create_dim_customer = """
CREATE TABLE dim_customer (
    customer_id TEXT PRIMARY KEY
)
"""

--Table Location
create_dim_location = """
CREATE TABLE dim_location (
    location_id TEXT PRIMARY KEY,
    city TEXT,
    postal_code TEXT,
    country_cleaned TEXT,
    region_cleaned TEXT
)
"""

--- Table Category
create_dim_category = """
CREATE TABLE dim_category (
    category_cleaned_id TEXT PRIMARY KEY
)
"""

--- Table Segment
create_dim_segment = """
CREATE TABLE dim_segment (
    segment_id TEXT PRIMARY KEY
)
"""

-- Table Order_mode
create_dim_order_mode = """
CREATE TABLE dim_order_mode (
    order_mode_id TEXT PRIMARY KEY
)
"""

--Table Products
create_dim_product = """
CREATE TABLE dim_product (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    category_cleaned_id TEXT,
    segment_id TEXT,
    FOREIGN KEY (category_cleaned_id) REFERENCES dim_category(category_cleaned_id),
    FOREIGN KEY (segment_id) REFERENCES dim_segment(segment_id)
)
"""

--Table Dates
create_dim_date = """
CREATE TABLE dim_date (
    date_id TEXT PRIMARY KEY,
    order_date DATE,
    year INTEGER,
    month INTEGER,
    quarter TEXT
)
"""

--Table Facts (Sales)
create_fact_sales = """
CREATE TABLE fact_sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id TEXT,
    product_id TEXT,
    location_id TEXT,
    date_id TEXT,
    order_mode_id TEXT,
    quantity INTEGER,
    total_sales REAL,
    total_cost REAL,
    profit REAL,
    total_discount REAL,
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
    FOREIGN KEY (order_mode_id) REFERENCES dim_order_mode(order_mode_id)
)
"""
