--1. INNER Join - Customers with Orders
-- sql
-- customers with orders
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    o.OrderStatus
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID, o.OrderDate DESC;

--Purpose: Shows only customers who have placed orders, excluding dormant customers from analysis. Returns matched records from both tables where join condition satisfied.
--2. LEFT Join - All Customers with/without Orders
-- sql
-- customers with or without orders
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.Phone,
    COUNT(o.OrderID) AS OrderCount,
    COALESCE(SUM(o.TotalAmount), 0) AS TotalSpent,
    CASE 
        WHEN o.OrderID IS NULL THEN 'No Orders'
        ELSE 'Active Customer'
    END AS CustomerStatus
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, 
    CASE WHEN o.OrderID IS NULL THEN 'No Orders' ELSE 'Active Customer' END
ORDER BY OrderCount DESC;

--Purpose: Identifies inactive customers with no orders for re-engagement campaigns. Preserves all customers from left table without matching orders. 
--3. RIGHT Join - All Categories with Products
-- sql
-- categories with products
SELECT 
    c.CategoryID,
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount,
    COALESCE(SUM(p.QuantityInStock), 0) AS TotalInventory,
    COALESCE(AVG(p.UnitPrice), 0) AS AvgProductPrice,
    CASE 
        WHEN COUNT(p.ProductID) = 0 THEN 'Empty Category'
        WHEN COUNT(p.ProductID) < 3 THEN 'Limited Selection'
        ELSE 'Well Stocked'
    END AS CategoryStatus
FROM CATEGORIES c
RIGHT JOIN PRODUCTS p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY ProductCount DESC;

--Purpose: Identifies slow-moving or obsolete inventory requiring promotional action or discontinuation decisions.
--4. FULL OUTER Join - Orders and Payments Reconciliation
-- sql
-- orders and payments mismatch identification
SELECT 
    COALESCE(o.OrderID, p.OrderID) AS OrderID,
    o.OrderDate,
    o.TotalAmount AS OrderAmount,
    p.PaymentAmount,
    p.PaymentMethod,
    p.PaymentStatus,
    CASE 
        WHEN o.OrderID IS NULL THEN 'Payment Without Order'
        WHEN p.OrderID IS NULL THEN 'Order Without Payment'
        WHEN o.TotalAmount = p.PaymentAmount THEN 'Amount Match'
        WHEN o.TotalAmount > p.PaymentAmount THEN 'Under-Paid'
        WHEN o.TotalAmount < p.PaymentAmount THEN 'Over-Paid'
    END AS ReconciliationStatus
FROM ORDERS o
FULL OUTER JOIN PAYMENTS p ON o.OrderID = p.OrderID
ORDER BY OrderID;

--Purpose: Financial reconciliation and audit compliance identifying payment-order mismatches requiring investigation andcorrection.
