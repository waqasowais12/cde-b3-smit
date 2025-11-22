USE Banggood;
GO

-- 1. Average Price (Kapdon ki average price)
SELECT 
    'Men & Women Clothing' AS Category_Name,
    ROUND(AVG(Price), 2) AS Avg_Price_USD
FROM men_women_clothing;

-- 2. Product Count (Total kapde)
SELECT 
    'Men & Women Clothing' AS Category_Name,
    COUNT(*) AS Total_Product_Count
FROM men_women_clothing;

-- 3. Top 5 Reviewed Items (Sabse popular fashion)
SELECT TOP 5 
    LEFT(Name, 50) + '...' AS Product_Name, 
    Price, 
    Reviews, 
    Est_Revenue
FROM men_women_clothing
ORDER BY Reviews DESC;

-- 4. Stock Availability Percentage
SELECT 
    COUNT(*) AS Total_Items,
    SUM(CASE WHEN Price > 0 THEN 1 ELSE 0 END) AS In_Stock_Items,
    ROUND(
        (CAST(SUM(CASE WHEN Price > 0 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 
    2) AS Stock_Availability_Percent
FROM men_women_clothing;

-- 5. Average Revenue Per Product
SELECT 
    'Men & Women Clothing' AS Category_Name,
    ROUND(AVG(Est_Revenue), 2) AS Avg_Revenue_Per_Product
FROM men_women_clothing;