create database Reliance_Mart;
select * from customers;
select * from products;
select * from regions;
select * from returns_1997_1998;
select * from stores;
select * from transactions_1997;
select * from transactions_1998;

-- ### 🧠 Advanced SQL Questions

-- 1. **Monthly Sales Rank by Store and Product Category**  
--    *Get the monthly sales ranking of each product category per store for the year 1998 using a window function.*

with store_quantity as (
select t.store_id, sum(t.quantity) as quantity
from products p
inner join 
(
select * from transactions_1997
union all
select * from transactions_1998
) t
on p.product_id = t.product_id
group by 1)
select *,row_number() over (
order by quantity desc) as sales_rank
from store_quantity ;

-- 2. **Identify Top 3 Customers by Total Spend in Each Region**  
--    *Use a CTE and `ROW_NUMBER()` to find the top 3 spending customers per region.*



-- 3. **Find Products with Increasing Monthly Sales Trend in 1998**  
--    *Identify products whose monthly sales showed a strictly increasing pattern using `LAG()` and `SUM()`.*

with product_trans_1998 as (
select p.product_id,p.product_cost,p.product_name,t.transaction_date,t.quantity
from products p
inner join transactions_1998 t
on p.product_id = t.product_id),
product_sales as (
select product_id, product_name, month(transaction_date) as months, sum(quantity) as monthly_quantity 
from product_trans_1998
group by 1,2,3),
sales_performance as (select *,
(monthly_quantity - lag(monthly_quantity,1,0) over (partition by product_id order by months)) as monthly_sale_performance
from product_sales)
select product_id, product_name, sum(monthly_sale_performance) as overall_performance
from sales_performance
group by 1,2
order by overall_performance desc;


-- 4. **Detect Anomalies in Returns: Stores with Unusually High Return Rate**  
--    *Use a subquery to calculate average return rate per store and flag those above 2x the global average.*

with returned as (select r.store_id, sum(r.quantity) as returned
from returns_1997_1998 r
inner join stores s
on r.store_id = s.store_id
group by 1),
avg_return as (
select round(avg(returned),2) as avg_return
from returned)
select * 
from returned
cross join avg_return
where returned > 1.5*avg_return;

-- 5. **List Customers Who Made Purchases Across All Product Categories**  
--    *Use a `HAVING` clause and `COUNT(DISTINCT category)` approach to find such customers.*
 
 with transactions as (
select * from transactions_1997
union all
select * from transactions_1998)
select t.customer_id, count(distinct p.product_brand) as no_of_brand
from transactions t
inner join products p
on t.product_id = p.product_id
group by 1
having no_of_brand > (select count(distinct product_brand) from products);
 
-- 6. **Year-over-Year Sales Growth by Region and Product Category**  
--    *Join 1997 and 1998 data to compute percentage growth for region-category pairs.*

with trans as (
select * from transactions_1997
union all
select * from transactions_1998 ),
yoy as (select product_id, year(transaction_date) as years, sum(quantity) as quantity
from trans
group by 1,2),
yoy_cte as (
select product_id, years, quantity,
lag(quantity,1,0) over (partition by product_id order by years) as yoy_growth
from yoy)
select product_id, (quantity - yoy_growth)*100/yoy_growth as perc_growth
from yoy_cte
where years = 1998;


-- 7. **Monthly Average Basket Size by Store (Number of Products per Transaction)**  
--    *Use `AVG()` and window functions partitioned by store and month.*

with transactions as (
select * from transactions_1997
union all
select * from transactions_1998),
cte_trans_store as (select month(t.transaction_date) as months, s.store_id, count( distinct t.product_id) as products
from transactions t
inner join stores s
on t.store_id = s.store_id
group by 1,2),
product_store as (select store_id, avg(products) as avg_basket
from cte_trans_store
group by 1)
select *
from product_store

-- 8. **Find the First and Last Transaction Date per Customer**  
--    *Use `MIN()` and `MAX()` with `GROUP BY` or window function.*

-- 9. **Repeat Customers: Bought Same Product in Both 1997 and 1998**  
--    *Use an `INTERSECT` or join to compare customer-product pairs in both years.*

-- 10. **Customer Churn Analysis: Customers Who Stopped Buying in 1998**  
--    *Identify customers who made purchases in 1997 but not in 1998 using `NOT EXISTS`.*

-- 11. **Stores with Sales on All Days in December 1998**  
--    *Join with the calendar table, filter for December, and count distinct sales days per store.*

-- 12. **Calculate Cumulative Sales Per Customer Over Time**  
--    *Use `SUM(sales)` over `PARTITION BY customer_id ORDER BY transaction_date`.*

-- 13. **Return Rate Trend Per Product Category Over Time**  
--    *Join returns with transactions, then compute return rate monthly using `GROUP BY` and `CASE`.*

-- 14. **Top Product per Store by Total Revenue (1998 Only)**  
--    *Use `RANK()` to find the highest-selling product per store.*

-- 15. **Customers Whose Average Transaction Value Increased in 1998 vs 1997**  
--    *Compute average transaction value per customer per year using subqueries or CTEs, then filter.*





