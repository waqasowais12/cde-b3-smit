
------------------------------------------------ QUESTION # 1 -------------------------------------------------------

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

------------------------------------------------ QUESTION # 2 -------------------------------------------------------

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

------------------------------------------------ QUESTION # 3 -------------------------------------------------------

select  p.ProductID, p.Name, sum(sod.Quantity) as TotalOrderQuantity
from [dbo].[Product] p
left join [dbo].[ReturnDetail] r
on p.ProductID = r.ProductID
inner join [dbo].[SalesOrderDetail] sod
on p.ProductID = sod.ProductID
WHERE r.ProductID is null
group by p.ProductID, p.Name;

------------------------------------------------ QUESTION # 4 -------------------------------------------------------

select c.CategoryID, c.Name, p.Name, p.Price
from [dbo].[Category] c
inner join [dbo].[Product] p
on c.CategoryID = p.CategoryID
where p.Price = (select Max(p1.Price) from [dbo].[Product] p1
where p.CategoryID = p1.CategoryID
)order by p.Price desc;

------------------------------------------------ QUESTION # 5 -------------------------------------------------------

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

------------------------------------------------ QUESTION # 6 -------------------------------------------------------

select 
    s.ShipmentID,
    l.Name Warehouse_Name,
    e.Name Manager_Name,
    p.Name Product_Name,
    sd.Quantity,
    s.TrackingNumber
from [dbo].[Shipment] s
inner join [dbo].[Warehouse] w
on s.WarehouseID = w.WarehouseID
inner join [dbo].[Location] l
on w.LocationID = l.LocationID
inner join [dbo].[Employee] e
on w.ManagerID = e.ManagerID
inner join [dbo].[ShipmentDetail] sd
on s.ShipmentID = sd.ShipmentID
inner join [dbo].[Product] p
on sd.ProductID = p.ProductID

------------------------------------------------ QUESTION # 7 -------------------------------------------------------

with cte as (
select 
    c.CustomerID,
    c.Name,
    so.OrderID,
    so.TotalAmount,
    RANK() OVER (PARTITION BY so.CustomerID ORDER BY so.TotalAmount DESC) rnk
from
    [dbo].[Customer] c
inner join [dbo].[SalesOrder] so
on c.CustomerID = so.CustomerID
)
select * 
from 
    cte
where rnk <= 3
    
------------------------------------------------ QUESTION # 8 -------------------------------------------------------

select 
    p.ProductID,
    p.Name,
    sod.OrderID,
    so.OrderDate,
    sod.Quantity,
    LAG(sod.Quantity) OVER (PARTITION BY p.ProductID ORDER BY so.OrderDate) PrevQuantity,
    LEAD(sod.Quantity) OVER (PARTITION BY p.ProductID ORDER BY so.OrderDate) NextQuantity
from 
    [dbo].[SalesOrderDetail] sod
inner join [dbo].[Product] p
on sod.ProductID = p.ProductID
inner join [dbo].[SalesOrder] so
on sod.OrderID = so.OrderID;

------------------------------------------------ QUESTION # 9 -------------------------------------------------------

create view vw_CustomerOrderSummary 
as
select 
    c.CustomerID,
    c.Name,
    COUNT(so.OrderID) TotalOrders,
    SUM(so.TotalAmount) TotalAmount,
    MAX(so.OrderDate) LastOrderDate
from 
   [dbo].[Customer] c
inner join [dbo].[SalesOrder] so
on c.CustomerID = so.CustomerID
group by
    c.CustomerID,
    c.Name;

select * from vw_CustomerOrderSummary;

------------------------------------------------ QUESTION # 10 -------------------------------------------------------

alter procedure sp_total_sales 
    @SupplierID int
as
begin
select 
    ISNULL(SUM(pod.TotalAmount), 0) TotalSalesAmount
from
    [dbo].[Supplier] sp
inner join [dbo].[PurchaseOrder] po
on sp.SupplierID = po.SupplierID
inner join [dbo].[PurchaseOrderDetail] pod
on po.OrderID = pod.OrderID
where sp.SupplierID = @SupplierID
end;

exec sp_total_sales 2;



