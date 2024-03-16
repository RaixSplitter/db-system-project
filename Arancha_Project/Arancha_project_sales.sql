
-- Drop all tables --
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Customer;

DROP DATABASE IF EXISTS Dhe_Hejking_Store;

CREATE DATABASE IF NOT EXISTS Dhe_Hejking_Store;

USE Dhe_Hejking_Store;


DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Takes;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Products;


-- Create tables --


CREATE TABLE Store(
	StoreID VARCHAR(5),
    StoreName VARCHAR(20) NOT NULL,
    Address VARCHAR(15) NOT NULL,
    Telephone INT(8),
    PRIMARY KEY (StoreID)
    );
-- Products(Product_ID, Product_name, Brand, Product_price)
-- where primary keys are Product_ID
-- For the attribute Product_price is can the highst price be 9999,99
-- The reason is that the price can be some thousands DKR.
CREATE TABLE Products
    (ProductID         VARCHAR(5),
     ProductName       VARCHAR(20) NOT NULL,
     Brand              VARCHAR(20) NOT NULL,
     ProductPrice      DECIMAL(6,2) NOT NULL,
     PRIMARY KEY(ProductID)
    );


-- Category(Category_ID, Category_name)
-- Where the PRIMARY key is
CREATE TABLE Category
    (CategoryID        VARCHAR(5),
     CategoryName      VARCHAR(15) NOT NULL,
     PRIMARY KEY(CategoryID)
    );


-- Categories(Product_ID, Category_ID),
-- where primary keys are Product_ID, Category_ID
-- and is also FOREIGN keys.
-- The relation is that this is a many-many relation, and is weaker
CREATE TABLE Categories
    (ProductID         VARCHAR(5),
     CategoryID        VARCHAR(5),
     PRIMARY KEY(ProductID, CategoryID),
     FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
     FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
    );


-- Stock(Product_ID, Store_ID, Stock_Quantity)
-- Where the PRIMARY keys are Product_ID, Store_ID
-- and are also FOREIGN keys.
-- The highest Stock_Quantity is set to 999.


-- We need a before delete trigger for StoreID
-- The triggger stock must be moved to a different store
-- This means the stock is placed in another store which can be one with an specific ID 'House'
-- Trigger: House can never be deleted. 
-- If a store is deleted, the storeID for that stock becomes 'HOUSE'

CREATE TABLE Stock
    (ProductID         VARCHAR(5),
     StoreID           VARCHAR(5),
     StockQuanity      INT NOT NULL,
     PRIMARY KEY(ProductID, StoreID),
     FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
     FOREIGN KEY(StoreID) REFERENCES Store(StoreID)
    );



-- We assume a StoreID can be deleted
CREATE TABLE Staff(
    StaffID VARCHAR(5),
    StoreID VARCHAR(5),
    WorkingStatus ENUM('Active','Inactive'),
    PRIMARY KEY (StaffID),
    FOREIGN KEY (StoreID) REFERENCES Store ON DELETE SET NULL
    );

-- Is it a problem to use the same primary key in both tables?
CREATE TABLE StaffPrivateInfo(
	StaffID VARCHAR(5),
    FirstName VARCHAR(20) NOT NULL,
    Surname VARCHAR(20) NOT NULL,
    Address VARCHAR(20),
    Telephone INT(8),
    FOREIGN KEY (StaffID) REFERENCES Staff ON DELETE CASCADE
    );
    
CREATE TABLE Customer(
	CustomerID VARCHAR(5),
    FirstName VARCHAR(20),
    Surname VARCHAR(20),
    Address VARCHAR(20), 
    Telephone INT(8),
    PRIMARY KEY (CustomerID));

CREATE TABLE Orders(
	OrderID INT(8),
    CustomerID VARCHAR(5),
    StoreID VARCHAR(5),  
    StaffID VARCHAR(5),
    TotalPrice DECIMAL(8,2),
    OrderDate DATE NOT NULL,
    ShippingDate DATE,
    RequiredDate DATE,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer,
    FOREIGN KEY (StoreID) REFERENCES Store,
    FOREIGN KEY (StaffID) REFERENCES Staff,
	CONSTRAINT ShippingDate CHECK (ShippingDate > OrderDate),
    CONSTRAINT RequiredDate CHECK (RequiredDate > ShippingDate)
    );
    

CREATE TABLE OrderItem(
    OrderID VARCHAR(5),
    SerialID INT NOT NULL,
    OrderQuantity INT NOT NULL,  
    ProductID VARCHAR(5),
    BatchPrice DECIMAL(7,2), 
    PRIMARY KEY (SerialID,OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products
    );


-- UpdateBatchPrice trigger

DELIMITER //
CREATE TRIGGER UpdateBatchPrice
AFTER INSERT ON OrderItem
FOR EACH ROW	
BEGIN
    -- Calculate the total price
    UPDATE OrderItem
    SET BatchPrice = (SELECT SUM(ProductPrice) FROM Products WHERE Product.ProductID = NEW.ProductID)
    WHERE ProductID = NEW.ProductID;
END;
// DELIMITER ;

-- UpdateTotalPrice trigger

DELIMITER //
CREATE TRIGGER UpdateTotalPrice
AFTER INSERT ON Orders
FOR EACH ROW	
BEGIN
    -- Calculate the total price
    UPDATE Orders
    SET TotalPrice = (SELECT SUM(BatchPrice) FROM OrderItem WHERE OrderItem.OrderID = NEW.OrderID)
    WHERE OrderID = NEW.OrderID;
END;
// DELIMITER ;




INSERT Store VALUES
('House');


--
INSERT Products VALUES
('54321', 'Hiking shoes', 'Peak', 500.95),
('12345', 'Hiking socks', 'Peak', 350.95);




--
INSERT Category (Category_ID, Category_name) VALUES
('98765', 'Foodwhere'),
('56789', 'Male'),
('12345', 'Female'),
('54321', 'Non-gender');


--
INSERT Categories VALUES
('54321', '98765'),
('54321', '54321'),
('12345', '98765'),
('12345', '12345');


--
INSERT Stock VALUES
('54321', '12345', 4),
('12345', '12345', 20);







    
    
    
    