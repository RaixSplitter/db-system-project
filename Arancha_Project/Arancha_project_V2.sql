
DROP DATABASE IF EXISTS Dhe_Hejking_Store;
CREATE DATABASE IF NOT EXISTS Dhe_Hejking_Store;

USE Dhe_Hejking_Store;

-- Drop all tables and views --

DROP VIEW IF EXISTS TopSellingStaff;
DROP VIEW IF EXISTS OrderView;
DROP VIEW IF EXISTS CustomerProductPreferences;

DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Takes;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS StaffPrivateInfo;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Store;

-- Create tables --

CREATE TABLE Store (
    StoreID VARCHAR(5),
    StoreName VARCHAR(20) NOT NULL,
    Address VARCHAR(30) NOT NULL,
    Telephone VARCHAR(8),
    PRIMARY KEY (StoreID)
);

CREATE TABLE Products (
    ProductID VARCHAR(5),
    ProductName VARCHAR(20) NOT NULL,
    Brand VARCHAR(30) NOT NULL,
    ProductPrice DECIMAL(6,2) NOT NULL,
    PRIMARY KEY(ProductID)
);

CREATE TABLE Category (
    CategoryID VARCHAR(5),
    CategoryName VARCHAR(15) NOT NULL,
    PRIMARY KEY(CategoryID)
);

CREATE TABLE Categories (
    ProductID VARCHAR(5),
    CategoryID VARCHAR(5),
    PRIMARY KEY(ProductID, CategoryID),
    FOREIGN KEY(ProductID) REFERENCES Products ON DELETE CASCADE,
    FOREIGN KEY(CategoryID) REFERENCES Category ON DELETE CASCADE
);


