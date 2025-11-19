--sql--
-- Insert data into CUSTOMERS
INSERT INTO CUSTOMERS VALUES (1, 'John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001', 'USA', SYSDATE, NULL);
INSERT INTO CUSTOMERS VALUES (2, 'Sarah', 'Johnson', 'sarah.johnson@email.com', '555-0102', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA', SYSDATE, NULL);
--SELECT * FROM CUSTOMERS;

--sql--
-- Insert data into CATEGORIES
INSERT INTO CATEGORIES VALUES (1, 'Electronics', 'Electronic devices and gadgets', 'Y');
INSERT INTO CATEGORIES VALUES (2, 'Clothing', 'Apparel and fashion items', 'Y');
select * from CATEGORIES;

--sql--
-- Insert data into SUPPLIERS
INSERT INTO SUPPLIERS VALUES (1, 'Tech Supplies Inc', 'Mike Chen', 'contact@techsupplies.com', '555-5001', '789 Tech Park', 'San Jose', 'CA', '95110', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (2, 'Fashion Wholesale Ltd', 'Emma Davis', 'sales@fashionwholesale.com', '555-5002', '321 Fashion Blvd', 'New York', 'NY', '10002', 'USA', 'Y');
select * from SUPPLIERS;

--sql--
-- Insert data into PRODUCTS
INSERT INTO PRODUCTS VALUES (1, 'Laptop Pro 15', 'High-performance 15-inch laptop with Intel i7', 1, 1, 1299.99, 45, 10, SYSDATE-60, SYSDATE-5);
INSERT INTO PRODUCTS VALUES (2, 'Wireless Bluetooth Mouse', 'Ergonomic wireless mouse with 2-year battery', 1, 1, 34.99, 250, 50, SYSDATE-55, SYSDATE-3);
INSERT INTO PRODUCTS VALUES (3, 'Premium Cotton T-Shirt', '100% organic cotton comfortable t-shirt', 2, 2, 24.99, 320, 80, SYSDATE-45, SYSDATE-1);
select * from PRODUCTS;

-- Insert data into ORDERS
--sql--
INSERT INTO ORDERS VALUES (1, 1, SYSDATE-40, 'Delivered', 1349.97, SYSDATE-40, SYSDATE-35);
INSERT INTO ORDERS VALUES (2, 2, SYSDATE-38, 'Delivered', 1429.97, SYSDATE-38, SYSDATE-30);
select * from ORDERS;

--sql--
-- Insert data into ORDER_ITEMS
INSERT INTO ORDER_ITEMS VALUES (1, 1, 1, 1, 1299.99, 1299.99);
INSERT INTO ORDER_ITEMS VALUES (2, 1, 2, 1, 34.99, 34.99);
INSERT INTO ORDER_ITEMS VALUES (3, 2, 1, 1, 1299.99, 1299.99);
select * from ORDER_ITEMS;

--sql—
-- Insert data into PAYMENTS
INSERT INTO PAYMENTS VALUES (1, 1, 'Credit Card', 1349.97, SYSDATE-40, 'Completed', 'TXN001234567');
INSERT INTO PAYMENTS VALUES (2, 2, 'Credit Card', 1429.97, SYSDATE-38, 'Completed', 'TXN001234568');
select * from PAYMENTS;

--sql--
-- Insert data into SHIPPING
INSERT INTO SHIPPING VALUES (1, 1, '123 Main St', 'New York', 'NY', '10001', 'USA', 'TRACK001', SYSDATE-40, SYSDATE-37, SYSDATE-35, 'Delivered');
INSERT INTO SHIPPING VALUES (2, 2, '789 Pine Road', 'Chicago', 'IL', '60601', 'USA', 'TRACK003', SYSDATE-35, SYSDATE-32, NULL, 'In Transit');
select * from SHIPPING;

--sql--
-- COMMIT CHANGES
COMMIT;


--Customers Table Records Insertion
--sql—
-- 1. INSERT CUSTOMERS (12 records)
INSERT INTO CUSTOMERS VALUES (3, 'Michael', 'Brown', 'michael.brown@email.com', '555-0103', '789 Pine Road', 'Chicago', 'IL', '60601', 'USA', SYSDATE-40, SYSDATE-8);
INSERT INTO CUSTOMERS VALUES (4, 'Emily', 'Davis', 'emily.davis@email.com', '555-0104', '321 Elm Street', 'Houston', 'TX', '77001', 'USA', SYSDATE-35, SYSDATE-3);
INSERT INTO CUSTOMERS VALUES (5, 'Robert', 'Wilson', 'robert.wilson@email.com', '555-0105', '654 Maple Drive', 'Phoenix', 'AZ', '85001', 'USA', SYSDATE-30, SYSDATE-2);
INSERT INTO CUSTOMERS VALUES (6, 'Jessica', 'Martinez', 'jessica.martinez@email.com', '555-0106', '987 Cedar Lane', 'Philadelphia', 'PA', '19101', 'USA', SYSDATE-25, SYSDATE-1);
INSERT INTO CUSTOMERS VALUES (7, 'David', 'Garcia', 'david.garcia@email.com', '555-0107', '147 Birch Court', 'San Antonio', 'TX', '78201', 'USA', SYSDATE-20, NULL);
INSERT INTO CUSTOMERS VALUES (8, 'Amanda', 'Rodriguez', 'amanda.rodriguez@email.com', '555-0108', '258 Spruce Way', 'San Diego', 'CA', '92101', 'USA', SYSDATE-15, NULL);
INSERT INTO CUSTOMERS VALUES (9, 'Christopher', 'Lee', 'christopher.lee@email.com', '555-0109', '369 Walnut Street', 'Dallas', 'TX', '75201', 'USA', SYSDATE-12, SYSDATE-1);
INSERT INTO CUSTOMERS VALUES (10, 'Michelle', 'White', 'michelle.white@email.com', '555-0110', '741 Hickory Path', 'San Jose', 'CA', '95101', 'USA', SYSDATE-10, NULL);
INSERT INTO CUSTOMERS VALUES (11, 'Daniel', 'Harris', 'daniel.harris@email.com', '555-0111', '852 Ash Boulevard', 'Austin', 'TX', '78701', 'USA', SYSDATE-8, SYSDATE-2);
INSERT INTO CUSTOMERS VALUES (12, 'Lauren', 'Clark', 'lauren.clark@email.com', '555-0112', '963 Oak Terrace', 'Jacksonville', 'FL', '32099', 'USA', SYSDATE-5, NULL);
 
--  Count of number of rows insertion:
SELECT COUNT(*) as CUSTOMERS_COUNT FROM CUSTOMERS;

--Categories Table Records Insertion
--sql--
-- 2. INSERT CATEGORIES (10 records)
INSERT INTO CATEGORIES VALUES (3, 'Home and Garden', 'Furniture, decor, and gardening supplies', 'N');
INSERT INTO CATEGORIES VALUES (4, 'Books', 'Books in various genres and formats', 'Y');
INSERT INTO CATEGORIES VALUES (5, 'Sports and Outdoors', 'Sports equipment and outdoor gear', 'Y');
INSERT INTO CATEGORIES VALUES (6, 'Beauty and Personal Care', 'Cosmetics, skincare, and personal hygiene', 'Y');
INSERT INTO CATEGORIES VALUES (7, 'Toys and Games', 'Toys, board games, and video games', 'Y');
INSERT INTO CATEGORIES VALUES (8, 'Food and Beverages', 'Groceries, snacks, and beverages', 'N');
INSERT INTO CATEGORIES VALUES (9, 'Health and Wellness', 'Vitamins, supplements, and fitness products', 'Y');
INSERT INTO CATEGORIES VALUES (10, 'Automotive', 'Car accessories and automotive parts', 'Y');
 
--  Query to count the number of rows insertion:
SELECT COUNT(*) as CATEGORIES_COUNT FROM CATEGORIES;

--Suppliers Table Records Insertion
--sql--
-- 3. INSERT SUPPLIERS (12 records)
INSERT INTO SUPPLIERS VALUES (3, 'Home Essentials Co', 'James Wilson', 'orders@homeessentials.com', '555-5003', '456 Furniture Ave', 'Los Angeles', 'CA', '90001', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (4, 'Global Books Publishing', 'Rebecca Thompson', 'dist@globalbooks.com', '555-5004', '654 Library Lane', 'Boston', 'MA', '02101', 'USA', 'N');
INSERT INTO SUPPLIERS VALUES (5, 'Sports and Outdoor Gear', 'Kevin Martinez', 'sales@sportsoutdoor.com', '555-5005', '987 Athletic Way', 'Denver', 'CO', '80201', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (6, 'Beauty World Distributors', 'Sophia Johnson', 'wholesale@beautyworld.com', '555-5006', '147 Beauty Boulevard', 'Miami', 'FL', '33101', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (7, 'Toy Kingdom Inc', 'Lucas Brown', 'bulk@toykingdom.com', '555-5007', '258 Playhouse Street', 'Atlanta', 'GA', '30301', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (8, 'Fresh Foods Wholesale', 'Maria Garcia', 'supplier@freshfoods.com', '555-5008', '369 Market Road', 'Chicago', 'IL', '60601', 'USA', 'N');
INSERT INTO SUPPLIERS VALUES (9, 'Wellness and Health Pro', 'Daniel Lee', 'sales@wellnesshealth.com', '555-5009', '741 Medical Drive', 'Houston', 'TX', '77001', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (10, 'Auto Parts Central', 'Robert Anderson', 'orders@autopartscentral.com', '555-5010', '852 Motor Lane', 'Phoenix', 'AZ', '85001', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (11, 'Premium Electronics', 'Nina Patel', 'contact@premiumelectronics.com', '555-5011', '963 Circuit Street', 'Seattle', 'WA', '98101', 'USA', 'Y');
INSERT INTO SUPPLIERS VALUES (12, 'Casual Apparel Wholesale', 'Oliver King', 'wholesale@casualapparel.com', '555-5012', '159 Garment Avenue', 'Portland', 'OR', '97201', 'USA', 'N');
 
-- Query to count the number of rows insertion:
SELECT COUNT(*) as SUPPLIERS_COUNT FROM SUPPLIERS;

--Products Table Records Insertion
--sql--
-- 4. INSERT PRODUCTS (15 records)
INSERT INTO PRODUCTS VALUES (4, 'USB-C Hub Adapter', '7-in-1 USB-C hub with multiple ports', 1, 11, 49.99, 180, 40, SYSDATE-50, SYSDATE-2);
INSERT INTO PRODUCTS VALUES (5, 'Denim Jeans Blue', 'Classic blue denim jeans with stretch fit', 2, 12, 59.99, 210, 50, SYSDATE-40, NULL);
INSERT INTO PRODUCTS VALUES (6, 'Running Shoes Pro', 'Professional running shoes with gel cushioning', 2, 2, 129.99, 150, 30, SYSDATE-35, SYSDATE-4);
INSERT INTO PRODUCTS VALUES (7, 'Wooden Coffee Table', 'Modern wooden coffee table with storage', 3, 3, 249.99, 60, 15, SYSDATE-30, SYSDATE-6);
INSERT INTO PRODUCTS VALUES (8, 'LED Desk Lamp', 'Smart LED desk lamp with adjustable brightness', 3, 11, 39.99, 190, 40, SYSDATE-25, SYSDATE-2);
INSERT INTO PRODUCTS VALUES (9, 'Science Fiction Novel', 'Bestselling sci-fi novel hardcover edition', 4, 4, 19.99, 400, 100, SYSDATE-20, NULL);
INSERT INTO PRODUCTS VALUES (10, 'Yoga Mat Premium', 'Non-slip yoga mat with carrying strap', 5, 5, 44.99, 280, 60, SYSDATE-15, SYSDATE-3);
INSERT INTO PRODUCTS VALUES (11, 'Organic Face Serum', 'Natural organic anti-aging face serum', 6, 6, 54.99, 170, 40, SYSDATE-12, SYSDATE-1);
INSERT INTO PRODUCTS VALUES (12, 'Building Blocks Set', 'Educational building blocks for children', 7, 7, 29.99, 220, 50, SYSDATE-10, NULL);
INSERT INTO PRODUCTS VALUES (13, 'Organic Coffee Beans', 'Premium organic coffee beans 1kg', 8, 8, 18.99, 350, 100, SYSDATE-8, SYSDATE-2);
INSERT INTO PRODUCTS VALUES (14, 'Vitamin B12 Supplement', 'High-potency B12 vitamin supplement', 9, 9, 12.99, 400, 100, SYSDATE-5, SYSDATE-1);
INSERT INTO PRODUCTS VALUES (15, 'Car Phone Mount', 'Universal car phone holder with dashboard mount', 10, 10, 15.99, 300, 80, SYSDATE-3, NULL);
 
-- Query to count the number of rows insertion:
SELECT COUNT(*) as PRODUCTS_COUNT FROM PRODUCTS;

--Orders Table Records Insertion
--sql--
-- 5. INSERT ORDERS (13 records)
INSERT INTO ORDERS VALUES (3, 3, SYSDATE-35, 'Shipped', 384.97, SYSDATE-35, SYSDATE-32);
INSERT INTO ORDERS VALUES (4, 4, SYSDATE-30, 'Processing', 299.97, SYSDATE-30, NULL);
INSERT INTO ORDERS VALUES (5, 5, SYSDATE-28, 'Delivered', 204.97, SYSDATE-28, SYSDATE-15);
INSERT INTO ORDERS VALUES (6, 6, SYSDATE-25, 'Shipped', 129.99, SYSDATE-25, SYSDATE-20);
INSERT INTO ORDERS VALUES (7, 7, SYSDATE-20, 'Delivered', 1679.97, SYSDATE-20, SYSDATE-8);
INSERT INTO ORDERS VALUES (8, 8, SYSDATE-18, 'Processing', 554.97, SYSDATE-18, NULL);
INSERT INTO ORDERS VALUES (9, 9, SYSDATE-15, 'Delivered', 249.97, SYSDATE-15, SYSDATE-5);
INSERT INTO ORDERS VALUES (10, 10, SYSDATE-12, 'Shipped', 539.97, SYSDATE-12, SYSDATE-10);
INSERT INTO ORDERS VALUES (11, 11, SYSDATE-8, 'Processing', 334.98, SYSDATE-8, NULL);
INSERT INTO ORDERS VALUES (12, 12, SYSDATE-2, 'Pending', 1469.97, SYSDATE-2, NULL);
 
-- Query to count the number of rows insertion:
SELECT COUNT(*) as ORDERS_COUNT FROM ORDERS;

--Order_Items Table Records Insertion
--sql--
-- 6. INSERT ORDER_ITEMS (18 records)
INSERT INTO ORDER_ITEMS VALUES (4, 2, 3, 1, 49.99, 49.99);
INSERT INTO ORDER_ITEMS VALUES (5, 2, 2, 1, 34.99, 34.99);
INSERT INTO ORDER_ITEMS VALUES (6, 3, 4, 3, 24.99, 74.97);
INSERT INTO ORDER_ITEMS VALUES (7, 3, 5, 2, 59.99, 119.99);
INSERT INTO ORDER_ITEMS VALUES (8, 3, 6, 1, 129.99, 129.99);
INSERT INTO ORDER_ITEMS VALUES (9, 4, 4, 5, 24.99, 124.95);
INSERT INTO ORDER_ITEMS VALUES (10, 4, 10, 1, 44.99, 44.99);
INSERT INTO ORDER_ITEMS VALUES (11, 4, 14, 2, 12.99, 25.98);
INSERT INTO ORDER_ITEMS VALUES (12, 5, 13, 1, 18.99, 18.99);
INSERT INTO ORDER_ITEMS VALUES (13, 5, 14, 3, 12.99, 38.97);
INSERT INTO ORDER_ITEMS VALUES (14, 5, 15, 3, 15.99, 47.97);
INSERT INTO ORDER_ITEMS VALUES (15, 6, 11, 1, 54.99, 54.99);
INSERT INTO ORDER_ITEMS VALUES (16, 6, 2, 1, 34.99, 34.99);
INSERT INTO ORDER_ITEMS VALUES (17, 7, 7, 2, 249.99, 499.98);
INSERT INTO ORDER_ITEMS VALUES (18, 7, 8, 3, 39.99, 119.99);
 
-- Query to count the number of rows insertion:
SELECT COUNT(*) as ORDERITEMS_COUNT FROM ORDER_ITEMS;

--Payments Table Records Insertion
--sql--
-- 7. INSERT PAYMENTS (12 records)
INSERT INTO PAYMENTS VALUES (3, 3, 'PayPal', 384.97, SYSDATE-35, 'Completed', 'TXN001234569');
INSERT INTO PAYMENTS VALUES (4, 4, 'Debit Card', 299.97, SYSDATE-30, 'Pending', 'TXN001234570');
INSERT INTO PAYMENTS VALUES (5, 5, 'Credit Card', 204.97, SYSDATE-28, 'Completed', 'TXN001234571');
INSERT INTO PAYMENTS VALUES (6, 6, 'PayPal', 129.99, SYSDATE-25, 'Completed', 'TXN001234572');
INSERT INTO PAYMENTS VALUES (7, 7, 'Credit Card', 1679.97, SYSDATE-20, 'Completed', 'TXN001234573');
INSERT INTO PAYMENTS VALUES (8, 8, 'Credit Card', 554.97, SYSDATE-18, 'Pending', 'TXN001234574');
INSERT INTO PAYMENTS VALUES (9, 9, 'Debit Card', 249.97, SYSDATE-15, 'Completed', 'TXN001234575');
INSERT INTO PAYMENTS VALUES (10, 10, 'Credit Card', 539.97, SYSDATE-12, 'Completed', 'TXN001234576');
INSERT INTO PAYMENTS VALUES (11, 11, 'PayPal', 334.98, SYSDATE-8, 'Pending', 'TXN001234577');
INSERT INTO PAYMENTS VALUES (12, 12, 'Credit Card', 1469.97, SYSDATE-2, 'Pending', 'TXN001234578');
 
-- Query to count the number of rows insertion:
SELECT COUNT(*) as PAYMENTS_COUNT FROM PAYMENTS;

--Shipping Table Records Insertion
--sql--
-- 8. INSERT SHIPPING (12 records)
INSERT INTO SHIPPING VALUES (3, 3, '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA', 'TRACK002', SYSDATE-38, SYSDATE-35, SYSDATE-30, 'Delivered');
INSERT INTO SHIPPING VALUES (4, 4, '321 Elm Street', 'Houston', 'TX', '77001', 'USA', 'TRACK004', SYSDATE-30, SYSDATE-27, NULL, 'Processing');
INSERT INTO SHIPPING VALUES (5, 5, '654 Maple Drive', 'Phoenix', 'AZ', '85001', 'USA', 'TRACK005', SYSDATE-28, SYSDATE-15, SYSDATE-15, 'Delivered');
INSERT INTO SHIPPING VALUES (6, 6, '987 Cedar Lane', 'Philadelphia', 'PA', '19101', 'USA', 'TRACK006', SYSDATE-25, SYSDATE-20, NULL, 'In Transit');
INSERT INTO SHIPPING VALUES (7, 7, '147 Birch Court', 'San Antonio', 'TX', '78201', 'USA', 'TRACK007', SYSDATE-20, SYSDATE-8, SYSDATE-8, 'Delivered');
INSERT INTO SHIPPING VALUES (8, 8, '258 Spruce Way', 'San Diego', 'CA', '92101', 'USA', 'TRACK008', SYSDATE-18, SYSDATE-15, NULL, 'Processing');
INSERT INTO SHIPPING VALUES (9, 9, '369 Walnut Street', 'Dallas', 'TX', '75201', 'USA', 'TRACK009', SYSDATE-15, SYSDATE-5, SYSDATE-5, 'Delivered');
INSERT INTO SHIPPING VALUES (10, 10, '741 Hickory Path', 'San Jose', 'CA', '95101', 'USA', 'TRACK010', SYSDATE-12, SYSDATE-10, NULL, 'In Transit');
INSERT INTO SHIPPING VALUES (11, 11, '852 Ash Boulevard', 'Austin', 'TX', '78701', 'USA', 'TRACK011', SYSDATE-8, SYSDATE-5, NULL, 'Processing');
INSERT INTO SHIPPING VALUES (12, 12, '963 Oak Terrace', 'Jacksonville', 'FL', '32099', 'USA', 'TRACK012', SYSDATE-2, SYSDATE+1, NULL, 'Processing');
 
-- Query to count the number of rows insertion:
SELECT COUNT(*) as SHIPPING_COUNT FROM SHIPPING;
