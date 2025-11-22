USE Banggood;
GO

-- 1. Average Price (Gadiyon ka samaan kitna mehnga hai?)
SELECT 
    'Automobiles & Motorcycles' AS Category_Name,
    ROUND(AVG(Price), 2) AS Avg_Price_USD
FROM automobiles_motorcycles;

-- 2. Product Count
SELECT 
    'Automobiles & Motorcycles' AS Category_Name,
    COUNT(*) AS Total_Product_Count
FROM automobiles_motorcycles;

-- 3. Top 5 Reviewed Items
SELECT TOP 5 
    LEFT(Name, 50) + '...' AS Product_Name, 
    Price, 
    Reviews, 
    Est_Revenue
FROM automobiles_motorcycles
ORDER BY Reviews DESC;

-- 4. Stock Availability Percentage
SELECT 
    COUNT(*) AS Total_Items,
    SUM(CASE WHEN Price > 0 THEN 1 ELSE 0 END) AS In_Stock_Items,
    ROUND(
        (CAST(SUM(CASE WHEN Price > 0 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 
    2) AS Stock_Availability_Percent
FROM automobiles_motorcycles;

-- 5. Average Revenue Per Product
SELECT 
    'Automobiles & Motorcycles' AS Category_Name,
    ROUND(AVG(Est_Revenue), 2) AS Avg_Revenue_Per_Product
FROM automobiles_motorcycles;