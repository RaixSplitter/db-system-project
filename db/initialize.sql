
DROP DATABASE IF EXISTS Dhe_Hejking_Store;
CREATE DATABASE IF NOT EXISTS Dhe_Hejking_Store;

USE Dhe_Hejking_Store;

-- Drop all tables and views --

DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS StaffPrivateInfo;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Customer;

-- Create tables --

CREATE TABLE Store (
    StoreID VARCHAR(5),
    StoreName VARCHAR(20) NOT NULL,
    StoreAddress VARCHAR(30) NOT NULL,
    Telephone VARCHAR(8),
    StoreStatus ENUM('Active', 'Inactive'),
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
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
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
    WorkingStatus ENUM('Active', 'Holiday','Inactive'),
    PRIMARY KEY (StaffID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) ON DELETE SET NULL
);

CREATE TABLE StaffPrivateInfo (
    StaffID VARCHAR(20),
    FirstName VARCHAR(20) NOT NULL,
    Surname VARCHAR(20) NOT NULL,
    StaffAddress VARCHAR(20),
    Telephone VARCHAR(8),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE CASCADE
);

CREATE TABLE Customer (
    CustomerID VARCHAR(5),
    FirstName VARCHAR(20),
    Surname VARCHAR(20),
    CustomerAddress VARCHAR(20),
    Telephone VARCHAR(8),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Orders (
    OrderID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CustomerID VARCHAR(5),
    StoreID VARCHAR(5),
    StaffID VARCHAR(5),
    TotalPrice DECIMAL(8,2),
    OrderDate DATE,
    ShippingDate DATE,
    RequiredDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE SET NULL,
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) ON DELETE SET NULL,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE SET NULL,
    CONSTRAINT ShippingDate CHECK (ShippingDate > OrderDate),
    CONSTRAINT RequiredDate CHECK (RequiredDate > ShippingDate));    

CREATE TABLE OrderItem (
    OrderID INTEGER UNSIGNED AUTO_INCREMENT,
    SerialID UUID NOT NULL,
    OrderQuantity INT NOT NULL,
    ProductID VARCHAR(5),
    BatchPrice DECIMAL(7,2),
    PRIMARY KEY (SerialID, OrderID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID));


