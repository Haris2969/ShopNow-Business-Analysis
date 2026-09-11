-- ============================================================
-- SHOPNOW BUSINESS ANALYSIS PROJECT
-- SQL ANALYSIS
-- Database: PostgreSQL
-----------------------

-- Tables:
--   customers
--   orders
--   order_items
--   products
-------------

-- Important dataset limitations:
--   - orders has no order_date column
--   - orders has no status column
--   - profitability cannot be calculated because cost data is unavailable
-- ============================================================

-- ============================================================
-- 1. BASIC DATA EXPLORATION
-- ============================================================

-- 1.1 Count customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 1.2 Count orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 1.3 Count order items
SELECT COUNT(*) AS total_order_items
FROM order_items;

-- 1.4 Count products
SELECT COUNT(*) AS total_products
FROM products;

-- 1.5 View customers
SELECT *
FROM customers;

-- 1.6 View orders
SELECT *
FROM orders;

-- 1.7 View order items
SELECT *
FROM order_items;

-- 1.8 View products
SELECT *
FROM products;

-- ============================================================
-- 2. OVERALL SALES KPIs
-- ============================================================

-- 2.1 Total sales
SELECT
SUM(amount) AS total_sales
FROM orders;

-- 2.2 Total orders
SELECT
COUNT(order_id) AS total_orders
FROM orders;

-- 2.3 Average order value
-- AVG ignores NULL values.
SELECT
ROUND(AVG(amount), 2) AS average_order_value
FROM orders;

-- 2.4 Total quantity sold
SELECT
SUM(quantity) AS total_quantity_sold
FROM order_items;

-- 2.5 Combined sales KPIs
SELECT
SUM(amount) AS total_sales,
COUNT(order_id) AS total_orders,
ROUND(AVG(amount), 2) AS average_order_value
FROM orders;

-- ============================================================
-- 3. SALES BY CITY
-- ============================================================

-- 3.1 Sales by city
SELECT
c.city,
SUM(o.amount) AS total_sales
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_sales DESC;

-- 3.2 Orders by city
SELECT
c.city,
COUNT(DISTINCT o.order_id) AS total_orders
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

-- 3.3 Average order value by city
SELECT
c.city,
ROUND(AVG(o.amount), 2) AS average_order_value
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY average_order_value DESC;

-- ============================================================
-- 4. CUSTOMER ANALYSIS
-- ============================================================

-- 4.1 Orders by customer
SELECT
c.customer_name,
COUNT(DISTINCT o.order_id) AS total_orders
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- 4.2 Sales by customer
SELECT
c.customer_name,
SUM(o.amount) AS total_sales
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC;

-- 4.3 Customer sales, orders and AOV
SELECT
c.customer_name,
SUM(o.amount) AS total_sales,
COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(
SUM(o.amount) / COUNT(DISTINCT o.order_id),
2
) AS average_order_value
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC;

-- 4.4 Top customer by sales
SELECT
c.customer_name,
SUM(o.amount) AS total_sales
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC
LIMIT 1;

-- 4.5 Top customer by number of orders
SELECT
c.customer_name,
COUNT(DISTINCT o.order_id) AS total_orders
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

-- ============================================================
-- 5. PRODUCT QUANTITY ANALYSIS
-- ============================================================

-- 5.1 Quantity sold by product
SELECT
p."product-name",
SUM(oi.quantity) AS total_quantity_sold
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name"
ORDER BY total_quantity_sold DESC;

-- 5.2 Best-selling product by quantity
SELECT
p."product-name",
SUM(oi.quantity) AS total_quantity_sold
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name"
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- 5.3 Quantity sold by category
SELECT
p.category,
SUM(oi.quantity) AS total_quantity_sold
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;

-- ============================================================
-- 6. PRODUCT REVENUE ANALYSIS
-- ============================================================

-- 6.1 Product revenue
SELECT
p."product-name",
SUM(oi.quantity * p.price) AS product_sales,
SUM(oi.quantity) AS quantity_sold
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name"
ORDER BY product_sales DESC;

-- 6.2 Top product by revenue
SELECT
p."product-name",
SUM(oi.quantity * p.price) AS product_sales
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name"
ORDER BY product_sales DESC
LIMIT 1;

-- 6.3 Revenue by product category
-- This calculates product-level revenue using quantity × price.
SELECT
p.category,
SUM(oi.quantity * p.price) AS product_sales
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY product_sales DESC;

