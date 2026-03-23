-- Create Database
CREATE DATABASE inventory_db;
USE inventory_db;

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    stock_quantity INT,
    price DECIMAL(10,2)
);

-- Vendors Table
CREATE TABLE Vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(50),
    contact VARCHAR(15)
);

-- Purchases Table
CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY,
    product_id INT,
    vendor_id INT,
    quantity INT,
    purchase_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id)
);

-- Insert Data
INSERT INTO Products VALUES
(1, 'Hearing Aid A', 'Device', 50, 15000),
(2, 'Hearing Aid B', 'Device', 30, 20000),
(3, 'Battery Pack', 'Accessory', 100, 500),
(4, 'Ear Mold', 'Accessory', 80, 300);

INSERT INTO Vendors VALUES
(1, 'Vendor X', '9876543210'),
(2, 'Vendor Y', '9123456780');

INSERT INTO Purchases VALUES
(1, 1, 1, 10, '2025-01-10'),
(2, 2, 2, 5, '2025-01-15'),
(3, 3, 1, 20, '2025-01-20'),
(4, 4, 2, 15, '2025-02-05');

-- Queries

-- 1. Low Stock
SELECT product_name, stock_quantity
FROM Products
WHERE stock_quantity < 40;

-- 2. Total Purchase per Product
SELECT p.product_name, SUM(pr.quantity) AS total_purchased
FROM Purchases pr
JOIN Products p ON pr.product_id = p.product_id
GROUP BY p.product_name;

-- 3. Vendor-wise Supply
SELECT v.vendor_name, SUM(pr.quantity) AS total_supplied
FROM Purchases pr
JOIN Vendors v ON pr.vendor_id = v.vendor_id
GROUP BY v.vendor_name;

-- 4. Monthly Purchase Report
SELECT MONTH(purchase_date) AS month, SUM(quantity) AS total_quantity
FROM Purchases
GROUP BY MONTH(purchase_date);

-- 5. Top Purchased Product
SELECT p.product_name, SUM(pr.quantity) AS total
FROM Purchases pr
JOIN Products p ON pr.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total DESC
LIMIT 1;
