create database store_market;
use store_market;
select * from superstoreorders;

# 1. total sales by region 
 select region, sum(sales) as total_sales
   from superstoreorders group by 
    region order by total_sales desc;
    
 # 2. top 5 customer by profit 
    select customer_name, sum(profit) as total_profit  
         from superstoreorders group by customer_name order by total_profit
             limit 5;
             
 # 3. total quantity sold per category
  select category, sum(quantity) as total_quantity 
     from superstoreorders group by category order by total_quantity
               desc;
               
# 4. sales per sub catergory in the furniturr category
select sub_category, sum(sales) as total_sales 
   from superstoreorders where category ='furniture'   
   group by sub_category order by total_sales desc;
   
   # 5. order with the sales higher than the average sales
    select order_id, sales from superstoreorders
          where sales>(select avg(sales) from superstoreorders);

# 6. most profitable sub-category
select sub_category, sum(profit) as total_profit  from superstoreorders
   group by sub_category order by total_profit desc limit 2;
   
   #7. total sales and profit per year
	select year(order_date) as year, sum(sales) as total_sales  from superstoreorders
     group by year order by year;
     
     #8 top 3 region with highest average profit per order 
     select region ,avg(profit) as avg_profit from superstoreorders
         group by region  order by avg_profit desc limit 6;
         
# 9. number of order placed each month in 2024
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(DISTINCT order_id) AS total_orders
FROM superstoreorders
WHERE YEAR(order_date) = 2024
GROUP BY month
ORDER BY month;

#10. categories with total loss 
select category, sum(profit) as total_profit from superstoreorders 
group by category  having total_profit < 0;

#11. total profit by region and category 
select region , category , sum(profit) as total_profit  
from superstoreorders group by region, category order by region ,total_profit desc;

# 12 top selling product category per region 
SELECT region, category, total_sales
FROM (
  SELECT region, category, SUM(sales) AS total_sales,
         RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk
  FROM superstoreorders
  GROUP BY region, category
) ranked
WHERE rnk = 1;

#13.last order date per customer 
select customer_name, max(order_date) as last_order from superstoreorders
group by customer_name order by last_order desc;

#14.show customer with more than 3 order 
SELECT customer_name, COUNT(DISTINCT order_id) AS order_count
FROM superstoreorders
GROUP BY customer_name
HAVING order_count > 3
ORDER BY order_count DESC;