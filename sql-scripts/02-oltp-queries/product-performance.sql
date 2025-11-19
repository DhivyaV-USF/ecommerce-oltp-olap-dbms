-- =============================================
-- Query 1: Product Performance Analysis with Multiple Joins
-- Business Value: Guides inventory optimization, product promotion strategies, and 
-- discontinuation decisions based on sales performance and category contribution
-- =============================================
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.SupplierName,
    p.UnitPrice,
    p.QuantityInStock,
    COUNT(oi.OrderItemID) AS TimesSold,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.LineTotal) AS TotalRevenue,
    ROUND(SUM(oi.LineTotal) / NULLIF(COUNT(oi.OrderItemID), 0), 2) AS AvgRevenuePerSale
FROM PRODUCTS p
INNER JOIN CATEGORIES c ON p.CategoryID = c.CategoryID
INNER JOIN SUPPLIERS s ON p.SupplierID = s.SupplierID
LEFT JOIN ORDER_ITEMS oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, c.CategoryName, s.SupplierName, p.UnitPrice, p.QuantityInStock
ORDER BY TotalRevenue DESC;

-- =============================================
-- Query 2: Low Stock Alert Analysis
-- Business Value: Identifies products requiring reorder for inventory management
-- =============================================
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.QuantityInStock,
    p.ReorderLevel,
    p.UnitPrice,
    (p.QuantityInStock * p.UnitPrice) AS InventoryValue,
    CASE 
        WHEN p.QuantityInStock <= p.ReorderLevel THEN 'URGENT: Reorder Required'
        WHEN p.QuantityInStock <= (p.ReorderLevel * 1.5) THEN 'WARNING: Low Stock'
        ELSE 'Adequate Stock'
    END AS StockStatus
FROM PRODUCTS p
INNER JOIN CATEGORIES c ON p.CategoryID = c.CategoryID
WHERE p.QuantityInStock <= (p.ReorderLevel * 1.5)
ORDER BY InventoryValue DESC;

-- =============================================
-- Query 3: Top Performing Products by Revenue
-- Business Value: Identifies bestsellers for promotion and category focus
-- =============================================
SELECT 
    ROWNUM AS Rank,
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.SupplierName,
    COUNT(oi.OrderItemID) AS TimesSold,
    SUM(oi.Quantity) AS TotalQuantitySold,
    ROUND(SUM(oi.LineTotal), 2) AS TotalRevenue
FROM PRODUCTS p
INNER JOIN CATEGORIES c ON p.CategoryID = c.CategoryID
INNER JOIN SUPPLIERS s ON p.SupplierID = s.SupplierID
LEFT JOIN ORDER_ITEMS oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, c.CategoryName, s.SupplierName
HAVING SUM(oi.LineTotal) IS NOT NULL
ORDER BY TotalRevenue DESC
--FETCH FIRST 10 ROWS ONLY;

-- =============================================
-- Query 4: Product Category Performance Comparison
-- Business Value: Evaluates category contribution to overall revenue
-- =============================================
SELECT 
    c.CategoryID,
    c.CategoryName,
    COUNT(DISTINCT p.ProductID) AS TotalProducts,
    COUNT(DISTINCT oi.OrderItemID) AS ItemsSold,
    SUM(oi.Quantity) AS TotalQuantity,
    ROUND(SUM(oi.LineTotal), 2) AS CategoryRevenue,
    ROUND(100.0 * SUM(oi.LineTotal) / (SELECT SUM(oi2.LineTotal) FROM ORDER_ITEMS oi2), 2) AS RevenuePercentage,
    ROUND(AVG(oi.LineTotal), 2) AS AvgItemValue
FROM CATEGORIES c
INNER JOIN PRODUCTS p ON c.CategoryID = p.CategoryID
LEFT JOIN ORDER_ITEMS oi ON p.ProductID = oi.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY CategoryRevenue DESC;

-- =============================================
-- Query 5: Slow-Moving Inventory Analysis
-- Business Value: Identifies products for clearance or discontinuation
-- =============================================
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.UnitPrice,
    p.QuantityInStock,
    (p.QuantityInStock * p.UnitPrice) AS InventoryValue,
    COUNT(oi.OrderItemID) AS TimesSold,
    COALESCE(SUM(oi.Quantity), 0) AS QuantitySold,
    MAX(oi.OrderItemID) AS LastSaleDate,
    CASE 
        WHEN COUNT(oi.OrderItemID) = 0 THEN 'No Sales'
        WHEN COUNT(oi.OrderItemID) < 3 THEN 'Very Low Sales'
        WHEN COUNT(oi.OrderItemID) < 5 THEN 'Low Sales'
        ELSE 'Moderate Sales'
    END AS SalesPerformance
FROM PRODUCTS p
INNER JOIN CATEGORIES c ON p.CategoryID = c.CategoryID
LEFT JOIN ORDER_ITEMS oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, c.CategoryName, p.UnitPrice, p.QuantityInStock
HAVING COUNT(oi.OrderItemID) < 5
ORDER BY InventoryValue DESC;

-- =============================================
-- Query 6: Supplier Product Performance
-- Business Value: Evaluates supplier quality and product competitiveness
-- =============================================
SELECT 
    s.SupplierID,
    s.SupplierName,
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    SUM(oi.Quantity) AS TotalQuantitySupplied,
    ROUND(SUM(oi.LineTotal), 2) AS TotalRevenue,
    ROUND(AVG(oi.LineTotal), 2) AS AvgItemValue,
    COUNT(DISTINCT oi.OrderItemID) AS TimesSold
FROM SUPPLIERS s
LEFT JOIN PRODUCTS p ON s.SupplierID = p.SupplierID
LEFT JOIN ORDER_ITEMS oi ON p.ProductID = oi.ProductID
GROUP BY s.SupplierID, s.SupplierName
ORDER BY TotalRevenue DESC;

COMMIT;