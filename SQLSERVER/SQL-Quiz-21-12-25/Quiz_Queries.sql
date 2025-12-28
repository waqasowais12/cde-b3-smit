select
		TOP 5
		c.CustomerID, 
		c.Name, 
		sum(s.TotalAmount) as TotalSales
from [dbo].[Customer] c
inner join SalesOrder s
on s.CustomerID = c.CustomerID
group by c.CustomerID, c.Name
order by TotalSales desc;


select s.SupplierID, s.Name, count(p.ProductID) as ProductsCount
from [dbo].[Supplier] s
inner join [dbo].[PurchaseOrder] po
on s.SupplierID = po.SupplierID
inner join [dbo].[PurchaseOrderDetail] pod
on po.OrderID = pod.OrderID
inner join [dbo].[Product] p
on pod.ProductID = p.ProductID
group by s.SupplierID, s.Name
having count(p.ProductID) > 10;


select  p.ProductID, p.Name, sum(sod.Quantity) as TotalOrderQuantity
from [dbo].[Product] p
left join [dbo].[ReturnDetail] r
on p.ProductID = r.ProductID
inner join [dbo].[SalesOrderDetail] sod
on p.ProductID = sod.ProductID
WHERE r.ProductID is null
group by p.ProductID, p.Name;

select c.CategoryID, c.Name, p.Name, p.Price
from [dbo].[Category] c
inner join [dbo].[Product] p
on c.CategoryID = p.CategoryID
where p.Price = (select Max(p1.Price) from [dbo].[Product] p1
where p.CategoryID = p1.CategoryID
)order by p.Price desc;

select so.OrderID, cus.Name CustomerName, p.Name ProductName, c.Name CategoryName, s.Name SupplierName, sod.Quantity
from [dbo].[Supplier] s
inner join [dbo].[PurchaseOrder] po
on s.SupplierID = po.SupplierID
inner join [dbo].[PurchaseOrderDetail] pod
on po.OrderID = pod.OrderID
inner join [dbo].[Product] p
on pod.ProductID = p.ProductID
inner join [dbo].[Category] c
on p.CategoryID = c.CategoryID
inner join [dbo].[SalesOrderDetail] sod
on p.ProductID = sod.ProductID
inner join [dbo].[SalesOrder] so
on sod.OrderID = so.OrderID
inner join [dbo].[Customer] cus
on so.CustomerID = cus.CustomerID;

--- OR ----

SELECT
    so.OrderID,
    cus.Name AS CustomerName,
    p.Name AS ProductName,
    c.Name AS CategoryName,
    m.Name AS SupplierName,  
    sod.Quantity
FROM dbo.SalesOrder so
INNER JOIN dbo.Customer cus
    ON so.CustomerID = cus.CustomerID
INNER JOIN dbo.SalesOrderDetail sod
    ON so.OrderID = sod.OrderID
INNER JOIN dbo.Product p
    ON sod.ProductID = p.ProductID
INNER JOIN dbo.Category c
    ON p.CategoryID = c.CategoryID
INNER JOIN dbo.Manufacturer m
    ON p.ManufacturerID = m.ManufacturerID;