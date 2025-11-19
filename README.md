# ShopNow E-Commerce Database Management System

A comprehensive database management project demonstrating OLTP and OLAP system design, implementation, and analytics for an e-commerce platform.

![Database Architecture](https://img.shields.io/badge/Database-Oracle%2026ai-red)
![Schema](https://img.shields.io/badge/Schema-3NF%20%7C%20Star-blue)
![Status](https://img.shields.io/badge/Status-Complete-green)

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Database Architecture](#database-architecture)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Installation & Setup](#installation--setup)
- [Usage Examples](#usage-examples)
- [Data Model](#data-model)
- [ETL Process](#etl-process)
- [Analytics & Reporting](#analytics--reporting)
- [Future Enhancements](#future-enhancements)

## 🎯 Project Overview

ShopNow is an enterprise-level e-commerce database management system designed to handle both transactional (OLTP) and analytical (OLAP) workloads. The project demonstrates end-to-end database design, normalization, dimensional modeling, ETL processes, and business intelligence capabilities.

### Business Context
This system supports a multi-category e-commerce platform managing:
- Customer transactions and order processing
- Product catalog with multiple suppliers
- Payment processing and order fulfillment
- Inventory management
- Business analytics and reporting

## ✨ Key Features

### OLTP (Online Transaction Processing)
- **Normalized 3NF Database Design** with 8 interconnected tables
- **Referential Integrity** with foreign key constraints
- **Data Validation** using CHECK constraints
- **Performance Optimization** through strategic indexing
- **Transaction Management** for order processing

### OLAP (Online Analytical Processing)
- **Star Schema Design** with fact and dimension tables
- **ETL Pipeline** for data transformation
- **Multi-dimensional Data Cubes** for analytics
- **Business Intelligence Queries** for decision support
- **Time-based Analysis** with comprehensive date dimensions

## 🏗️ Database Architecture

### OLTP Schema (3NF)
```
CUSTOMERS ──┐
            ├──> ORDERS ──┬──> ORDERITEMS ──> PRODUCTS ──┬──> CATEGORIES
            │            ├──> PAYMENTS                    └──> SUPPLIERS
            │            └──> SHIPPING
```

**8 Normalized Tables:**
1. **CUSTOMERS** - Customer information and demographics
2. **CATEGORIES** - Product category hierarchy
3. **SUPPLIERS** - Supplier contact and location data
4. **PRODUCTS** - Product catalog with inventory
5. **ORDERS** - Order transactions
6. **ORDERITEMS** - Line items within orders
7. **PAYMENTS** - Payment processing records
8. **SHIPPING** - Delivery and tracking information

### OLAP Schema (Star)
```
                    DimTime
                       │
        DimCustomer ───┤
                       │
         DimProduct ───┼──> FactSales
                       │
        DimCategory ───┤
                       │
        DimSupplier ───┤
                       │
    DimPaymentMethod ──┘
```

**Dimensional Model:**
- **1 Fact Table:** FactSales (measures and foreign keys)
- **6 Dimension Tables:** Time, Customer, Product, Category, Supplier, PaymentMethod

## 🛠️ Technologies Used

- **Database Management System:** Oracle 23ai
- **SQL Standards:** Oracle PL/SQL
- **Modeling Tools:** Draw.io (ERD diagrams)
- **Data Warehousing:** Star Schema, ETL processes
- **Business Intelligence:** Data cubes, OLAP queries
- **Version Control:** Git/GitHub

## 📁 Project Structure

```
shopnow-ecommerce-database/
│
├── README.md
├── LICENSE
│
├── documentation/
│   ├── project-report.pdf
│   ├── presentation.pdf
│   └── annotated-bibliography.pdf
│
├── diagrams/
│   ├── ERD-Diagram.pdf
│   ├── Star-Schema.pdf
│   └── ETL-Workflow.pdf
│
├── sql-scripts/
│   ├── 01-oltp-schema/
│   │   ├── create-tables.sql
│   │   ├── create-indexes.sql
│   │   └── insert-sample-data.sql
│   │
│   ├── 02-oltp-queries/
│   │   ├── customer-analytics.sql
│   │   ├── product-performance.sql
│   │   ├── order-verification.sql
│   │   └── join-demonstrations.sql
│   │
│   ├── 03-olap-schema/
│   │   ├── create-dimensions.sql
│   │   ├── create-fact-table.sql
│   │   └── etl-load-data.sql
│   │
│   └── 04-olap-analytics/
│       ├── create-data-cubes.sql
│       └── analytical-queries.sql
│
└── data/
    └── sample-data-description.md
```

## 🚀 Installation & Setup

### Prerequisites
- Oracle Database 23ai or compatible version
- Oracle SQL Developer or SQL*Plus
- Minimum 2GB disk space for data

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/shopnow-ecommerce-database.git
cd shopnow-ecommerce-database
```

### Step 2: Create OLTP Schema
```sql
-- Connect to Oracle database
sqlplus username/password@database

-- Execute DDL scripts
@sql-scripts/01-oltp-schema/create-tables.sql
@sql-scripts/01-oltp-schema/create-indexes.sql
```

### Step 3: Load Sample Data
```sql
-- Insert test data
@sql-scripts/01-oltp-schema/insert-sample-data.sql
COMMIT;
```

### Step 4: Create OLAP Schema
```sql
-- Create dimension tables
@sql-scripts/03-olap-schema/create-dimensions.sql

-- Create fact table
@sql-scripts/03-olap-schema/create-fact-table.sql
```

### Step 5: Run ETL Process
```sql
-- Load data into data warehouse
@sql-scripts/03-olap-schema/etl-load-data.sql
```

### Step 6: Create Analytics Views
```sql
-- Create data cubes
@sql-scripts/04-olap-analytics/create-data-cubes.sql
```

## 💡 Usage Examples

### Query 1: Customer Purchase History
```sql
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalRevenue
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalRevenue DESC;
```

### Query 2: Sales Analysis by Time
```sql
SELECT 
    dt.Year,
    dt.Quarter,
    dt.MonthName,
    SUM(fs.TotalSalesAmount) AS TotalRevenue,
    COUNT(DISTINCT fs.SaleID) AS OrderCount
FROM FactSales fs
INNER JOIN DimTime dt ON fs.TimeKeyDate = dt.TimeKey
GROUP BY dt.Year, dt.Quarter, dt.MonthName
ORDER BY dt.Year, dt.Quarter;
```

### Query 3: Top Performing Products
```sql
SELECT 
    dp.ProductName,
    dcat.CategoryName,
    SUM(fs.QuantitySold) AS TotalQuantitySold,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM FactSales fs
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
INNER JOIN DimCategory dcat ON fs.CategoryKey = dcat.CategoryKey
GROUP BY dp.ProductName, dcat.CategoryName
ORDER BY TotalRevenue DESC
FETCH FIRST 10 ROWS ONLY;
```

## 📊 Data Model

### OLTP Tables

#### CUSTOMERS
| Column | Type | Constraints |
|--------|------|-------------|
| CustomerID | INT | PRIMARY KEY |
| FirstName | VARCHAR2(50) | NOT NULL |
| LastName | VARCHAR2(50) | NOT NULL |
| Email | VARCHAR2(100) | NOT NULL, UNIQUE |
| Phone | VARCHAR2(15) | |
| Address | VARCHAR2(200) | |
| City | VARCHAR2(50) | |
| State | VARCHAR2(2) | |
| PostalCode | VARCHAR2(10) | |
| Country | VARCHAR2(50) | |
| CreatedDate | DATE | NOT NULL |
| ModifiedDate | DATE | |

#### PRODUCTS
| Column | Type | Constraints |
|--------|------|-------------|
| ProductID | INT | PRIMARY KEY |
| ProductName | VARCHAR2(150) | NOT NULL |
| Description | VARCHAR2(1000) | |
| CategoryID | INT | FOREIGN KEY → CATEGORIES |
| SupplierID | INT | FOREIGN KEY → SUPPLIERS |
| UnitPrice | DECIMAL(10,2) | NOT NULL |
| QuantityInStock | INT | NOT NULL |
| ReorderLevel | INT | |
| CreatedDate | DATE | NOT NULL |
| ModifiedDate | DATE | |

*See [complete data dictionary](documentation/data-dictionary.md) for all table structures*

### OLAP Dimensions

#### DimTime
- Comprehensive date dimension with year, quarter, month, week attributes
- Business calendar support with weekday/weekend flags
- Seasonal categorization

#### DimCustomer
- Customer segmentation (Platinum, Gold, Silver, Bronze)
- Geographic dimensions (City, State)
- Demographic attributes

#### DimProduct
- Product hierarchy
- Pricing information
- Category linkage

## 🔄 ETL Process

### Extract Phase
- Source data from 8 OLTP tables
- Validate referential integrity
- Handle null values and data quality issues

### Transform Phase
1. **Date Dimension Generation**
   - Create comprehensive date range (2023-2025)
   - Calculate derived attributes (quarter, week, season)

2. **Customer Segmentation**
   - Calculate total customer spend
   - Assign segment based on revenue thresholds

3. **Surrogate Key Assignment**
   - Generate sequential keys for all dimensions
   - Map business keys to surrogate keys

### Load Phase
- Populate dimension tables first
- Load fact table with foreign key lookups
- Validate row counts and data consistency
- Create indexes for query optimization

## 📈 Analytics & Reporting

### Data Cubes

#### 1. Sales Performance Cube
**Dimensions:** Time, Product, Category  
**Measures:** Revenue, Quantity, Order Count, Unique Customers

#### 2. Customer Behavior Cube
**Dimensions:** Time, Customer Segment, Geography, Payment Method  
**Measures:** Transaction Count, Revenue, Average Transaction Value

#### 3. Supplier Performance Cube
**Dimensions:** Time, Supplier, Product, Order Status  
**Measures:** Orders Processed, Delivery Success Rate, Revenue

### Sample Analytical Queries

See [analytical-queries.sql](sql-scripts/04-olap-analytics/analytical-queries.sql) for:
- Time-based trend analysis
- Customer segmentation analysis
- Product performance metrics
- Category contribution analysis
- Supplier reliability metrics
- Payment method preferences

## 🎓 Key Learnings

This project demonstrates proficiency in:
- Database normalization (1NF → 2NF → 3NF)
- Entity-relationship modeling
- SQL DDL and DML operations
- Complex JOIN operations (INNER, LEFT, RIGHT, FULL OUTER)
- Transaction management (ACID properties)
- Dimensional modeling (Kimball methodology)
- ETL pipeline development
- Performance optimization through indexing
- Business intelligence and analytics
- Data warehouse design patterns

## 🔮 Future Enhancements

- [ ] Implement incremental ETL for real-time updates
- [ ] Add slowly changing dimension (SCD) Type 2 support
- [ ] Create aggregate tables for faster query performance
- [ ] Implement data quality checks and error handling
- [ ] Add partitioning strategy for large fact tables
- [ ] Develop REST API for data access
- [ ] Create interactive dashboards using Tableau/Power BI
- [ ] Implement data archival and purging strategy
- [ ] Add security with row-level access control
- [ ] Integrate machine learning for predictive analytics


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

⭐ **If you find this project useful, please consider giving it a star!**

**Keywords:** Database Design, Oracle, SQL, Data Warehousing, ETL, OLTP, OLAP, Star Schema, Business Intelligence, E-Commerce, Analytics
