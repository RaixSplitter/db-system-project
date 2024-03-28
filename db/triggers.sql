
USE Dhe_Hejking_Store;

-- Drop all tables and views --

DROP TRIGGER IF EXISTS UpdateTotalPrice;
DROP TRIGGER IF EXISTS UpdateStockQuantity;

DROP TRIGGER IF EXISTS PreventHouseDeletion;



-- UPDATE TOTAL PRICE TRIGGER

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
DELIMITER ;



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

