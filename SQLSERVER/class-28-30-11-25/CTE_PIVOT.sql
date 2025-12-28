--- CTE ----

select 
	sf.first_name + '' + sf.last_name as staff_name,
	SUM(ot.quantity * ot.list_price) as sales
from 
	[sales].[staffs] sf
	inner join [sales].[orders] o on o.staff_id = sf.staff_id
	inner join [sales].[order_items] ot on ot.order_id = o.order_id
group by 
	sf.first_name + '' + sf.last_name;


with sales_cte as (
	select 
	sf.first_name + '' + sf.last_name as staff_name,
	Year(o.order_date) as order_year,
	SUM(ot.quantity * ot.list_price) as sales
from 
	[sales].[staffs] sf
	inner join [sales].[orders] o on o.staff_id = sf.staff_id
	inner join [sales].[order_items] ot on ot.order_id = o.order_id
group by 
	sf.first_name + '' + sf.last_name,
	Year(o.order_date)
)
select * from sales_cte
where order_year = 2016;



with cte_sales as(
select 
	staff_id,
	COUNT(*) order_count
from [sales].[orders]
where
	year(order_date) = 2018
group by staff_id
)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;
	

with cte_category_counts as(
select 
	c.category_id,
	c.category_name,
	COUNT(p.product_id)
from 
	[production].[categories] c
	inner join [production].[products] p
		on p.category_id = c.category_id
	group by
		c.category_id,
		c.category_name
),
cte_category_sales () as (
select 
	p.category_id,
	SUM(i.quantity * i.list_price * (1 - i.discount))
from 
	[sales].[order_items] i
	inner join [production].[products] p
	on p.product_id = i.product_id
	inner join [sales].[orders] o
	on o.order_id = i.order_id
where order_status = 4 --- completed
group by
	p.category_id
)
SELECT 
    c.category_id, 
    c.category_name, 
    c.product_count, 
    s.sales
FROM
    cte_category_counts c
    INNER JOIN cte_category_sales s 
        ON s.category_id = c.category_id
ORDER BY 
    c.category_name;


--- Pivot
--- Convert rows to columns

select * from(
select 
	c.category_name, -- PIVOT COLUMN
	p.product_id, -- AGG COLUMN
	p.model_year -- GROUPING COLUMN
from 
	[production].[categories] c
	inner join [production].[products] p
		on p.category_id = c.category_id
) t
PIVOT (
	COUNT(product_id)
	FOR category_name IN(
	[Children Bicycles],
	[Comfort Bicycles]
	)
)
AS pivot_table;

--- Syntax
--- select from table
--- PIVOT
--- Aggregate function
--- For (LIST) In (columns) as pivot



--- insert
--- 