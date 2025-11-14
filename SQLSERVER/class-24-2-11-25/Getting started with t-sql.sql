-- Querying data

-- fully qualified naming
-- [Bikestores].[sales].[customers]
-- [database].[schema].[table/view]

SELECT * FROM [Bikestore].[sales].[customers];

SELECT first_name FROM [Bikestore].[sales].[customers];

SELECT first_name, last_name FROM [Bikestore].[sales].[customers];

-- condition (WHERE)

SELECT * FROM [Bikestore].[sales].[customers] WHERE state = 'NY';

SELECT * FROM [Bikestore].[sales].[customers] WHERE state <> 'NY';  -- not equals to "<>"

-- Operators (AND, OR, NOT, BETWEEN)

SELECT * FROM [Bikestore].[sales].[customers] WHERE state = 'NY' AND customer_id > 100;  

SELECT * FROM [Bikestore].[sales].[customers] WHERE phone IS NOT NULL;   --- recomended
--------------------------- OR ---------------------------------------
SELECT * FROM [Bikestore].[sales].[customers] WHERE phone <> 'NULL';  

SELECT * 
FROM 
	[Bikestore].[sales].[customers] 
WHERE 
	customer_id BETWEEN 101 AND 105;

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	last_name = 'Bates' OR first_name = 'Marget';

-- LIKE (wildcard) [%, _, [], [^]]

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE '%Aa'; -- '%' is wildcard (wildcard works with a 'LIKE' keyword)

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE '%a'; -- % is wildcard

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE 'Aa_on'; -- If you that in a name there is only one missing letter so you can place single '_' if more so you apply according to the missing value

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE 'Aa%on'; -- If you don't know the missing values so you apply % in the middle of the name

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE '[A-C]%'; -- select all from where name starts with a range from A-C

SELECT *
FROM 
	[Bikestore].[sales].[customers]
WHERE
	first_name LIKE '[^A-C]%'; -- select all from where name don't starts with a range from A-C


-- Sorting ORDER BY (Required--> default ASC), ASC/DESC(Optional)

SELECT * FROM [Bikestore].[sales].[customers] ORDER BY first_name, state; -- It gives priority to the first column values (first_name)

SELECT * FROM [Bikestore].[sales].[customers] ORDER BY state, first_name; -- It gives priority to the first column values (state)

SELECT * FROM [Bikestore].[sales].[customers]
ORDER BY state DESC, first_name ASC;

SELECT * FROM [Bikestore].[sales].[customers]
ORDER BY state DESC, first_name DESC;

-- limiting (TOP, OFFSET/FETCH)
--ORDER BY column_list [ASC |DESC]
--OFFSET offset_row_count {ROW | ROWS}
--FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY

SELECT TOP(15)*
FROM [Bikestore].[sales].[customers];

SELECT *
FROM [Bikestore].[sales].[customers] 
ORDER BY customer_id OFFSET 10 ROWS; -- skip the first 10 rows on behalf of customer ID

SELECT *
FROM [Bikestore].[sales].[customers] 
ORDER BY customer_id OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY; -- skip the first 10 rows on behalf of customer ID and give the next 10 rows

SELECT *
FROM [Bikestore].[sales].[customers] 
ORDER BY customer_id OFFSET 1435 ROWS 
FETCH NEXT 10 ROWS ONLY; -- skip the first 1435 rows on behalf of customer ID and give the last 10 rows

SELECT * 
FROM [Bikestore].[production].[products]
ORDER BY list_price DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY; -- uses the OFFSET FETCH clause to retrieve the top 10 most expensive products from the products table

SELECT product_name, list_price 
FROM [Bikestore].[production].[products]
ORDER BY list_price DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY; -- uses the OFFSET FETCH clause to retrieve the top 10 most expensive products from the products table with columns only(product_name, list_price)

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

-- Task concat two columns into one columns

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name
FROM
	[Bikestore].[sales].[customers];