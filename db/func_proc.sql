USE Dhe_Hejking_Store;


CREATE OR REPLACE FUNCTION calculate_cost(product_id INT, product_quantity INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE product_price DECIMAL(10,2);
    DECLARE total_cost DECIMAL(10,2);
    
    SELECT ProductPrice INTO product_price FROM products WHERE ProductID = product_id;
    
    SET total_cost = product_price * product_quantity;
    
    RETURN total_cost;
END;




SELECT calculate_cost(11111, 2);

CREATE OR REPLACE PROCEDURE create_order(customer_id VARCHAR(5), store_id VARCHAR(5), staff_id VARCHAR(5), product_ids VARCHAR(255), product_quantities VARCHAR(255))
BEGIN
    DECLARE order_id INT;
    DECLARE i INT;
    DECLARE product_id INT;
    DECLARE product_quantity INT;
    DECLARE batch_price DECIMAL(10,2);
    DECLARE total_price DECIMAL(10,2);


    INSERT INTO orders (CustomerID, StoreID, StaffID, OrderDate) VALUES (customer_id, store_id, staff_id, CURDATE());
    
    -- Select order ID from the last inserted order
    SELECT OrderID INTO order_id FROM orders ORDER BY OrderID DESC LIMIT 1;


    SET i = 1;
    -- SET total_price = 0;
    
    WHILE i <= LENGTH(product_ids) - LENGTH(REPLACE(product_ids, ',', '')) + 1  DO
        SET product_id = SUBSTRING_INDEX(SUBSTRING_INDEX(product_ids, ',', i), ',', -1);
        SET product_quantity = SUBSTRING_INDEX(SUBSTRING_INDEX(product_quantities, ',', i), ',', -1);

        SET batch_price = calculate_cost(product_id, product_quantity);
        
        INSERT INTO orderitem (OrderID, SerialID, ProductID, OrderQuantity, BatchPrice) VALUES (order_id, UUID(), product_id, product_quantity, batch_price);
        
        SET i = i + 1;
        -- SET total_price = total_price + batch_price;
    END WHILE;

    -- Notice we don't need to update the total price here, as the trigger will do it for us
    -- UPDATE orders SET TotalPrice = total_price WHERE OrderID = order_id;
END;

CALL create_order('C0001', '00000', 'A1000', '54321,12345', '2,3');

-- Update order required date to current date
UPDATE orders SET RequiredDate = CURDATE() WHERE OrderID = 7;

-- Delete order with orderid 7, and all orderitems associated with it
DELETE FROM orders WHERE OrderID = 7;




