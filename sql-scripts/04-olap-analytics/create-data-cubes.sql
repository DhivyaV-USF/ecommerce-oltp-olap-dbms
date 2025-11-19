
-- Cube 1: Sales Performance (Product × Category × Time)
CREATE VIEW SalesPerformanceCube AS 
SELECT
    dt.Year,
    dt.Quarter,
    dt.MonthName,
    dp.ProductName,  -- CORRECT: dp is DimProduct
    dcat.CategoryName,
    COUNT(DISTINCT fs.SaleID) AS OrderCount,
    SUM(fs.QuantitySold) AS TotalQuantitySold,
    SUM(fs.SalesAmount) AS TotalSalesAmount,
    AVG(fs.SalesAmount) AS AvgOrderValue,
    COUNT(DISTINCT fs.CustomerKey) AS UniqueCustomers
FROM FactSales fs
INNER JOIN DimTime dt ON fs.TimeKeyDate = dt.TimeKey
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
INNER JOIN DimCategory dcat ON fs.CategoryKey = dcat.CategoryKey
GROUP BY dt.Year, dt.Quarter, dt.MonthName, dp.ProductName, dcat.CategoryName;

-- Cube 2: CustomerBehaviorCube (Customer × Geography × Time × Payment)
CREATE VIEW CustomerBehaviorCube AS
SELECT 
    dt.Year,
    dt.Quarter,
    dt.MonthName,
    dcust.CustomerSegment,
    dcust.City,
    dcust.State,
    dpm.PaymentMethod,
    COUNT(DISTINCT fs.CustomerKey) AS UniqueCustomers,
    COUNT(DISTINCT fs.SaleID) AS TransactionCount,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    AVG(fs.TotalSalesAmount) AS AvgTransactionValue,
    SUM(fs.QuantitySold) AS TotalItemsPurchased
FROM FactSales fs
INNER JOIN DimTime dt ON fs.TimeKeyDate = dt.TimeKey
INNER JOIN DimCustomer dcust ON fs.CustomerKey = dcust.CustomerKey
INNER JOIN DimPaymentMethod dpm ON fs.PaymentMethodKey = dpm.PaymentMethodKey
GROUP BY dt.Year, dt.Quarter, dt.MonthName, dcust.CustomerSegment, dcust.City, dcust.State, dpm.PaymentMethod;

-- CUBE 3: Supplier Performance (CORRECTED)
CREATE VIEW SupplierPerformanceCube AS
SELECT 
    dt.Year,
    dt.Quarter,
    dt.MonthName,
    ds.SupplierName,
    dp.ProductName,
    dcat.CategoryName,
    fs.OrderStatus,
    fs.ShippingStatus,
    COUNT(DISTINCT fs.SaleID) AS OrdersProcessed,
    SUM(fs.QuantitySold) AS TotalQuantityShipped,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    COUNT(CASE WHEN fs.OrderStatus = 'Delivered' THEN 1 END) AS SuccessfulDeliveries,
    ROUND(100.0 * COUNT(CASE WHEN fs.OrderStatus = 'Delivered' THEN 1 END) / 
        COUNT(DISTINCT fs.SaleID), 2) AS DeliverySuccessRate
FROM FactSales fs
INNER JOIN DimTime dt ON fs.TimeKeyDate = dt.TimeKey
INNER JOIN DimSupplier ds ON fs.SupplierKey = ds.SupplierKey
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
INNER JOIN DimCategory dcat ON fs.CategoryKey = dcat.CategoryKey
GROUP BY dt.Year, dt.Quarter, dt.MonthName, ds.SupplierName, dp.ProductName, 
         dcat.CategoryName, fs.OrderStatus, fs.ShippingStatus;

-- Data Cube Validation Query
--  Verify all cubes are functional
SELECT 'SalesPerformanceCube' AS CubeName, COUNT(*) AS AggregationCount 
FROM SalesPerformanceCube
UNION ALL
SELECT 'CustomerBehaviorCube', COUNT(*) FROM CustomerBehaviorCube
UNION ALL
SELECT 'SupplierPerformanceCube', COUNT(*) FROM SupplierPerformanceCube;
