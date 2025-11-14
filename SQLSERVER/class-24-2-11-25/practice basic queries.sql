select * from [Bikestore].[sales].[customers];

select first_name from [Bikestore].[sales].[customers];

select first_name,last_name from [Bikestore].[sales].[customers];

select * from [Bikestore].[sales].[customers] where state = 'NY';

select * from [Bikestore].[sales].[customers] where state <> 'NY';

select * from [Bikestore].[sales].[customers] where state = 'NY' and customer_id > 100; 

select * from [Bikestore].[sales].[customers] where phone is not null;

select * from [Bikestore].[sales].[customers] where phone <> 'NULL';

select *
from
	[Bikestore].[sales].[customers]
where
	customer_id between 100 and 150;

select *
from
	[Bikestore].[sales].[customers]
where
	last_name = 'Bates' or first_name = 'Marget';

select *
from 
	[Bikestore].[sales].[customers]
where
	first_name like '&Aa';

select *
from 
	[Bikestore].[sales].[customers]
where
	first_name like '%a';

select *
from 
	[Bikestore].[sales].[customers]
where
	first_name like 'Aa_on';

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE 'k__ha';

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE '[A-C]%'; -- starts name with a given range

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE '[^A-C]%'; -- Don't starts name with a given range

select *
from
	[Bikestore].[sales].[customers]
order by
	first_name, state;

select *
from
	[Bikestore].[sales].[customers]
order by
	 state, first_name;

select * 
from 
	[Bikestore].[sales].[customers]
order by
	state desc, first_name asc;

select * 
from 
	[Bikestore].[sales].[customers]
order by
	state desc, first_name desc;

select
	top(15)*
from
	[Bikestore].[sales].[customers];

select *
from
	[Bikestore].[sales].[customers]
order by
	customer_id offset 10 rows;

select *
from
	[Bikestore].[sales].[customers]
order by
	customer_id offset 10 rows
	fetch next 10 rows only;

select *
from
	[Bikestore].[sales].[customers]
order by
	customer_id offset 1435 rows
	fetch next 10 rows only;

select product_name, list_price
from
	[Bikestore].[production].[products]
order by 
	list_price desc
	offset 0 rows
	fetch next 10 rows only;

SELECT *
FROM 
	[Bikestore].[sales].[customers] 
ORDER BY 
	first_name
	OFFSET 50 ROWS
	FETCH NEXT 10 ROWS ONLY;

SELECT *
FROM 
	[Bikestore].[sales].[customers] 
ORDER BY 
	customer_id
OFFSET 50 ROWS
FETCH NEXT 10 ROWS ONLY;

select
	concat(first_name, ' ' , last_name) as full_name
from 
	[Bikestore].[sales].[customers];
