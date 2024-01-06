--select database
use [pizza db]

--select entire rows and columns in table
select * from pizza_sales1 

--select specified column in table
select pizza_name_id from pizza_sales1

--Sum of Total pizza price orders
Select sum (Total_price) as Total_revenue from pizza_sales1 

--Average Order price
select sum(total_price)/ count (Distinct order_id) As avg_order_price from pizza_sales1

--Total pizza sold
Select sum (quantity) As total_pizza_sold from pizza_sales1

--Total orders
select count (Distinct order_id) As Total_orders from pizza_sales1

--Average pizzas per orders
select CAST (CAST (Sum(quantity) as decimal (10,2))/ CAST(count(Distinct order_id) as decimal (10,2)) 
as decimal (10,2)) as avg_pizza_perorder from pizza_sales1

--Daily trend for total orders
select datename (DW, order_date) as order_day, count(distinct order_id) as Total_orders from pizza_sales1
group by datename (DW, order_date)

--Monthly trend for total orders
select datename(month,order_date) as order_month,count (distinct order_id) as Total_orders from pizza_sales1
group by datename(month, order_date)

--percentage of sales by pizza category 
Select pizza_category, cast (sum(Total_price)as decimal(10,2)) as total_sales, 
cast(sum (total_price)*100 / (select sum(Total_price) from
pizza_sales1 where month(order_date)=1)  as decimal (10,2)) AS PPC from pizza_sales1
where month(order_date)=1
Group by pizza_category

--percentage of sales by pizza size
Select pizza_size, cast(sum(Total_price) as decimal(10,2)) as Total_sales, 
cast(sum (Total_price)*100/ (select sum(Total_price) from pizza_sales1 
where datepart (quarter,order_date)=1) as decimal (10,2)) as PPS from pizza_sales1
where datepart(quarter,order_date)=1 
group by pizza_size
order by PPS desc

--Top 5 pizza by revenue
select top 5 pizza_name, sum(total_price) as total_revenue from pizza_sales1
group by pizza_name
order by total_revenue desc

--Top 5 pizza by quantity
select top 5 pizza_name, sum(quantity) as total_quantity from pizza_sales1
group by pizza_name
order by total_quantity desc

--Top 5 pizza by orders
select top 5 pizza_name, count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc

--Bottom 5 pizza by revene
select top 5 pizza_name, sum(total_price) as total_revenue from pizza_sales1
group by pizza_name
order by total_revenue asc

--Bottom 5 pizza by quantity
select top 5 pizza_name, sum(quantity) as total_quantity from pizza_sales1
group by pizza_name
order by total_quantity asc

--Bottom 5 pizza by orders
select top 5 pizza_name, count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders asc