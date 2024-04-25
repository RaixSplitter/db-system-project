-- In next line, insert your student ID after the colon.
-- Student ID:

-- Below, you must at most make one SQL query for each question. If you make several, they will be ignored.

-------------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-------------------------------------------------------------------------------------------------------

SELECT fc.`catId`, fc.`catName`, MAX(fi.`unitPrice`)
from foodcategory fc
    INNER JOIN fooditem fi on fc.`catId` = fi.`catId`
GROUP BY
    fc.`catId`
ORDER BY fi.`unitPrice` DESC;

-------------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-------------------------------------------------------------------------------------------------------

SELECT fi.`itemId`, fi.`description`
from fooditem fi
    LEFT JOIN orderline ol on fi.`itemId` = ol.`itemId`
WHERE
    ol.`itemId` IS NULL;

-------------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-------------------------------------------------------------------------------------------------------

-- Create function that returns total cost for customer

CREATE OR REPLACE FUNCTION total_cost_for_customer(
customer_id INT) RETURNS INT 
BEGIN 
DECLARE
	total_cost INT;
	SELECT SUM(orderline.`unitPrice`) INTO total_cost
	FROM orderline
	    JOIN foodorder ON orderline.`orderNo` = foodorder.`orderNo`
	WHERE
	    foodorder.`custNo` = customer_id;
	return total_cost;
END;


-------------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-------------------------------------------------------------------------------------------------------

SELECT customer.`custNo`, total_cost_for_customer (customer.`custNo`)
FROM customer;

-------------------------------------------------------------------------------------------------------
-- q5: Answer to question 5 MUST follow below. (don't edit this line)
-------------------------------------------------------------------------------------------------------
SELECT foodcategory.`catId`, foodcategory.`catName`, COUNT(*)
FROM fooditem
    LEFT JOIN foodcategory on foodcategory.`catId` = fooditem.`catId`
GROUP BY
    foodcategory.`catId`
HAVING
    COUNT(*) > 1;