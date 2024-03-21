
USE Dhe_Hejking_Store;

-- VIEWS --
-- 1. VIEW OrderView: shows order ID, staff name, customer ID, and order date.
DROP VIEW IF EXISTS OrderView; 

CREATE VIEW OrderView AS
SELECT O.OrderID, OI.ProductID, OI.OrderQuantity, SPI.FirstName AS StaffName, O.CustomerID, O.OrderDate

FROM Orders O
JOIN Staff S ON O.StaffID = S.StaffID
JOIN OrderItem OI ON OI.ORDERID = O.ORDERID
JOIN StaffPrivateInfo SPI ON S.StaffID = SPI.StaffID;



-- 2. VIEW CustomerProductPreferences shows which products are preferred by 
-- which customers and which staff member sells them.
select * from CustomerProductPreferences;
DROP VIEW CustomerProductPreferences;
CREATE VIEW CustomerProductPreferences AS
SELECT 
    CONCAT(C.CustomerID, ' ', C.FirstName) AS CustomerName,
    C.Surname AS CustomerSurname,
    P.ProductID,
    P.ProductName,
    CONCAT(SPI.FirstName, ' ',SPI.Surname) AS StaffName
    
FROM 
    Customer C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
JOIN 
    OrderItem OI ON O.OrderID = OI.OrderID
JOIN 
    Products P ON OI.ProductID = P.ProductID
JOIN 
    Staff S ON O.StaffID = S.StaffID
JOIN 
    StaffPrivateInfo SPI ON S.StaffID = SPI.StaffID;
    
SELECT * FROM CustomerProductPreferences;

-- 3. VIEW TopSellingStaff shows which staff member has sold
-- the most products in each category.
select * from TopSellingStaff;

CREATE VIEW TopSellingStaff AS
SELECT 
    SPI.StaffID,
    SPI.FirstName,
    C.CategoryID,
    COUNT(*) AS TotalSales
FROM 
    StaffPrivateInfo SPI
JOIN 
    Orders O ON SPI.StaffID = O.StaffID
JOIN 
    OrderItem OI ON O.OrderID = OI.OrderID
JOIN 
    Products P ON OI.ProductID = P.ProductID
JOIN 
    Categories C ON P.ProductID = C.ProductID
GROUP BY 
    SPI.StaffID, SPI.FirstName, SPI.Surname, C.CategoryID
ORDER BY 
    TotalSales DESC;

-- VIEW 4 MostSoldBrandAndBuyer: shows which brand is the most sold and who buys it
DROP VIEW MostSoldBrandAndBuyer;

CREATE VIEW MostSoldBrandAndBuyer AS
SELECT 
    P.Brand,
    COUNT(*) AS TotalSales,
    CONCAT(C.FirstName, ' ', C.Surname) AS CustomerName,
    CONCAT(SPI.FirstName,' ', SPI.Surname) AS StaffName
    
FROM 
    Orders O
JOIN 
    OrderItem OI ON O.OrderID = OI.OrderID
JOIN 
    Products P ON OI.ProductID = P.ProductID
JOIN 
    Customer C ON O.CustomerID = C.CustomerID
LEFT JOIN 
    Staff S ON O.StaffID = S.StaffID
LEFT JOIN 
    StaffPrivateInfo SPI ON S.StaffID = SPI.StaffID
GROUP BY 
    P.Brand, C.CustomerID, C.FirstName, C.Surname, SPI.FirstName
ORDER BY 
    TotalSales DESC;
    
SELECT * from MostSoldBrandAndBuyer;
    
