-- =============================================
-- ShopNow E-Commerce Database - OLAP Dimension Tables
-- File: create-dimensions.sql
-- Purpose: Create dimension tables for star schema
-- Author: Your Name
-- Date: November 2025
-- =============================================

-- Drop existing tables if they exist
DROP TABLE FactSales CASCADE CONSTRAINTS;
DROP TABLE DimPaymentMethod CASCADE CONSTRAINTS;
DROP TABLE DimSupplier CASCADE CONSTRAINTS;
DROP TABLE DimCategory CASCADE CONSTRAINTS;
DROP TABLE DimProduct CASCADE CONSTRAINTS;
DROP TABLE DimCustomer CASCADE CONSTRAINTS;
DROP TABLE DimTime CASCADE CONSTRAINTS;

-- =============================================
-- Dimension 1: DimTime
-- Description: Comprehensive date dimension
-- =============================================
CREATE TABLE DimTime (
    TimeKey INT PRIMARY KEY,
    DateValue DATE NOT NULL UNIQUE,
    Year INT NOT NULL,
    Quarter VARCHAR2(2) NOT NULL,
    Month INT NOT NULL,
    MonthName VARCHAR2(15) NOT NULL,
    Day INT NOT NULL,
    DayOfWeek INT NOT NULL,
    DayName VARCHAR2(15) NOT NULL,
    WeekOfYear INT NOT NULL,
    IsWeekend CHAR(1) NOT NULL,
    Season VARCHAR2(10) NOT NULL
);

-- =============================================
-- Dimension 2: DimCustomer
-- Description: Customer dimension with segmentation
-- =============================================
CREATE TABLE DimCustomer (
    CustomerKey INT PRIMARY KEY,
    CustomerID INT NOT NULL UNIQUE,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100),
    Phone VARCHAR2(20),
    City VARCHAR2(50),
    State VARCHAR2(20),
    CustomerSegment VARCHAR2(20)
);

-- =============================================
-- Dimension 3: DimProduct
-- Description: Product dimension
-- =============================================
CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY,
    ProductID INT NOT NULL UNIQUE,
    ProductName VARCHAR2(200) NOT NULL,
    UnitPrice DECIMAL(10, 2),
    CategoryID INT
);

-- =============================================
-- Dimension 4: DimCategory
-- Description: Category dimension
-- =============================================
CREATE TABLE DimCategory (
    CategoryKey INT PRIMARY KEY,
    CategoryID INT NOT NULL UNIQUE,
    CategoryName VARCHAR2(100) NOT NULL
);

-- =============================================
-- Dimension 5: DimSupplier
-- Description: Supplier dimension
-- =============================================
CREATE TABLE DimSupplier (
    SupplierKey INT PRIMARY KEY,
    SupplierID INT NOT NULL UNIQUE,
    SupplierName VARCHAR2(150) NOT NULL,
    Email VARCHAR2(100),
    Phone VARCHAR2(20)
);

-- =============================================
-- Dimension 6: DimPaymentMethod
-- Description: Payment method dimension
-- =============================================
CREATE TABLE DimPaymentMethod (
    PaymentMethodKey INT PRIMARY KEY,
    PaymentMethod VARCHAR2(50) NOT NULL UNIQUE
);

COMMIT;