CREATE TABLE Stock (
    ProductID VARCHAR(5),
    StoreID VARCHAR(5),
    StockQuantity INT NOT NULL,
    PRIMARY KEY(ProductID, StoreID),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY(StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE Staff (
    StaffID VARCHAR(5),
    StoreID VARCHAR(5),
    WorkingStatus ENUM('Active', 'Inactive'),
    PRIMARY KEY (StaffID),
    FOREIGN KEY (StoreID) REFERENCES Store ON DELETE SET NULL
);

CREATE TABLE StaffPrivateInfo (
    StaffID VARCHAR(20),
    FirstName VARCHAR(20) NOT NULL,
    Surname VARCHAR(20) NOT NULL,
    Address VARCHAR(20),
    Telephone VARCHAR(8),
    FOREIGN KEY (StaffID) REFERENCES Staff ON DELETE CASCADE
);

CREATE TABLE Customer (
    CustomerID VARCHAR(5),
    FirstName VARCHAR(20),
    Surname VARCHAR(20),
    Address VARCHAR(20),
    Telephone VARCHAR(8),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Orders (
    OrderID INT(8),
    CustomerID VARCHAR(5),
    StoreID VARCHAR(5),
    StaffID VARCHAR(5),
    TotalPrice DECIMAL(8,2),
    OrderDate DATE,
    ShippingDate DATE,
    RequiredDate DATE,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer ON DELETE SET NULL,
    FOREIGN KEY (StoreID) REFERENCES Store ON DELETE SET NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff ON DELETE SET NULL,
    CONSTRAINT ShippingDate CHECK (ShippingDate > OrderDate),
    CONSTRAINT RequiredDate CHECK (RequiredDate > ShippingDate));    

CREATE TABLE OrderItem (
    OrderID INT(8),
    SerialID INT NOT NULL,
    OrderQuantity INT NOT NULL,
    ProductID VARCHAR(5),
    BatchPrice DECIMAL(7,2),
    PRIMARY KEY (SerialID, OrderID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products);



-- UPDATE TOTAL PRICE TRIGGER
CREATE TRIGGER UpdateTotalPrice

DELIMITER //
CREATE TRIGGER UpdateTotalPrice
AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(8,2);
    
    -- Calculate total price for the order
    SELECT SUM(BatchPrice * OrderQuantity) INTO total
    FROM OrderItem
    WHERE OrderID = NEW.OrderID;
    
    -- Update the total price in the Orders table
    UPDATE Orders
    SET TotalPrice = total
    WHERE OrderID = NEW.OrderID;
END;
// 
DELIMITER;



-- TRIGGER updates the stock quantity in the Stock table whenever a new order is placed
DELIMITER //
CREATE TRIGGER UpdateStockQuantity
AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
    -- Update stock quantity in the Stock table
    UPDATE Stock
    SET StockQuantity = StockQuantity - NEW.OrderQuantity
    WHERE ProductID = NEW.ProductID AND StoreID = (
        SELECT StoreID FROM Orders WHERE OrderID = NEW.OrderID
    );
END;
//

DELIMITER ;



/*
-- Delete all data from tables with foreign key constraints --
DELETE FROM Categories;
DELETE FROM Stock;
DELETE FROM Orders;
DELETE FROM OrderItem;
DELETE FROM StaffPrivateInfo;
DELETE FROM Staff;
DELETE FROM Customer;
DELETE FROM Products;
DELETE FROM Store;
DELETE FROM Category;
*/

-- Insert values into Store table --
INSERT Store (StoreID, StoreName, Address, Telephone) VALUES
('House', 'Dhe Hejking Amager', 'Amagerbrogade 15', '99887766'),
('00001', 'Dhe Hejking Kbh', 'Nørrebrogade 65', '88776655'),
('00002', 'Dhe Hejking Valby', 'Valbygade 30', '11223344'),
('00003', 'Dhe Hejking Lyngby', 'Lyngbyvej 10', '77665544'),
('00004', 'Dhe Hejking DTU', 'Anker Engelunds Vej', '66554433');

-- Insert values into Products table --
INSERT Products (ProductID, ProductName, Brand, ProductPrice) VALUES
('54321', 'Hiking shoes', 'Peak', 500.95),
('54322', 'Hiking shoes', 'Columbia', 749.99),
('54323', 'Hiking shoes', 'The North Face', 499.99),
('12345', 'Hiking socks', 'Peak', 350.95),
('11111', 'Hiking pants', 'The North Face', 350.95),
('31111', 'Nightflash', 'Nitecore', 250.00),
('11112', 'Hiking pants', 'Columbia', 400.00),
('11113', 'Hiking pants', 'Columbia', 600.00),
('11114', 'Hiking pants', 'Columbia', 750.00);

-- Insert values into Category table --
INSERT Category (CategoryID, CategoryName) VALUES
('98765', 'Footwear'),
('56789', 'Male'),
('12345', 'Female'),
('54321', 'Non-gender'),
('10000', 'Outdoor Clothes'),
('20000', 'Equipment'),
('30000', 'Underwear');

-- Insert values into Categories table --
INSERT Categories (ProductID, CategoryID) VALUES
('54321', '98765'),
('54321', '54321'),
('12345', '98765'),
('12345', '12345'),
('11111', '98765'),
('31111', '20000'),
('11112', '10000'),
('11112', '56789');

-- Insert values into Stock table --
INSERT Stock (ProductID, StoreID, StockQuantity) VALUES
('54321', 'House', 4),
('12345', '00001', 20),
('54321', '00002', 3),
('54321', '00003', 4),
('12345', '00004', 20),
('54321', '00004', 3),
('11111', '00001', 10),
('31111', '00001', 20),
('11113', '00001', 5),
('11114', '00001', 10),
('11111', '00002', 10),
('31111', '00002', 20),
('11113', '00003', 5),
('11114', '00003', 10),
('11111', '00004', 10),
('31111', '00004', 20),
('11113', '00004', 5)
;

-- 
INSERT INTO Staff (StaffID, StoreID, WorkingStatus) VALUES
('A1000', 'House', 'Active'),
('A2000', '00001', 'Active'),
('A3000', '00002', 'Active'),
('A4000', '00003', 'Active'),
('B5000', '00004', 'Active'),
('B6000', '00001', 'Inactive'),
('C7000', 'House', 'Inactive'), 
('C8000', 'House', 'Inactive'),
('C9000', 'House', 'Active');


-- Insert values into StaffPrivateInfo table --
INSERT StaffPrivateInfo (StaffID, FirstName, Surname, Address, Telephone) VALUES
('A1000', 'Sebas', 'Jensen', 'Valbyparken 1', '11223344'),
('A2000', 'Marcus', 'Christensen', 'Lyngbyvej 23', '22334455'),
('A3000', 'Adiya', 'Smith', 'Kongevej 56', '11112222'),
('A4000', 'Aran', 'Rasmussen', 'Birkevej 12', '22223333'),
('B5000', 'Anna', 'Ibsen', 'Fasangade 34', '33344444'),
('B6000', 'Mark', 'Newman', 'Vesterbrogade 85', '44445555'),
('C7000', 'John', 'Andersen', 'Vesterbrogade 85', '66665555'),
('C8000', 'Robert', 'Duval', 'Nørrebrogade 99', '55557777'),
('C9000', 'Linda', 'Sacks', 'Amagerbrogade 77', '88887777');

INSERT INTO Customer (CustomerID, FirstName, Surname, Address, Telephone) VALUES
('C0001', 'Lars', 'Nielsen', 'Søndergade 1', '11111111'),
('C0002', 'Mette', 'Pedersen', 'Bakkevej 2', '22222222'),
('C0003', 'Anders', 'Jensen', 'Skovvej 3', '33333333'),
('C0004', 'Hanne', 'Hansen', 'Fjordvej 4', '44444444'),
('C0005', 'Anne', 'Andersen', 'Strandvej 5', '55555555'),
('C0006', 'Ole', 'Olesen', 'Bredgade 6', '66666666'),
('C0007', 'Lise', 'Larsen', 'Møllevej 7', '77777777');

-- Insert values into Orders table --
INSERT INTO Orders (OrderID, CustomerID, StoreID, StaffID, TotalPrice, OrderDate, ShippingDate, RequiredDate) VALUES
(1001, 'C0001', 'House', 'A1000', 1503.30, '2024-03-17', '2024-03-18', '2024-03-19'),
(1002, 'C0002', '00001', 'A2000', 500.95, '2024-03-17', '2024-03-18', '2024-03-19'),
(1003, 'C0003', '00002', 'A3000', 1951.89, '2024-03-17', '2024-03-18', '2024-03-19'),
(1004, 'C0004', '00003', 'A4000', 1499.97, '2024-03-17', '2024-03-18', '2024-03-19'),
(1005, 'C0005', '00004', 'B5000', 2000.00, '2024-03-17', '2024-03-18', '2024-03-19'),
(1007, 'C0007', 'House', 'C9000', NULL, '2024-03-17', '2024-03-18', '2024-03-19');

-- Insert values into OrderItem table --
INSERT INTO OrderItem (OrderID, SerialID, OrderQuantity, ProductID, BatchPrice) VALUES
(1001, 1, 2, '54321', 1001.90),
(1001, 2, 1, '12345', 200.50),
(1002, 1, 1, '54321', 500.95),
(1003, 1, 1, '54322', 749.99),
(1003, 2, 2, '11111', 701.90),
(1004, 1, 3, '54323', 1499.97);


-- VIEWS --
-- 1. VIEW OrderView: shows order ID, staff name, customer ID, and order date.

CREATE VIEW OrderView AS
SELECT O.OrderID, SPI.FirstName AS StaffName, O.CustomerID, O.OrderDate
FROM Orders O
JOIN Staff S ON O.StaffID = S.StaffID
JOIN StaffPrivateInfo SPI ON S.StaffID = SPI.StaffID;

-- 2. VIEW CustomerProductPreferences shows which products are preferred by 
-- which customers and which staff member sells them.

CREATE VIEW CustomerProductPreferences AS
SELECT 
    C.CustomerID,
    C.FirstName AS CustomerFirstName,
    C.Surname AS CustomerSurname,
    P.ProductID,
    P.ProductName,
    SPI.FirstName AS StaffFirstName,
    SPI.Surname AS StaffSurname
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
    
    
-- 3. VIEW TopSellingStaff shows which staff member has sold
-- the most products in each category.
CREATE VIEW TopSellingStaff AS
SELECT 
    SPI.StaffID,
    SPI.FirstName,
    SPI.Surname,
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
CREATE VIEW MostSoldBrandAndBuyer AS
SELECT 
    P.Brand,
    COUNT(*) AS TotalSales,
    C.CustomerID,
    CONCAT(C.FirstName, ' ', C.Surname) AS CustomerName,
    SPI.FirstName AS StaffFirstName,
    SPI.Surname AS StaffSurname
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
    P.Brand, C.CustomerID, C.FirstName, C.Surname, SPI.FirstName, SPI.Surname
ORDER BY 
    TotalSales DESC;



-- COMMENTS:
-- We need a before delete trigger for StoreID
-- The triggger stock must be moved to a different store
-- This means the stock is placed in another store which can be one with an specific ID 'House'
-- Trigger: House can never be deleted. 
-- If a store is deleted, the storeID for that stock becomes 'HOUSE'



-- DRAFT TRIGGER MoveStockAfterClosure, NEEDS DEBUGGING in the 4th DECLARE --

DELIMITER //

CREATE TRIGGER MoveStockAfterClosure
AFTER DELETE ON Store
FOR EACH ROW
BEGIN
    DECLARE productID_var VARCHAR(5);
    DECLARE stockQuantity_var INT;
    DECLARE done INT DEFAULT FALSE;

    IF OLD.StoreID != 'House' THEN
		-- Cursor to iterate through the stocks of the closing store
		DECLARE stock_cursor CURSOR FOR
			SELECT ProductID, StockQuantity
            FROM Stock
            WHERE StoreID = OLD.StoreID;
        
        -- Declare continue handler to exit loop when cursor is done
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        
        OPEN stock_cursor;
        
        read_loop: LOOP
            FETCH stock_cursor INTO productID_var, stockQuantity_var;
            IF done THEN
                LEAVE read_loop;
            END IF;
            
            -- Check if the product already exists in the 'House' store
            SELECT COUNT(*)
            INTO @exists
            FROM Stock
            WHERE ProductID = productID_var AND StoreID = 'House';
            
            IF @exists > 0 THEN
                -- Update the stock quantity in the 'House' store
                UPDATE Stock
                SET StockQuantity = StockQuantity + stockQuantity_var
                WHERE ProductID = productID_var AND StoreID = 'House';
            ELSE
                -- Insert new stock record for the product in the 'House' store
                INSERT INTO Stock (ProductID, StoreID, StockQuantity)
                VALUES (productID_var, 'House', stockQuantity_var);
            END IF;
            
            -- Delete the stock record from the closing store
            DELETE FROM Stock
            WHERE ProductID = productID_var AND StoreID = OLD.StoreID;
        END LOOP;
        
        CLOSE stock_cursor;
    END IF;
END//

DELIMITER ;
