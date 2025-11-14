--- left join

select
	l.CountryID,
	l.dated,
	l.Units,
	r.Country
from
	Lefttable l
left join
	Righttable r
on l.CountryID = r.Id;

--- right join

select 
	r.Id,
	r.Country,
	l.dated,
	l.Units
from 
	Lefttable l
right join
	Righttable r
on l.CountryID = r.Id;

--- inner join

select 
	r.Id,
	r.Country,
	l.dated,
	l.Units
from
	Lefttable l
inner join
	Righttable r
on l.CountryID = r.Id;

--- left anti join

select
	l.CountryID,
	l.dated,
	l.Units
from
	Lefttable l
left join
	Righttable r
on 
	l.CountryID = r.Id
where
	r.Id is null;


--- right anti join

select
	r.Id,
	r.Country
from
	Lefttable l
right join
	Righttable r
on 
	l.CountryID = r.Id
where
	l.CountryID is null;

--- FULL OUTER JOIN

select *
from 
	Lefttable l
full outer join 
	Righttable r
on l.CountryID = r.Id;


-- SEMI Join On left table
SELECT * FROM Lefttable;
SELECT * FROM Righttable;


SELECT 
	l.CountryID,
	l.dated,
	l.Units
FROM Lefttable As l
INNER JOIN Righttable As r
On l.CountryID = r.Id;
--OR
SELECT 
	l.CountryID,
	l.dated,
	l.Units
FROM Lefttable As l
Left JOIN Righttable As r
On l.CountryID = r.Id
WHERE l.CountryID = r.Id;


-- SEMI Join On right table
SELECT * FROM Lefttable;
SELECT * FROM Righttable;


SELECT 
	r.Id,
	r.Country
FROM Lefttable As l
INNER JOIN Righttable As r
On l.CountryID = r.Id;
--OR
SELECT 
	r.Id,
	r.Country
FROM Lefttable As l
Right JOIN Righttable As r
On l.CountryID = r.Id
WHERE l.CountryID = r.Id;

--- self join
select * from [Bikestore].[sales].[staffs];

select
	e.first_name + ' ' + e.last_name as employee_name,
	m.first_name + ' ' + m.last_name as manager_name
from 
	[Bikestore].[sales].[staffs] e
inner join
	[Bikestore].[sales].[staffs] m
on e.staff_id = m.manager_id;

select
	e.first_name + ' ' + e.last_name as employee_name,
	m.first_name + ' ' + m.last_name as manager_name
from 
	[Bikestore].[sales].[staffs] e
right join
	[Bikestore].[sales].[staffs] m
on e.staff_id = m.manager_id;

select
	e.first_name + ' ' + e.last_name as employee_name,
	m.first_name + ' ' + m.last_name as manager_name
from 
	[Bikestore].[sales].[staffs] e
left join
	[Bikestore].[sales].[staffs] m
on e.staff_id = m.manager_id;

--- Group By

select 
	state,
	count(*) as state_count
from 
	[Bikestore].[sales].[customers]
group by
	state;

select 
	state,
	count(*) as state_count
from 
	[Bikestore].[sales].[customers]
group by
	state
having 
	count(*) > 1000;

--GROUPING SETS TOPIC

select 
	b.brand_name AS brand,
	c.category_name AS category,
	p.model_year,
	ROUND(
		SUM (
			quantity * oi.list_price * (1 - discount)
		),
		0
	) AS sales INTO [Bikestore].[sales].[sales_summary]
from
	Bikestore.sales.order_items oi
inner join
	Bikestore.production.products p on p.product_id = oi.product_id
inner join 
	Bikestore.production.brands b on p.brand_id = b.brand_id
inner join
	Bikestore.production.categories c on p.category_id = c.category_id
Group By
	b.brand_name,
	c.category_name,
	p.model_year
Order by
	b.brand_name,
	c.category_name,
	p.model_year;


select 
	Brand,
	sum(sales) as Brand_Sales
from 
	[Bikestore].[sales].[sales_summary]
Group By
	Brand;
	
select
	Brand,
	Category
from	
	[Bikestore].[sales].[sales_summary]
Group By
	brand,
	category;


select 
	sum(sales) as brand_sale
from	
	[Bikestore].[sales].[sales_summary];

--- applying grouping sets

select 
	brand,
	category,
	sum(sales) as sale
from 
	[Bikestore].[sales].[sales_summary]
group by
	grouping sets(
		(brand, category),
		(brand),
		(category),
		()
	)
order by
	brand,
	category

	------------------------------------ORDER OF EXECUTION OF COMMANDS IN SQL-----------------------------------
-- FROM/JOIN >> WHERE >> GROUP BY >> HAVING >> SELECT >> DISTINCT >> ORDER BY >> LIMITS/OFFSET
