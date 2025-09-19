select * from pizza_sales;

--total revenue
select sum(total_price) as total_revenue from pizza_sales;

--avg order value:-totalrevenue/total number of orders
select sum(total_price)/count(distinct order_id) as avg_order_value from pizza_sales;

--total pizzas sold
select sum(quantity) as total_pizzas_sold from pizza_sales;

--total orders
select count(distinct order_id) as total_orders from pizza_sales;

--avg pizzas per order 

select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as avg_pizz_per_order from pizza_sales;

--daily trend for total orders

select datename(dw,order_date) as order_day , count(distinct order_id) as total_orders from pizza_sales
group by datename(dw,order_date);

--hourly trend

select datepart(hour,order_time) as order_hours , count(distinct order_id) as total_orders from pizza_sales
group by datepart(hour,order_time) order by datepart(hour,order_time)

--percentage of sales

select pizza_category,pizza_size,sum(total_price) as total_sales,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date) = 1 and datepart(quarter,order_date)=1)  as decimal(10,2)) as PCT
from pizza_sales where month(order_date) = 1 and datepart(quarter,order_date)=1 group by pizza_category,pizza_size order by PCT desc

--totalnumber of pizza sold

select pizza_category,sum(quantity) as total_pizzas_sold from pizza_sales group by pizza_category;

--top 5 pizzas_sold

select top 5 pizza_name,sum(quantity) as total_pizzas_sold from pizza_sales
group by pizza_name order by total_pizzas_sold desc

--bottom 5

select top 5 pizza_name,sum(quantity) as total_pizzas_sold from pizza_sales
group by pizza_name order by total_pizzas_sold asc