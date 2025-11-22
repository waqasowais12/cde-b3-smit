USE Banggood;
GO

-- 1. Average Price (Computer & Games)
SELECT 
    'Computer & Video Games' AS Category_Name,
    ROUND(AVG(Price), 2) AS Avg_Price_USD
FROM computer_videos_games;

-- 2. Product Count (Total items kitne hain?)
SELECT 
    'Computer & Video Games' AS Category_Name,
    COUNT(*) AS Total_Product_Count
FROM computer_videos_games;

-- 3. Top 5 Reviewed Items (Sabse zyada mashhoor)
SELECT TOP 5 
    LEFT(Name, 50) + '...' AS Product_Name, 
    Price, 
    Reviews, 
    Est_Revenue
FROM computer_videos_games
ORDER BY Reviews DESC;

-- 4. Stock Availability Percentage (Assumption: Price > 0 means in stock)
SELECT 
    COUNT(*) AS Total_Items,
    SUM(CASE WHEN Price > 0 THEN 1 ELSE 0 END) AS In_Stock_Items,
    ROUND(
        (CAST(SUM(CASE WHEN Price > 0 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 
    2) AS Stock_Availability_Percent
FROM computer_videos_games;

-- 5. Average Revenue Per Product
SELECT 
    'Computer & Video Games' AS Category_Name,
    ROUND(AVG(Est_Revenue), 2) AS Avg_Revenue_Per_Product
FROM computer_videos_games;
