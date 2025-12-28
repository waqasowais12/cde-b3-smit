-- RENAME WITH UI

-- DISABLE index

--ALTER INDEX INDEX_NAME
--ON TABLE_NAME
--DISABLE;

ALTER INDEX index_name
ON table_name
DISABLE;

ALTER INDEX ALL
ON [sales].[customers]
DISABLE;

-- REBUILD INDEX

ALTER INDEX ALL
ON [sales].[customers]
REBUILD;

               
select * from [production].[products] where product_id=50;

CREATE INDEX ix_product_model_year
ON [production].[products](model_year);

select model_year from [production].[products] where model_year=2017;

-- NON CLUSTERED MEN HUM AGAR CLUSTER WALE COLUMN K BAGER KOI OR COLUMN DENGE TO WOH CLUSTER INDEX PR CHALA JAIGA 
select model_year,product_name from [production].[products] where model_year=2017;

ALTER INDEX ix_product_model_year
ON [production].[products]
DISABLE;

ALTER INDEX ix_product_model_year
ON [production].[products]
REBUILD;

DROP INDEX IF EXISTS ix_product_model_year
ON [production].[products];


CREATE UNIQUE INDEX ix_cust_email 
ON sales.customers(email);

SELECT    
    customer_id, 
    email
FROM    
    sales.customers
WHERE 
    email = 'aide.franco@msn.com';



SELECT    
	first_name,
	last_name, 
	email
FROM    
	sales.customers
WHERE email = 'aide.franco@msn.com';


-- filter index

select count(*) as  HAVE_NO_PHONE
from sales.customers
where phone is null
group by phone; -- 1267


select *
from sales.customers; -- 1445

select 1445 - 1267; -- 178

CREATE INDEX ix_cust_phone
ON sales.customers(phone)
WHERE phone IS NOT NULL;


SELECT    
    first_name,
    last_name, 
    phone
FROM    
    sales.customers
WHERE phone = '(281) 363-3309';


-- COMPUTED COLUMNS FILTER (jo column exists nhi krte lekin unko hum banate hen phr us pr indexes banate hen jese timestamp se date banana)


SELECT    
    first_name,
    last_name,
    email
FROM    
    sales.customers
WHERE 
    SUBSTRING(email, 0, 
        CHARINDEX('@', email, 0)
    ) = 'garry.espinoza';


ALTER TABLE sales.customers
ADD 
    email_local_part AS 
        SUBSTRING(email, 
            0, 
            CHARINDEX('@', email, 0)
        );

select email_local_part, * from sales.customers;

CREATE INDEX ix_cust_email_local_part
ON sales.customers(email_local_part);


SELECT    
    first_name,
    last_name,
    email
FROM    
    sales.customers
WHERE 
    email_local_part = 'garry.espinoza';


select * from [sales].[order_items];

ALTER TABLE [sales].[order_items]
ADD price_after_discount AS
(
    list_price - (list_price * discount)
);


CREATE INDEX ix_list_price_after_discount
ON [sales].[order_items](price_after_discount);

select * from [sales].[order_items];

select 
product_id,
quantity,
price_after_discount
from 
[sales].[order_items]
where price_after_discount > 1000;

-- STORED PROCEDURE

CREATE PROCEDURE sp_ny_customers
as
BEGIN
      select * from [sales].[customers] where state = 'NY';
END;

EXEC sp_ny_customers;