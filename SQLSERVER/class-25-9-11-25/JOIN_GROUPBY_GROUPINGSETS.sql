-- DDLs Data Definition Language

CREATE DATABASE MISC;

USE MISC;

--DROP TABLE Lefttable;

CREATE TABLE Lefttable(
	dated date,
	CountryID int,
	Units int
);

--DROP TABLE Righttable;

CREATE TABLE Righttable(
	Id int,
	Country varchar(20)
);

-- DMLs Data Manipulation Language

INSERT INTO Lefttable(dated,CountryID,units) VALUES
('2020-01-01',1,40),
('2020-01-02',1,25),
('2020-01-03',3,30),
('2020-01-04',2,35);

INSERT INTO Righttable (Id,Country) VALUES
(3,'PA'),
(4,'SPAIN');

SELECT * FROM Lefttable;
SELECT * FROM Righttable;

-- Left Join
SELECT
	l.CountryID,
	l.Units,
	l.dated,
	r.Country
FROM Lefttable l
LEFT JOIN Righttable r
ON l.CountryID = r.Id;

-- Right Join
SELECT
	r.Id,
	l.Units,
	l.dated,
	r.Country
FROM Lefttable l
RIGHT JOIN Righttable r
ON l.CountryID = r.Id;

-- Full Join
SELECT *
FROM Lefttable l
FULL JOIN Righttable r
ON l.CountryID = r.Id;


-- Inner Join
SELECT *
FROM Lefttable As l
INNER JOIN Righttable As r
On l.CountryID = r.Id;

SELECT * FROM Lefttable;
SELECT * FROM Righttable;

-- Left Anti Join
SELECT
	l.CountryID,
	l.Units,
	l.dated
FROM Lefttable l
LEFT JOIN Righttable r
ON l.CountryID = r.Id
WHERE r.Id is null;

-- Right Ani Join
SELECT
	r.Id,
	r.Country
FROM Lefttable l
RIGHT JOIN Righttable r
ON l.CountryID = r.Id
WHERE l.CountryID is null;


------------------------------------ORDER OF EXECUTION OF COMMANDS IN SQL-----------------------------------
-- FROM/JOIN >> WHERE >> GROUP BY >> HAVING >> SELECT >> DISTINCT >> ORDER BY >> LIMITS/OFFSET

-- Full Outer join
SELECT *
FROM Lefttable l
FULL OUTER JOIN Righttable r
ON l.CountryID = r.Id;


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
	l.CountryID,
	l.dated,
	l.Units
FROM Lefttable As l
Left JOIN Righttable As r
On l.CountryID = r.Id
WHERE l.CountryID = r.Id;


-- Cross Join

CREATE TABLE Leftttable(
	ID int,
);

CREATE TABLE Rightttable(
	letter varchar(20)
);

INSERT INTO Leftttable(ID) VALUES
(1),
(2),
(3);

INSERT INTO Rightttable(letter) VALUES
('A'),
('B'),
('C');

SELECT * 
FROM 
	Leftttable
CROSS JOIN Rightttable;

-- Self Join
USE Bikestore
SELECT * FROM [sales].[staffs]

SELECT 
	e.first_name + ' ' + e.last_name AS employee_name,
	m.first_name + ' ' + m.last_name AS employee_name
FROM [sales].staffs e
INNER JOIN [sales].[staffs] m
ON e.staff_id = m.manager_id;

SELECT 
	e.first_name + ' ' + e.last_name AS employee_name,
	m.first_name + ' ' + m.last_name AS employee_name
FROM [sales].staffs e
RIGHT JOIN [sales].[staffs] m
ON e.staff_id = m.manager_id;

SELECT 
	e.first_name + ' ' + e.last_name AS employee_name,
	m.first_name + ' ' + m.last_name AS employee_name
FROM [sales].staffs e
LEFT JOIN [sales].[staffs] m
ON e.staff_id = m.manager_id;

-- GROUP BY

SELECT 
	state, 
	count(*) AS state_count
FROM sales.customers
GROUP BY state;

SELECT 
	state, 
	count(*) AS state_count
FROM sales.customers
GROUP BY state
HAVING count(*) > 1000;

--GROUPING SETS TOPIC

SELECT 
	b.brand_name AS brand,
	c.category_name AS category,
	p.model_year,
	ROUND(
		SUM (
			quantity * oi.list_price * (1 - discount)
		),
		0
	) AS sales INTO sales.sales_summary
FROM 
	sales.order_items oi
INNER JOIN production.products p ON oi.product_id = p.product_id
INNER JOIN production.brands b ON p.brand_id = b.brand_id
INNER JOIN production.categories c ON p.category_id = c.category_id
GROUP BY
	b.brand_name,
	c.category_name,
	p.model_year
ORDER BY
	b.brand_name,
	c.category_name,
	p.model_year

SELECT 
	Brand, 
	SUM(sales) as brand_sales 
FROM sales.sales_summary
GROUP BY brand;

SELECT 
	brand, 
	category,
	SUM(sales) as brand_sales 
FROM sales.sales_summary
GROUP BY brand, category;

SELECT 
	SUM(sales) as brand_sales 
FROM sales.sales_summary;

--------------------------------------------APPLY GROUPING SETS-----------------------------------------------------

SELECT 
	brand, 
	category,
	SUM(sales) AS sale
FROM sales.sales_summary
GROUP BY 
	GROUPING SETS (
		(brand, category),
		(brand),
		(category),
		() ---> TOTAL SALES
	)
ORDER BY
	brand,
	category;
