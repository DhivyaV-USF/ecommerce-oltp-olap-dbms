-- =============================================
-- Query 1: Sales Performance by Time
-- Business Value: Identify seasonal trends and growth patterns
-- =============================================
SELECT 
    dt.Year,
    dt.Quarter,
    dt.MonthName,
    COUNT(DISTINCT fs.SaleID) AS OrderCount,
    SUM(fs.QuantitySold) AS TotalQuantity,
    SUM(fs.SalesAmount) AS TotalRevenue,
    ROUND(AVG(fs.SalesAmount), 2) AS AvgOrderValue
FROM FactSales fs
INNER JOIN DimTime dt ON fs.TimeKeyDate = dt.TimeKey
GROUP BY dt.Year, dt.Quarter, dt.MonthName
ORDER BY dt.Year, dt.Quarter, dt.MonthName;

-- =============================================
-- Query 2: Revenue by Customer Segment
-- Business Value: Target high-value customer segments
-- =============================================
SELECT 
    dcust.CustomerSegment,
    COUNT(DISTINCT dcust.CustomerKey) AS UniqueCustomers,
    COUNT(DISTINCT fs.SaleID) AS TransactionCount,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    ROUND(AVG(fs.TotalSalesAmount), 2) AS AvgTransactionValue,
    ROUND(SUM(fs.TotalSalesAmount) / COUNT(DISTINCT dcust.CustomerKey), 2) AS RevenuePerCustomer
FROM FactSales fs
INNER JOIN DimCustomer dcust ON fs.CustomerKey = dcust.CustomerKey
GROUP BY dcust.CustomerSegment
ORDER BY TotalRevenue DESC;

-- =============================================
-- Query 3: Top Products by Revenue
-- Business Value: Identify best-selling products for inventory planning
-- =============================================
SELECT 
    dp.ProductName,
    dcat.CategoryName,
    COUNT(DISTINCT fs.SaleID) AS TimesSold,
    SUM(fs.QuantitySold) AS TotalQuantitySold,
    ROUND(AVG(fs.UnitPrice), 2) AS AvgUnitPrice,
    SUM(fs.SalesAmount) AS TotalProductRevenue,
    ROUND(SUM(fs.SalesAmount) / SUM(fs.QuantitySold), 2) AS AvgRevenuePerUnit
FROM FactSales fs
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
INNER JOIN DimCategory dcat ON fs.CategoryKey = dcat.CategoryKey
GROUP BY dp.ProductName, dcat.CategoryName
ORDER BY TotalProductRevenue DESC
FETCH FIRST 10 ROWS ONLY;

-- =============================================
-- Query 4: Category Performance Analysis
-- Business Value: Optimize category mix and marketing spend
-- =============================================
SELECT 
    dcat.CategoryName,
    COUNT(DISTINCT fs.SaleID) AS OrderCount,
    SUM(fs.QuantitySold) AS TotalQuantity,
    SUM(fs.SalesAmount) AS TotalRevenue,
    ROUND(100.0 * SUM(fs.SalesAmount) / (SELECT SUM(fs2.SalesAmount) FROM FactSales fs2), 2) AS RevenuePercentage,
    ROUND(AVG(fs.SalesAmount), 2) AS AvgOrderValue,
    ROUND(AVG(fs.QuantitySold), 2) AS AvgQuantityPerOrder
FROM FactSales fs
INNER JOIN DimCategory dcat ON fs.CategoryKey = dcat.CategoryKey
GROUP BY dcat.CategoryName
ORDER BY TotalRevenue DESC;

-- =============================================
-- Query 5: Supplier Performance and Delivery Reliability
-- Business Value: Evaluate supplier relationships and performance
-- =============================================
SELECT 
    ds.SupplierName,
    COUNT(DISTINCT fs.SaleID) AS TotalOrders,
    SUM(fs.QuantitySold) AS TotalQuantityShipped,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    COUNT(CASE WHEN fs.OrderStatus = 'Delivered' THEN 1 END) AS DeliveredOrders,
    COUNT(CASE WHEN fs.OrderStatus = 'Pending' THEN 1 END) AS PendingOrders,
    COUNT(CASE WHEN fs.OrderStatus = 'Processing' THEN 1 END) AS ProcessingOrders,
    COUNT(CASE WHEN fs.OrderStatus = 'Shipped' THEN 1 END) AS ShippedOrders,
    ROUND(100.0 * COUNT(CASE WHEN fs.OrderStatus = 'Delivered' THEN 1 END) / COUNT(DISTINCT fs.SaleID), 2) AS DeliverySuccessRate
FROM FactSales fs
INNER JOIN DimSupplier ds ON fs.SupplierKey = ds.SupplierKey
GROUP BY ds.SupplierName
ORDER BY DeliverySuccessRate DESC, TotalRevenue DESC;

-- =============================================
-- Query 6: Monthly Sales Trend Analysis
-- Business Value: Track growth patterns and forecast future sales
-- =============================================
SELECT 
    dt.Year,
    dt.Month,
    dt.MonthName,
    SUM(fs.TotalSalesAmount) AS MonthlyRevenue,
    COUNT(DISTINCT fs.SaleID) AS OrderCount,
    ROUND(AVG(fs.TotalSalesAmount), 2) AS AvgOrderValue,
    LAG(SUM(fs.TotalSalesAmount)) OVER (ORDER BY dt.Year, dt.Month) AS PreviousMonthRevenue,
    ROUND(
        100.0 * (SUM(fs.TotalSalesAmount) - LAG(SUM(fs.TotalSalesAmount)) OVER (ORDER BY dt.Year, dt.Month)) 
        / NULLIF(LAG(SUM(fs.TotalSalesAmount)) OVER (ORDER BY dt.Year, dt.Month), 0), 
        2
    ) AS GrowthPercentage
FROM FactSales fs
INNER JOIN DimTime dt ON fs.TimeKeyDate = dt.TimeKey
GROUP BY dt.Year, dt.Month, dt.MonthName
ORDER BY dt.Year, dt.Month;

-- =============================================
-- Query 7: Payment Method Preferences
-- Business Value: Optimize payment processing infrastructure
-- =============================================
SELECT 
    dpm.PaymentMethod,
    COUNT(DISTINCT fs.SaleID) AS TransactionCount,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    ROUND(AVG(fs.TotalSalesAmount), 2) AS AvgTransactionValue,
    ROUND(100.0 * COUNT(DISTINCT fs.SaleID) / (SELECT COUNT(DISTINCT fs2.SaleID) FROM FactSales fs2), 2) AS UsagePercentage
FROM FactSales fs
INNER JOIN DimPaymentMethod dpm ON fs.PaymentMethodKey = dpm.PaymentMethodKey
GROUP BY dpm.PaymentMethod
ORDER BY TransactionCount DESC;

-- =============================================
-- Query 8: Customer Geographic Analysis
-- Business Value: Target regional marketing campaigns
-- =============================================
SELECT 
    dcust.State,
    dcust.City,
    COUNT(DISTINCT dcust.CustomerKey) AS UniqueCustomers,
    COUNT(DISTINCT fs.SaleID) AS TotalOrders,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    ROUND(AVG(fs.TotalSalesAmount), 2) AS AvgOrderValue
FROM FactSales fs
INNER JOIN DimCustomer dcust ON fs.CustomerKey = dcust.CustomerKey
WHERE dcust.State IS NOT NULL
GROUP BY dcust.State, dcust.City
ORDER BY TotalRevenue DESC
FETCH FIRST 20 ROWS ONLY;

COMMIT;
