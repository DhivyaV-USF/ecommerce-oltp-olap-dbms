-- =============================================
-- Query 1: Customer Order Summary with Aggregation
-- Business Value: Identifies high-value customers for targeted retention programs,
-- VIP treatment, and marketing campaigns based on purchase frequency and spending patterns
-- =============================================
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalRevenue,
    AVG(o.TotalAmount) AS AverageOrderValue
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email
ORDER BY TotalRevenue DESC;

-- =============================================
-- Query 2: Customer Purchase Frequency Analysis
-- Business Value: Segments customers by purchase frequency for targeted engagement
-- =============================================
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.City,
    c.State,
    COUNT(o.OrderID) AS PurchaseFrequency,
    SUM(o.TotalAmount) AS TotalSpent,
    ROUND(AVG(o.TotalAmount), 2) AS AvgOrderValue,
    MAX(o.OrderDate) AS LastPurchaseDate,
    CASE 
        WHEN COUNT(o.OrderID) >= 5 THEN 'Premium'
        WHEN COUNT(o.OrderID) >= 3 THEN 'Gold'
        WHEN COUNT(o.OrderID) >= 1 THEN 'Silver'
        ELSE 'Bronze'
    END AS CustomerSegment
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.City, c.State
ORDER BY PurchaseFrequency DESC;

-- =============================================
-- Query 3: Customer Geographic Distribution
-- Business Value: Identifies top-performing regions for expansion and marketing focus
-- =============================================
SELECT 
    c.State,
    c.City,
    COUNT(DISTINCT c.CustomerID) AS UniqueCustomers,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS RegionalRevenue,
    ROUND(AVG(o.TotalAmount), 2) AS AvgOrderValue
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.State, c.City
ORDER BY RegionalRevenue DESC NULLS LAST;

-- =============================================
-- Query 4: Customer Churn Risk Analysis
-- Business Value: Identifies inactive customers for re-engagement campaigns
-- =============================================
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    MAX(o.OrderDate) AS LastPurchaseDate,
    SYSDATE - MAX(o.OrderDate) AS DaysSinceLastOrder,
    COUNT(o.OrderID) AS LifetimeOrders,
    SUM(o.TotalAmount) AS LifetimeValue,
    CASE 
        WHEN (SYSDATE - MAX(o.OrderDate)) > 90 THEN 'High Risk'
        WHEN (SYSDATE - MAX(o.OrderDate)) > 60 THEN 'Medium Risk'
        WHEN (SYSDATE - MAX(o.OrderDate)) > 30 THEN 'Low Risk'
        ELSE 'Active'
    END AS ChurnRiskLevel
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email
HAVING MAX(o.OrderDate) IS NOT NULL
ORDER BY DaysSinceLastOrder DESC;

-- =============================================
-- Query 5: Top Customers by Revenue
-- Business Value: Enables VIP customer management and exclusive benefits programs
-- =============================================
SELECT 
    ROWNUM AS Rank,
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.Phone,
    COUNT(o.OrderID) AS OrderCount,
    SUM(o.TotalAmount) AS TotalRevenue,
    ROUND(SUM(o.TotalAmount) / COUNT(o.OrderID), 2) AS AvgOrderValue
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone
HAVING SUM(o.TotalAmount) IS NOT NULL
ORDER BY TotalRevenue DESC
FETCH FIRST 10 ROWS ONLY;

COMMIT;
-- =============================================
