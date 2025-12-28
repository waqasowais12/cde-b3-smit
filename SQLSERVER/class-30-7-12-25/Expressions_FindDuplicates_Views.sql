--- CASE


select distinct order_status from [sales].[orders];

---> Prnding
---> Processing
---> Rejected
---> Completed


select
 case order_status
 when 1 then 'Pending'
 when 2 then 'Processing'
 when 3 then 'Rejected'
 when 4 then 'Completed'
 end as modified_or_status
from  [sales].[orders];


select
 case order_status
 when 1 then 'Pending'
 when 2 then 'Processing'
 when 3 then 'Rejected'
 when 4 then 'Completed'
 end as modified_or_status,
 count(*) as or_status_count
from  [sales].[orders]
group by
 case order_status
 when 1 then 'Pending'
 when 2 then 'Processing'
 when 3 then 'Rejected'
 when 4 then 'Completed'
 end;


 select 
	o.order_id,
	sum(quantity*list_price) order_value,
	case 
		when sum(quantity * list_price) <= 500
		then 'very low'

		when sum(quantity * list_price) > 500
		and sum(quantity  * list_price) <= 100
		then 'low'

		when sum(quantity * list_price) > 1000
		and sum(quantity  * list_price) <= 5000
		then 'Medium'
 
		when sum(quantity * list_price) > 5000
		and sum(quantity  * list_price) <= 10000
		then 'High'

		when sum(quantity * list_price) > 10000
		then 'very high'
	end order_priority
 from [sales].[order_items] o
 group by
	o.order_id;
	

--- COALESCE
							
select COALESCE('Hi', Null);
select COALESCE(Null, 'Hello');

select 
	first_name,
	last_name,
	COALESCE(phone, 'N/A') as phone
from [sales].[customers];


---- NULLIF
	--- lhs != rhs (lhs)
	--- lhs == rhs (NULL)

select NULLIF(10,20);

select NULLIF(10,10);

select NULLIF('Hi','Hello');

select NULLIF('Hello','Hello');


--- HANDLING DUPLICATES

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
    id INT IDENTITY(1, 1), 
    a  INT, 
    b  INT, 
    PRIMARY KEY(id)
);



INSERT INTO
    t1(a,b)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (2,1),
    (1,2),
    (1,3),
    (2,1),
    (2,2);



select * from t1;

select 
	a,
	b,
	count(*) records_count
from t1
group by a , b
having count(*) < 2;

select 
	a,
	b,
	count(*) records_count
from t1
group by a , b
having count(*) > 1;

with duplicate_records as (
	select 
	a,
	b,
	count(*) records_count
	from t1
	group by a , b
	having count(*) > 1
);
--- ROW NUMBER


with cte_duplicates as(
select 
	id,
	a,
	b,
	ROW_NUMBER() OVER (
		PARTITION BY a,b
		ORDER BY a,b
	) AS rn
from t1
)
select id,a,b
from cte_duplicates
where rn = 1;



select *
from 
	[production].[products] p
inner join [production].[categories] c
	on p.category_id = c.category_id 
inner join [production].[brands] b
	on p.brand_id = b.brand_id
inner join [production].[stocks] s
	on s.product_id = p.product_id;

create view product_catalog as
select 
	p.product_id,
	p.product_name,
	c.category_id,
	c.category_name,
	b.brand_id,
	b.brand_name,
	p.list_price,
	p.model_year,
	s.store_id,
	s.quantity
from 
	[production].[products] p
inner join [production].[categories] c
	on p.category_id = c.category_id 
inner join [production].[brands] b
	on p.brand_id = b.brand_id
inner join [production].[stocks] s
	on s.product_id = p.product_id;


select * from sys.all_views;

select * from sys.views; -- ismen jo humne views humne banai hote hen woh laata he

select * from sys.objects where type = 'V';

select * from sys.sql_modules;

select * from sys.sql_modules where definition like '%product_catalog%';