-- ============================================================
-- 7. PRODUCT PERFORMANCE
-- ============================================================

-- 7.1 Product price and quantity sold
SELECT
p."product-name",
p.price,
SUM(oi.quantity) AS quantity_sold
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p."product-name", p.price
ORDER BY quantity_sold DESC;

-- 7.2 Products with their category and sales
SELECT
p."product-name",
p.category,
SUM(oi.quantity) AS quantity_sold,
SUM(oi.quantity * p.price) AS product_sales
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name", p.category
ORDER BY product_sales DESC;

-- ============================================================
-- 8. CATEGORY ANALYSIS
-- ============================================================

-- 8.1 Number of products by category
SELECT
category,
COUNT(*) AS product_count
FROM products
GROUP BY category
ORDER BY product_count DESC;

-- 8.2 Quantity sold by category
SELECT
p.category,
SUM(oi.quantity) AS quantity_sold
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY quantity_sold DESC;

-- 8.3 Product revenue by category
SELECT
p.category,
SUM(oi.quantity * p.price) AS product_sales
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY product_sales DESC;

-- ============================================================
-- 9. ORDER-LEVEL ANALYSIS
-- ============================================================

-- 9.1 Orders with customer names
SELECT
o.order_id,
c.customer_name,
c.city,
o.amount
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 9.2 Order details with products
SELECT
o.order_id,
c.customer_name,
p."product-name",
p.category,
oi.quantity,
p.price,
oi.quantity * p.price AS product_value
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
JOIN order_items AS oi
ON o.order_id = oi.order_id
JOIN products AS p
ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- 9.3 Number of items per order
SELECT
o.order_id,
SUM(oi.quantity) AS total_items
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY total_items DESC;

-- ============================================================
-- 10. DATA QUALITY / VALIDATION
-- ============================================================

-- 10.1 Check NULL order amounts
SELECT
COUNT(*) AS null_amount_count
FROM orders
WHERE amount IS NULL;

-- 10.2 Check NULL customer IDs
SELECT
COUNT(*) AS null_customer_id_count
FROM orders
WHERE customer_id IS NULL;

-- 10.3 Check duplicate order IDs
SELECT
order_id,
COUNT(*) AS occurrence_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 10.4 Check duplicate customer IDs
SELECT
customer_id,
COUNT(*) AS occurrence_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 10.5 Check duplicate product IDs
SELECT
product_id,
COUNT(*) AS occurrence_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- ============================================================
-- 11. BUSINESS INSIGHT QUERIES
-- ============================================================

-- 11.1 Highest-performing city
SELECT
c.city,
SUM(o.amount) AS total_sales
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_sales DESC
LIMIT 1;

-- 11.2 Highest-value customer
SELECT
c.customer_name,
SUM(o.amount) AS total_sales
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC
LIMIT 1;

-- 11.3 Highest-revenue product
SELECT
p."product-name",
SUM(oi.quantity * p.price) AS product_sales
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name"
ORDER BY product_sales DESC
LIMIT 1;

-- 11.4 Highest-quantity product
SELECT
p."product-name",
SUM(oi.quantity) AS quantity_sold
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p."product-name"
ORDER BY quantity_sold DESC
LIMIT 1;

-- ============================================================
-- 12. IMPORTANT ANALYTICAL NOTES
-- ============================================================

## -- Total order revenue is taken directly from orders.amount.

-- Product revenue is calculated as:
-- quantity × product price.
----------------------------

-- orders.amount should NOT be directly joined to order_items
-- and summed by category/product because an order can contain
-- multiple order items, which can duplicate the order amount.
--------------------------------------------------------------

-- The dataset does not contain:
--   1. order_date
--   2. order status
--   3. product cost
--------------------

-- Therefore:
--   - Time-series analysis cannot currently be performed.
--   - Cancellation/status analysis cannot currently be performed.
--   - Actual profit/margin cannot currently be calculated.
-----------------------------------------------------------

-- Profit would require:
-- (selling price - cost price) × quantity.
-- ============================================================
"""

from pathlib import Path
path = Path("/mnt/data/ShopNow_SQL_Analysis.sql")
path.write_text(sql, encoding="utf-8")
print(path)
print(f"{len(sql.splitlines())} lines")
print(f"{len([x for x in sql.split('--') if x.strip()])} sections/comments")
print("File created successfully.")
