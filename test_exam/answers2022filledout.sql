-- In next line, insert your student ID after the colon.
-- Student ID: 

-- Below, you must at most make one SQL query for each question. If you make several, they will be ignored.


-- -----------------------------------------------------------------------------------------------------
-- q1: Answer to question 1 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------

select catId, catName, max(unitPrice)
from FoodCategory natural left join FoodItem 
group by catId;

-- -----------------------------------------------------------------------------------------------------
-- q2: Answer to question 2 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------

select itemId, description from foodItem 
where itemId not in (select itemId from orderline);

-- -----------------------------------------------------------------------------------------------------
-- q3: Answer to question 3 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------

CREATE FUNCTION
total_cost_for_customer(v_custNo int) RETURNS int
RETURN 
  (select sum(unitPrice * quantity) 
  from FoodOrder natural join Orderline 
  where custNo = v_custNo);

-- -----------------------------------------------------------------------------------------------------
-- q4: Answer to question 4 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------

select custNo, total_cost_for_customer(custNo) from Customer;

-- -----------------------------------------------------------------------------------------------------
-- q5: Answer to question 5 MUST follow below. (don't edit this line)
-- -----------------------------------------------------------------------------------------------------

select catId, catName, count(*)
from foodCategory natural join foodItem
group by catId
having count(*) > 1;

