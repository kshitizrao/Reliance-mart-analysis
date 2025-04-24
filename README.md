# Reliance Mart Analysis 🛒📊

## Project Overview

This project analyzes the sales and returns performance of Reliance Mart by comparing it with the previous year. A comprehensive Power BI dashboard was built to visualize insights derived from SQL queries executed on transactional data.

---

## 📌 Purpose
To compare the overall performance of Reliance Mart with the previous year, focusing on:
- Revenue growth
- Profit trends
- Product and regional performance
- Return rates and anomalies

---

## 🧰 Tech Stack

- **SQL** (Window Functions, Aggregations, Joins)
- **MySQL** (Data preprocessing and querying)
- **Power BI** (Visualization and dashboard creation)

---

## 📁 Dataset

8 CSV files were used in this project:
- `calendar.csv`
- `customer.csv`
- `product.csv`
- `regions.csv`
- `returns-1997-1998.csv`
- `stores.csv`
- `transaction-1997.csv`
- `transaction-1998.csv`

---

## 🔍 Key SQL Analyses

### **Monthly Sales Rank by Store and Product Category**
> Get the monthly sales ranking of each product category per store for the year 1998 using a window function.

### **Find Products with Increasing Monthly Sales Trend in 1998**
> Identify products whose monthly sales showed a strictly increasing pattern using `LAG()` and `SUM()`.

### **Detect Anomalies in Returns: Stores with Unusually High Return Rate**
> Use a subquery to calculate average return rate per store and flag those above 2x the global average.

### **List Customers Who Made Purchases Across All Product Categories**
> Use a `HAVING` clause and `COUNT(DISTINCT category)` approach to find such customers.

### **Year-over-Year Sales Growth by Region and Product Category**
> Join 1997 and 1998 data to compute percentage growth for region-category pairs.

### **Monthly Average Basket Size by Store**
> Use `AVG()` and window functions partitioned by store and month to find number of products per transaction.

### **Find the First and Last Transaction Date per Customer**
> Use MIN() and MAX() with GROUP BY or window function.

### **Repeat Customers: Bought Same Product in Both 1997 and 1998**
> Use an INTERSECT or join to compare customer-product pairs in both years.

### **Customer Churn Analysis: Customers Who Stopped Buying in 1998**
> Identify customers who made purchases in 1997 but not in 1998 using NOT EXISTS.

### **Top Product per Store by Total Revenue (1998 Only)**
> Use RANK() to find the highest-selling product per store.

---

## 📊 Power BI Dashboard

![Dashboard Screenshot](/PowerBi/Dashboard.png)

---

## ✅ Conclusion

- Revenue, profit, and returns improved compared to the previous month.
- Tri-State and Tell Tale were the highest revenue-generating product brands.
- The WA region had the highest number of transactions.
- Several products showed consistent month-on-month growth in 1998.
- Anomalous return rates were identified for better operational control.

---

Feel free to explore, fork, and contribute! 😊
