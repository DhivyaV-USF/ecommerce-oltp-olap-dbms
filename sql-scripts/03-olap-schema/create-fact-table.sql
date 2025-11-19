-- =============================================
-- ShopNow E-Commerce Database - Fact Table
-- File: create-fact-table.sql
-- Purpose: Create central fact table for star schema
-- Author: Your Name
-- Date: November 2025
-- =============================================

-- =============================================
-- Fact Table: FactSales
-- Description: Central fact table with measures
-- =============================================
CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY,
    TimeKeyDate INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    CategoryKey INT NOT NULL,
    SupplierKey INT NOT NULL,
    PaymentMethodKey INT NOT NULL,
    OrderID INT NOT NULL,
    OrderItemID INT NOT NULL,
    QuantitySold INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    SalesAmount DECIMAL(12, 2) NOT NULL,
    TotalSalesAmount DECIMAL(12, 2) NOT NULL,
    OrderStatus VARCHAR2(50),
    PaymentStatus VARCHAR2(50),
    ShippingStatus VARCHAR2(50),
    CONSTRAINT FK_FACTSALES_TIME FOREIGN KEY (TimeKeyDate) REFERENCES DimTime(TimeKey),
    CONSTRAINT FK_FACTSALES_CUSTOMER FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT FK_FACTSALES_PRODUCT FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    CONSTRAINT FK_FACTSALES_CATEGORY FOREIGN KEY (CategoryKey) REFERENCES DimCategory(CategoryKey),
    CONSTRAINT FK_FACTSALES_SUPPLIER FOREIGN KEY (SupplierKey) REFERENCES DimSupplier(SupplierKey),
    CONSTRAINT FK_FACTSALES_PAYMENT FOREIGN KEY (PaymentMethodKey) REFERENCES DimPaymentMethod(PaymentMethodKey)
);

-- Create indexes on fact table foreign keys
CREATE INDEX IDX_FACTSALES_TIMEKEY ON FactSales(TimeKeyDate);
CREATE INDEX IDX_FACTSALES_CUSTOMERKEY ON FactSales(CustomerKey);
CREATE INDEX IDX_FACTSALES_PRODUCTKEY ON FactSales(ProductKey);
CREATE INDEX IDX_FACTSALES_CATEGORYKEY ON FactSales(CategoryKey);
CREATE INDEX IDX_FACTSALES_SUPPLIERKEY ON FactSales(SupplierKey);
CREATE INDEX IDX_FACTSALES_PAYMENTKEY ON FactSales(PaymentMethodKey);

COMMIT;