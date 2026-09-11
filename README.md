# ShopNow — Sales & Customer Analytics Dashboard

## 📊 Project Overview

**ShopNow Sales & Customer Analytics** is an end-to-end Business Analysis and Data Analytics project focused on understanding sales performance, product contribution, customer behavior, and geographic performance.

The project demonstrates how raw relational data can be transformed into actionable business insights using **PostgreSQL, SQL, Power BI, and DAX**.

The final solution includes an interactive **three-page Power BI management dashboard** and a documented Business Analysis case study.

---

## 🎯 Business Problem

ShopNow management needed a centralized view of business performance to understand:

* Which categories generate the most sales?
* Which products contribute the most revenue?
* Which customers generate the highest sales?
* Which cities perform best?
* What is the average order value?
* Which products have the highest unit demand?
* What business actions should management prioritize?

The goal was to transform the available transactional data into a management-friendly analytical solution.

---

## 🎯 Project Objectives

The main objectives were to:

1. Analyze overall sales performance.
2. Identify high-performing product categories.
3. Analyze product revenue and quantity sold.
4. Identify high-value customers.
5. Analyze customer order behavior.
6. Compare sales performance across cities.
7. Build an interactive Power BI dashboard.
8. Convert analytical findings into actionable recommendations.

---

## 🛠️ Tools & Technologies

| Tool               | Purpose                                  |
| ------------------ | ---------------------------------------- |
| **PostgreSQL**     | Database management and data exploration |
| **SQL**            | Data analysis and business queries       |
| **Power BI**       | Interactive dashboard and visualization  |
| **DAX**            | Calculated measures and analytical logic |
| **Microsoft Word** | Business Analysis documentation          |

---

## 🗂️ Data Model

The project uses four relational tables:

### Customers

Contains customer information:

* `customer_id`
* `customer_name`
* `city`
* `age`

### Orders

Contains order-level information:

* `order_id`
* `customer_id`
* `amount`

### Order Items

Contains product-level order information:

* `order_item_id`
* `order_id`
* `product_id`
* `quantity`

### Products

Contains product information:

* `product_id`
* `product-name`
* `category`
* `price`

### Relationships

```text
Customers
    │
    │ customer_id
    ▼
Orders
    │
    │ order_id
    ▼
Order Items
    │
    │ product_id
    ▼
Products
```

The relationships were implemented in Power BI to enable cross-table analysis.

---

# 📈 Dashboard

The Power BI solution contains three analytical pages.

## 1. Executive Sales Overview

The first page provides a high-level management view of ShopNow's performance.

### Key Performance Indicators

* **Total Sales:** 66.6K
* **Total Orders:** 10
* **Average Order Value:** 7.4K
* **Total Quantity Sold:** 13

### Analysis Included

* Sales by Product Category
* Sales by City
* Product performance
* Customer performance
* Orders by customer
* Quantity sold
* Interactive City filter
* Interactive Product filter

### Business Question

> **What is happening in the business?**

---
## 🖼️ Dashboard Preview

### Executive Sales Overview

![Executive Sales Overview](Screenshots/Executive-Sales-Overview.png)

### Product & Customer Analysis

![Product & Customer Analysis](Screenshots/Product-Customer-Analysis.png)

### Business Insights & Recommendations

![Business Insights & Recommendations](Screenshots/Business-Insights-Recommendations.png)

## 2. Product & Customer Analysis

The second page provides a deeper analysis of products and customers.

### Visualizations

* Sales by Product
* Quantity Sold by Product
* Sales by Customer
* Orders by Customer
* Average Order Value by Customer

This page helps management understand which products generate revenue and which customers contribute most significantly to the business.

### Key Findings

**Office Chair** generated approximately **28K** in product revenue.

**Usman** was the highest-value customer with approximately **32.5K** in sales across 2 orders.

### Business Question

> **Which products and customers are driving business performance?**

---

## 3. Business Insights & Recommendations

The third page converts analytical results into actionable business recommendations.

### Key Insights

| Area                             | Finding            |
| -------------------------------- | ------------------ |
| Top Category                     | Furniture — 33.5K  |
| Top City                         | Peshawar — 35.7K   |
| Top Customer                     | Usman — 32.5K      |
| Top Product by Revenue           | Office Chair — 28K |
| Best-Selling Product by Quantity | Notebook — 3 units |

### Recommendations

**1. Focus on Furniture**

