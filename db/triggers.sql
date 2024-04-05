
USE Dhe_Hejking_Store;

-- Drop all tables and views --

DROP TRIGGER IF EXISTS UpdateTotalPrice;
DROP TRIGGER IF EXISTS UpdateStockQuantity;

DROP TRIGGER IF EXISTS PreventHouseDeletion;



CREATE OR REPLACE PROCEDURE UpdateStockQuantity(IN product_id VARCHAR(5), IN order_quantity INT, IN order_id INT)
BEGIN
    -- Update stock quantity in the Stock table
    UPDATE Stock
    SET StockQuantity = StockQuantity - order_quantity
    WHERE ProductID = product_id AND StoreID = (
        SELECT StoreID FROM Orders WHERE OrderID = order_id
    );
END;

CREATE OR REPLACE PROCEDURE UpdateTotalPrice(IN order_id INT)
BEGIN
    DECLARE total DECIMAL(8,2);
    
    -- Calculate total price for the order
    SELECT SUM(BatchPrice * OrderQuantity) INTO total
    FROM OrderItem
    WHERE OrderID = order_id;
    
    -- Update the total price in the Orders table
    UPDATE Orders
    SET TotalPrice = total
    WHERE OrderID = order_id;
END;


DELIMITER //

CREATE OR REPLACE TRIGGER UpdateOrder
AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
    CALL UpdateStockQuantity(NEW.ProductID, NEW.OrderQuantity, NEW.OrderID);
    CALL UpdateTotalPrice(NEW.OrderID);
END;

DELIMITER;

