select * from blinkit_data;

select count(*) from blinkit_data;

update blinkit_data
set Item_Fat_Content =
case
when Item_Fat_Content in ('LF','low fat') then ('Low Fat')
when Item_Fat_Content = 'Reg' then 'Regular'
else Item_Fat_Content
end

select distinct(Item_Fat_Content) from blinkit_data;

---totalsales

select cast(sum(sales)/1000000 as decimal(10,2)) as total_salesmillion from blinkit_data;

--avg sales

select cast(avg(sales) as int)as Avg_sales from blinkit_data;

--no of items

select count(*) as No_of_orders from blinkit_data;

--avg rating

select cast(avg(rating) as decimal(10,1)) as avg_rating from blinkit_data;

--totalsales by fat content

select item_fat_content, cast(sum(sales) as decimal(10,2))as total_sales from blinkit_data
group by Item_Fat_Content

--total sales by itemtype

select item_type, sum(sales) as total_sales from blinkit_data
group by Item_Type order by total_sales desc

--fat content by outlet for totalsales

select outlet_location_type, isnull([Low Fat],0) as Low_Fat, isnull([Regular],0) as Regular from
(select outlet_location_type,item_fat_content, sum(sales) as total_sales from blinkit_data
group by outlet_location_type,item_fat_content) as sourcetable

pivot
(
sum(total_sales) for item_fat_content in ([Low Fat],[Regular])) as pivot_table order by outlet_location_type

---total sales by outlet establishment

select outlet_establishment_year, sum(sales) as total_sales from blinkit_data
group by outlet_establishment_year order by outlet_establishment_year

--percentage of sales by outletsize

select Outlet_Size, sum(sales) as total_sales, cast(
(sum(sales) * 100/sum(sum(sales)) over()) as decimal(10,2)) as sales_percentage from blinkit_data
group by Outlet_Size;

--sales by outletlocationtype

select outlet_location_type, sum(sales) as total_sales from blinkit_data
group by outlet_location_type order by total_sales desc

--all metrics by outlettype

SELECT Outlet_Type,Outlet_size, 
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type,Outlet_size
ORDER BY Total_Sales DESC