Maintain strong inventory availability and targeted promotions for the strongest-performing category.

**2. Promote Office Chairs**

Use targeted campaigns, bundles, and cross-selling opportunities around the highest-revenue product.

**3. Strengthen the Peshawar Market**

Investigate the factors contributing to strong performance and increase customer-retention and marketing efforts.

**4. Retain High-Value Customers**

Use loyalty programs and personalized offers to retain customers such as Usman.

**5. Increase Customer Spending**

Use cross-selling, bundles, and personalized recommendations to increase spending among lower-value customers.

### Business Question

> **What should the business do based on the analysis?**

---

# 🔍 SQL Analysis

SQL was used to investigate the underlying business questions before building the Power BI dashboard.

The analysis included:

* Sales by city
* Product quantity sold
* Orders by customer
* Customer sales
* Customer average order value
* Product revenue
* Product quantity performance

Example:

```sql
SELECT
    c.city,
    SUM(o.amount) AS total_sales
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_sales DESC;
```

This query identifies the cities generating the highest sales.

---

# 🧮 DAX Analysis

DAX was used to create analytical measures within Power BI.

Example product-sales measure:

```DAX
Product Sales =
SUMX(
    'public order_items',
    'public order_items'[quantity] *
    RELATED('public products'[price])
)
```

This measure calculates product-level revenue using quantity sold and product price.

---

# 🔄 Business Analysis Workflow

```text
Business Problem
       ↓
Business Requirements
       ↓
Data Exploration
       ↓
PostgreSQL Database
       ↓
SQL Analysis
       ↓
Power BI Data Modeling
       ↓
DAX Measures
       ↓
Interactive Dashboard
       ↓
Business Insights
       ↓
Business Recommendations
```

---

# 💡 Key Business Findings

The analysis produced several important findings:

### Sales Performance

ShopNow generated **66.6K** in total sales across **10 orders**.

### Category Performance

**Furniture** was the strongest-performing category with approximately **33.5K** in sales.

### Geographic Performance

**Peshawar** was the highest-performing city with approximately **35.7K** in sales.

### Customer Performance

**Usman** was the highest-value customer with approximately **32.5K** in sales.

### Product Revenue

**Office Chair** was the highest-revenue product with approximately **28K** in product revenue.

### Product Demand

**Notebook** had the highest quantity sold, with **3 units**.

---

# ⚠️ Data Limitations

The current dataset has several limitations.

### No Order Date

There is no order-date field, so the project cannot currently perform:

* Monthly trend analysis
* Year-over-year analysis
* Seasonal analysis
* Time-based forecasting

### No Cost Data

Product cost information is not available.

Therefore, actual profit and profit margin cannot be calculated.

Profitability would require:

```text
Profit = (Selling Price − Cost Price) × Quantity
```

### Limited Dataset Size

The dataset is relatively small and is primarily intended to demonstrate the analytical workflow and methodology.

---

# 📁 Project Structure

A recommended repository structure is:

```text
ShopNow-Business-Analysis/
│
├── README.md
│
├── PowerBI/
│   └── ShopNow_Sales_Management_Dashboard.pbix
│
├── SQL/
│   └── ShopNow_SQL_Analysis.sql
│
├── Documentation/
│   └── ShopNow_BA_Case_Study.pdf
│
└── Screenshots/
    ├── Executive-Sales-Overview.png
    ├── Product-Customer-Analysis.png
    └── Business-Insights-Recommendations.png
```

---

# 🎓 Skills Demonstrated

This project demonstrates practical skills in:

* Business Analysis
* Requirements Analysis
* SQL
* PostgreSQL
* Data Modeling
* Power BI
* DAX
* Data Visualization
* KPI Development
* Customer Analysis
* Product Analysis
* Geographic Analysis
* Business Intelligence
* Data Storytelling
* Business Recommendations

---

# 🚀 Project Outcome

The ShopNow project demonstrates an end-to-end analytical workflow from **business problem identification to actionable recommendations**.

The final solution enables management to move from:

**Raw Data → Analysis → Visualization → Insight → Decision**

The project demonstrates how a Business Analyst can combine technical data skills with business thinking to support data-driven decision-making.

---

## 👤 Author

**Haris Ali Paracha**

**Focus:** Business Analysis | Data Analytics | SQL | Power BI | DAX

---

## 📌 Project Type

**Portfolio Project — Business Analysis & Data Analytics**

**Status:** Completed ✅
