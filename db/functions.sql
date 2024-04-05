USE dhe_hejking_store;
DELIMITER //
CREATE FUNCTION get_total_revenue (start_date DATE , end_date DATE)
RETURNS float
DETERMINISTIC
BEGIN
    DECLARE total_revenue FLOAT;

    SELECT SUM(Orders.TotalPrice) INTO total_revenue
    FROM Orders
    WHERE Orders.OrderDate BETWEEN start_date AND end_date;

    RETURN total_revenue;

END;
//

DELIMITER ;


SET @total_revenue = get_total_revenue('2012-01-01', '2024-03-29');
SELECT @total_revenue AS TotalRevenue;