-- =============================================
-- ShopNow E-Commerce Database - Performance Indexes
-- File: create-indexes.sql
-- Purpose: Create indexes for query optimization
-- Author: Your Name
-- Date: November 2025
-- =============================================

-- Create indexes on foreign key columns for join performance
CREATE INDEX IDX_ORDERS_CUSTOMERID ON ORDERS(CustomerID);
CREATE INDEX IDX_ORDERS_ORDERDATE ON ORDERS(OrderDate);
CREATE INDEX IDX_PRODUCTS_CATEGORYID ON PRODUCTS(CategoryID);
CREATE INDEX IDX_PRODUCTS_SUPPLIERID ON PRODUCTS(SupplierID);
CREATE INDEX IDX_ORDERITEMS_ORDERID ON ORDERITEMS(OrderID);
CREATE INDEX IDX_ORDERITEMS_PRODUCTID ON ORDERITEMS(ProductID);
CREATE INDEX IDX_PAYMENTS_ORDERID ON PAYMENTS(OrderID);
CREATE INDEX IDX_SHIPPING_ORDERID ON SHIPPING(OrderID);

-- Composite index for common search patterns
CREATE INDEX IDX_ORDERS_STATUS_DATE ON ORDERS(OrderStatus, OrderDate);
CREATE INDEX IDX_PRODUCTS_CATEGORY_PRICE ON PRODUCTS(CategoryID, UnitPrice);

COMMIT;