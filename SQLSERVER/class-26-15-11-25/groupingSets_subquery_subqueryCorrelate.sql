select 
	Brand,
	Category,
	sum(sales) as sale
from	
	[Bikestore].[sales].[sales_summary]
group by
	grouping sets(
		(brand, category),
		(brand),
		()
	)
order by
	brand,
	category;

----------------- CUBE function in Grouping Sets -----------------------
select
	brand,
	category,
	sum(sales) sale
from
	[Bikestore].[sales].[sales_summary]
group by
	cube(brand, category);

----------------- ROLL UP function in Grouping Sets -----------------------

select
	brand,
	category,
	sum(sales) sale
from
	[Bikestore].[sales].[sales_summary]
group by
	rollup(brand, category);


---- Partial Roll up -----

select
	brand,
	category,
	sum(sales) sale
from
	[Bikestore].[sales].[sales_summary]
group by
	brand,
	rollup(category);

--- group by 
select
	state,
	count(state) as customer_per_state
from
	[Bikestore].[sales].[customers]
group by
	state;

-- grouping sets
select
	brand,
	category,
	sum(sales)
from
	[Bikestore].[sales].[sales_summary]
group by
	brand, category;


select
	brand,
	category,
	sum(sales) AS sales
from
	[Bikestore].[sales].[sales_summary]
group by
	grouping sets(
		(brand),
		(category),
		(brand, category),
		()
	);

select
	brand,
	category,
	sum(sales) AS sales
from
	[Bikestore].[sales].[sales_summary]
group by
	cube(brand, category);

-- ()
-- (brand)
-- (brand, category)
select
	brand,
	category,
	sum(sales) AS sales
from
	[Bikestore].[sales].[sales_summary]
group by
	rollup(brand, category)
order by
	brand;


-- sub-query

select customer_id from [sales].[customers] where state = 'NY';

select * from [sales].[customers];

--- select all orders where customer is from NY

select * 
from 
	[sales].[customers]
where customer_id in (
		select customer_id 
		from [sales].[customers] 
		where state = 'NY'
	);


select * from [sales].[orders];
select * from [sales].[customers];


select * 
from sales.orders o
join sales.customers c
on o.customer_id = c.customer_id
where o.customer_id in (
	select c.customer_id 
	from sales.customers where o.order_status > 2
);

select * from production.products;

SELECT
    p1.product_name,
    p1.list_price,
    p1.category_id
FROM
    production.products p1
WHERE
    p1.list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;









