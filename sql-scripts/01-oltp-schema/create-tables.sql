-- =============================================
-- ShopNow E-Commerce Database - OLTP Schema
-- File: create-tables.sql
-- Purpose: Create all OLTP tables with constraints
-- Author: Your Name
-- Date: November 2025
-- =============================================

-- Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE SHIPPING CASCADE CONSTRAINTS;
DROP TABLE PAYMENTS CASCADE CONSTRAINTS;
DROP TABLE ORDERITEMS CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE PRODUCTS CASCADE CONSTRAINTS;
DROP TABLE SUPPLIERS CASCADE CONSTRAINTS;
DROP TABLE CATEGORIES CASCADE CONSTRAINTS;
DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;

-- =============================================
-- Table 1: CUSTOMERS
-- Description: Stores customer information
-- =============================================
CREATE TABLE CUSTOMERS (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100) NOT NULL UNIQUE,
    Phone VARCHAR2(15),
    Address VARCHAR2(200),
    City VARCHAR2(50),
    State VARCHAR2(2),
    PostalCode VARCHAR2(10),
    Country VARCHAR2(50),
    CreatedDate DATE NOT NULL,
    ModifiedDate DATE
);

-- =============================================
-- Table 2: CATEGORIES
-- Description: Product category classification
-- =============================================
CREATE TABLE CATEGORIES (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR2(100) NOT NULL UNIQUE,
    Description VARCHAR2(500),
    IsActive CHAR(1) NOT NULL CHECK (IsActive IN ('Y', 'N'))
);

-- =============================================
-- Table 3: SUPPLIERS
-- Description: Supplier contact information
-- =============================================
CREATE TABLE SUPPLIERS (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR2(150) NOT NULL,
    ContactName VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100),
    Phone VARCHAR2(15),
    Address VARCHAR2(200),
    City VARCHAR2(50),
    State VARCHAR2(2),
    PostalCode VARCHAR2(10),
    Country VARCHAR2(50),
    IsActive CHAR(1) NOT NULL CHECK (IsActive IN ('Y', 'N'))
);

-- =============================================
-- Table 4: PRODUCTS
-- Description: Product catalog with inventory
-- =============================================
CREATE TABLE PRODUCTS (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR2(150) NOT NULL,
    Description VARCHAR2(1000),
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL,
    ReorderLevel INT,
    CreatedDate DATE NOT NULL,
    ModifiedDate DATE,
    CONSTRAINT FK_PRODUCTS_CATEGORY FOREIGN KEY (CategoryID) REFERENCES CATEGORIES(CategoryID),
    CONSTRAINT FK_PRODUCTS_SUPPLIER FOREIGN KEY (SupplierID) REFERENCES SUPPLIERS(SupplierID)
);

-- =============================================
-- Table 5: ORDERS
-- Description: Customer order transactions
-- =============================================
CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR2(20) NOT NULL CHECK (OrderStatus IN ('Pending', 'Processing', 'Shipped', 'Delivered')),
    TotalAmount DECIMAL(12, 2) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedDate DATE,
    CONSTRAINT FK_ORDERS_CUSTOMER FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);

-- =============================================
-- Table 6: ORDERITEMS
-- Description: Line items within orders
-- =============================================
CREATE TABLE ORDERITEMS (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    LineTotal DECIMAL(12, 2) NOT NULL,
    CONSTRAINT FK_ORDERITEMS_ORDER FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    CONSTRAINT FK_ORDERITEMS_PRODUCT FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID)
);

-- =============================================
-- Table 7: PAYMENTS
-- Description: Payment processing records
-- =============================================
CREATE TABLE PAYMENTS (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    PaymentMethod VARCHAR2(20) NOT NULL CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'PayPal')),
    PaymentAmount DECIMAL(12, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentStatus VARCHAR2(20) NOT NULL CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    TransactionID VARCHAR2(50),
    CONSTRAINT FK_PAYMENTS_ORDER FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);

-- =============================================
-- Table 8: SHIPPING
-- Description: Delivery and tracking information
-- =============================================
CREATE TABLE SHIPPING (
    ShippingID INT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    ShippingAddress VARCHAR2(200) NOT NULL,
    ShippingCity VARCHAR2(50) NOT NULL,
    ShippingState VARCHAR2(2) NOT NULL,
    ShippingPostalCode VARCHAR2(10) NOT NULL,
    ShippingCountry VARCHAR2(50) NOT NULL,
    TrackingNumber VARCHAR2(50),
    ShippingDate DATE NOT NULL,
    EstimatedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    ShippingStatus VARCHAR2(20) NOT NULL CHECK (ShippingStatus IN ('Processing', 'In Transit', 'Delivered')),
    CONSTRAINT FK_SHIPPING_ORDER FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);

-- =============================================
-- Verification Query
-- =============================================
SELECT 
    'CUSTOMERS' AS TableName, COUNT(*) AS RecordCount FROM CUSTOMERS
UNION ALL
SELECT 'CATEGORIES', COUNT(*) FROM CATEGORIES
UNION ALL
SELECT 'SUPPLIERS', COUNT(*) FROM SUPPLIERS
UNION ALL
SELECT 'PRODUCTS', COUNT(*) FROM PRODUCTS
UNION ALL
SELECT 'ORDERS', COUNT(*) FROM ORDERS
UNION ALL
SELECT 'ORDERITEMS', COUNT(*) FROM ORDERITEMS
UNION ALL
SELECT 'PAYMENTS', COUNT(*) FROM PAYMENTS
UNION ALL
SELECT 'SHIPPING', COUNT(*) FROM SHIPPING;

COMMIT;
