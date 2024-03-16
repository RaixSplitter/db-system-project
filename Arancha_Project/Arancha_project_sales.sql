DROP SCHEMA  IF EXISTS HikingStore;
CREATE SCHEMA HikingStore;
USE HikingStore;

-- Drop all tables --
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Customer;


-- Create tables --
CREATE TABLE Store(
	StoreID VARCHAR(5) NOT NULL,
    StoreName VARCHAR(20) NOT NULL,
    Address VARCHAR(15),
    Telephone INT(8),
    PRIMARY KEY (StoreID)
    );
    
CREATE TABLE Staff(
    StaffID VARCHAR(5) NOT NULL,
    StoreID VARCHAR(5),
    Activ BOOL,  
    PRIMARY KEY (StaffID),
	FOREIGN KEY (StaffID) REFERENCES StaffPrivateInfo ON DELETE CASCADE,
    FOREIGN KEY (StoreID) REFERENCES Store
    );

CREATE TABLE StaffPrivateInfo(
	StaffID VARCHAR(5) NOT NULL,
    FirstName VARCHAR(20),
    Surname VARCHAR(20),
    Address VARCHAR(20),
    Telephone INT(8),
    PRIMARY KEY (StaffID)
    );
    
    
CREATE TABLE Orders(
	OrderID INT(8) NOT NULL,
    CustomerID VARCHAR(5),
    StoreID VARCHAR(5),  
    StaffID VARCHAR(5),
    TotalPrice DECIMAL(5,2),
    OrderDate DATE NOT NULL,
    ShippingDate DATE,
    RequiredDate DATE,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer,
    FOREIGN KEY (StoreID) REFERENCES Store,
    FOREIGN KEY (StaffID) REFERENCES Staff
    );
    

CREATE TABLE OrderItem(
    OrderID VARCHAR(5),
    SerialID INT NOT NULL,
    OrderQuantity INT NOT NULL,  
    ProductID VARCHAR(5),
    BatchPrice DECIMAL(5,2),
    PRIMARY KEY (SerialID,OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products
    );

CREATE TABLE Customer(
	CustomerID VARCHAR(5),
    FirstName VARCHAR(20),
    Surname VARCHAR(20),
    Address VARCHAR(20), 
    Telephone INT(8))

-- UpdateTotalPrice trigger: everytime a BatchPrice is inserted, the Total Price of 
-- the order of that product is updated

DELIMITER //
CREATE TRIGGER UpdateTotalPrice
AFTER INSERT ON OrderItem
FOR EACH ROW	
BEGIN
    -- Calculate the total price
    UPDATE Orders
    SET TotalPrice = (SELECT SUM(BatchPrice) FROM OrderItem WHERE OrderItem.OrderID = NEW.OrderID)
    WHERE OrderID = NEW.OrderID;
END;
// DELIMITER ;

-- SCHEMA -- --

-- ;;
Store(StoreID,StoreName,Address,Telephone);
    
Staff(StaffID,StoreID,Activ);

StaffPrivateInfo(StaffID,FirstName,Surname,Address,Telephone);
    
Orders(OrderID, CustomerID, StoreID, StaffID,TotalPrice, OrderDate, ShippingDate,RequiredDate);
    
OrderItem(OrderID, SerialID,OrderQuantity, ProductID,BatchPrice);

Customer(CustomerID,FirstName,Surname,Address,Telephone);



    
    
    
    