select 
	so.order_id,
	so.order_date,
	sc.customer_id
from 
	[sales].[orders] so
	inner join [sales].[customers] sc
	on so.customer_id = sc.customer_id
	where sc.city = 'New York';

-- agar hamen do tables k columns chahiyen customize to hum join lagainge 
-- or agar hamen sirf ek table ka data chahiye kisi dosre table pr condition lagake to hum sub query lagainge

SELECT
    order_id,
    order_date,
FROM
    sales.orders
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            sales.customers
        WHERE
            city = 'New York'
    )
ORDER BY
    order_date DESC;

-- correlation subquery (outer or nested dono ek dosre pr dependent hoti hen)

select * from students s
    customer_id
where marks >
    select avg(marks)
    from student ss
        where ss.class = s.class



SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1 -- outer table
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id -- inner table
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;

select *
from
    [sales].[customers] sc
where 
    EXISTS(
       select 
        count(*)
       from 
        [sales].[orders] so
       where 
        so.customer_id = sc.customer_id
        and year(so.order_date) = 2018
       group by
        so.customer_id
       having
        count(*) > 2
    )
order by
    first_name,
    last_name;



select *
from
    [sales].[customers] sc
where 
    sc.customer_id in(
       select 
        so.customer_id
       from 
        [sales].[orders] so
       where 
        so.customer_id = sc.customer_id
        and year(so.order_date) = 2018
       group by
        so.customer_id
       having
        count(*) > 2
    )
order by
    first_name,
    last_name;



CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Class VARCHAR(50),
    Marks INT
);

INSERT INTO Students (ID, Name, Class, Marks) VALUES
(1, 'Ali Khan', '10th', 85),
(2, 'Sara Ahmed', '9th', 92),
(3, 'Waqas Malik', '10th', 76),
(4, 'Hina Shah', '8th', 88),
(5, 'Usman Tariq', '9th', 81);


select * from Students;

-- any (satisfy any one condition) -- min value
-- all (satisfy all) -- max value



select * from Students
where marks > all(select avg(marks) from students  -- (80, 88, 86) --> all men in sub values ko satisfy krne k baad jo inse sb se bari values hongi woh aingi
group by class);

select * from Students
where marks = any(select avg(marks) from students  -- (80, 88, 86) --> all men in sub values ko satisfy krne k baad jo inse sb se bari values hongi woh aingi
group by class);


-- Union (Both tables column must be same and the values of tables appear in row wise first appear all rows of first table than second table)

select first_name, last_name
from [sales].[staffs]
union
select first_name, last_name
from [sales].[customers] --- 1445 + 9 --- 1454

select first_name, last_name
from [sales].[staffs]
union all
select first_name, last_name
from [sales].[customers] --- 1445 + 10 --- 1455

--- intersection

select first_name, last_name
from [sales].[staffs]
intersect
select first_name, last_name
from [sales].[customers]


select first_name, last_name --- show duplicate records in a same table
from  [sales].[customers]
group by first_name,last_name
having count(*) > 1;

--- except (show the unique value from the first table)

SELECT
    product_id
FROM
    production.products
EXCEPT
SELECT
    product_id
FROM
    sales.order_items
order by
    product_id;