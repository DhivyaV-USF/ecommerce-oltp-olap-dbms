-- =============================================
-- Query 1: Order Status Verification with Health Check
-- Business Value: Quality assurance for order fulfillment pipeline identifying status 
-- mismatches requiring investigation and remediation
-- =============================================
SELECT 
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    o.TotalAmount,
    p.PaymentMethod,
    p.PaymentStatus,
    p.PaymentAmount,
    s.ShippingStatus,
    CASE 
        WHEN o.OrderStatus = 'Delivered' AND p.PaymentStatus = 'Completed' THEN 'Fulfilled'
        WHEN o.OrderStatus = 'Processing' AND p.PaymentStatus = 'Pending' THEN 'In Progress'
        WHEN o.OrderStatus = 'Shipped' AND p.PaymentStatus = 'Completed' THEN 'Shipped'
        ELSE 'Requires Review'
    END AS OrderHealthStatus
FROM ORDERS o
INNER JOIN PAYMENTS p ON o.OrderID = p.OrderID
INNER JOIN SHIPPING s ON o.OrderID = s.OrderID
WHERE o.OrderStatus != 'Canceled'
ORDER BY o.OrderDate DESC;

-- =============================================
-- Query 2: Incomplete Orders Requiring Attention
-- Business Value: Identifies orders with status mismatches or pending operations
-- =============================================
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    o.OrderStatus,
    p.PaymentStatus,
    s.ShippingStatus,
    o.TotalAmount,
    COUNT(oi.OrderItemID) AS ItemCount
FROM ORDERS o
INNER JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
INNER JOIN PAYMENTS p ON o.OrderID = p.OrderID
INNER JOIN SHIPPING s ON o.OrderID = s.OrderID
LEFT JOIN ORDER_ITEMS oi ON o.OrderID = oi.OrderID
WHERE o.OrderStatus != 'Delivered' 
   OR p.PaymentStatus != 'Completed'
   OR s.ShippingStatus != 'Delivered'
GROUP BY o.OrderID, o.OrderDate, c.FirstName, c.LastName, o.OrderStatus, 
         p.PaymentStatus, s.ShippingStatus, o.TotalAmount
ORDER BY o.OrderDate DESC;

-- =============================================
-- Query 3: Payment Status Analysis
-- Business Value: Tracks payment collection and identifies failed/pending transactions
-- =============================================
SELECT 
    p.PaymentID,
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    p.PaymentMethod,
    p.PaymentAmount,
    p.PaymentStatus,
    p.PaymentDate,
    CASE 
        WHEN p.PaymentStatus = 'Completed' THEN 'Success'
        WHEN p.PaymentStatus = 'Pending' THEN 'Awaiting Payment'
        WHEN p.PaymentStatus = 'Failed' THEN 'Action Required'
        WHEN p.PaymentStatus = 'Refunded' THEN 'Refunded'
        ELSE 'Unknown'
    END AS PaymentHealthStatus,
    SYSDATE - p.PaymentDate AS DaysPending
FROM PAYMENTS p
INNER JOIN ORDERS o ON p.OrderID = o.OrderID
INNER JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
ORDER BY p.PaymentDate DESC;

-- =============================================
-- Query 4: Shipping Status Tracking
-- Business Value: Monitors delivery progress and identifies delayed shipments
-- =============================================
SELECT 
    s.ShippingID,
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    s.ShippingAddress,
    s.ShippingCity,
    s.ShippingState,
    s.TrackingNumber,
    s.ShippingDate,
    s.EstimatedDeliveryDate,
    s.ActualDeliveryDate,
    s.ShippingStatus,
    CASE 
        WHEN s.ShippingStatus = 'Delivered' THEN 'Complete'
        WHEN s.ShippingStatus = 'In Transit' AND s.EstimatedDeliveryDate < SYSDATE THEN 'DELAYED'
        WHEN s.ShippingStatus = 'In Transit' THEN 'On Track'
        WHEN s.ShippingStatus = 'Processing' THEN 'Preparing'
        ELSE 'Unknown'
    END AS ShippingHealthStatus,
    CASE 
        WHEN s.ActualDeliveryDate IS NOT NULL THEN (s.ActualDeliveryDate - s.ShippingDate)
        ELSE (SYSDATE - s.ShippingDate)
    END AS DaysInShipping
FROM SHIPPING s
INNER JOIN ORDERS o ON s.OrderID = o.OrderID
INNER JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
ORDER BY s.ShippingDate DESC;

-- =============================================
-- Query 5: Order Fulfillment Time Analysis
-- Business Value: Measures order-to-delivery cycle time for performance metrics
-- =============================================
SELECT 
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    p.PaymentDate,
    s.ShippingDate,
    s.ActualDeliveryDate,
    (p.PaymentDate - o.OrderDate) AS PaymentProcessingTime,
    (s.ShippingDate - p.PaymentDate) AS PreparationTime,
    (s.ActualDeliveryDate - s.ShippingDate) AS DeliveryTime,
    (s.ActualDeliveryDate - o.OrderDate) AS TotalFulfillmentTime
FROM ORDERS o
INNER JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
INNER JOIN PAYMENTS p ON o.OrderID = p.OrderID
INNER JOIN SHIPPING s ON o.OrderID = s.OrderID
WHERE s.ActualDeliveryDate IS NOT NULL
ORDER BY TotalFulfillmentTime DESC;

-- =============================================
-- Query 6: Orders with Discrepancies Requiring Investigation
-- Business Value: Highlights anomalies for quality assurance investigation
-- =============================================
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    o.TotalAmount,
    p.PaymentAmount,
    CASE 
        WHEN o.TotalAmount != p.PaymentAmount THEN 'AMOUNT MISMATCH'
        ELSE 'Amount OK'
    END AS AmountStatus,
    o.OrderStatus,
    p.PaymentStatus,
    s.ShippingStatus,
    CASE 
        WHEN o.OrderStatus = 'Canceled' AND p.PaymentStatus = 'Completed' THEN 'Refund Required'
        WHEN o.OrderStatus = 'Canceled' AND p.PaymentStatus != 'Refunded' THEN 'Payment Issue'
        WHEN p.PaymentStatus = 'Failed' AND o.OrderStatus != 'Pending' THEN 'Status Mismatch'
        ELSE 'OK'
    END AS RequiredAction
FROM ORDERS o
INNER JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
INNER JOIN PAYMENTS p ON o.OrderID = p.OrderID
INNER JOIN SHIPPING s ON o.OrderID = s.OrderID
WHERE (o.TotalAmount != p.PaymentAmount)
   OR (o.OrderStatus = 'Canceled' AND p.PaymentStatus != 'Refunded')
   OR (p.PaymentStatus = 'Failed' AND o.OrderStatus != 'Pending')
ORDER BY o.OrderDate DESC;

COMMIT;
