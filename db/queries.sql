-- Receipt query: The receipt displays- Staff first name, Product name, Brand, Order quantity, order id, Store address, phone --


-- Join Orders and OrderItems to get list of items for a given order
-- Join that to staff private info to get staff first name
-- Join that to store to get store details
SELECT StaffPrivateInfo.FirstName, ProductName, Brand, OrderQuantity, Products.ProductPrice, StoreAddress, OrderCross.OrderID, Store.Telephone,OrderCross.TotalPrice, OrderCross.ShippingDate
FROM `Orders` AS OrderCross
INNER JOIN OrderItem ON OrderCross.OrderID = OrderItem.OrderID
INNER JOIN StaffPrivateInfo ON OrderCross.StaffID = StaffPrivateInfo.StaffID
INNER JOIN Products ON OrderItem.ProductID = Products.ProductID
INNER JOIN Store on OrderCross.StoreID = Store.StoreID
WHERE OrderCross.OrderID = 1001;

-- Stock warning query: Get all products in stores where product stock is below a certain threshold, in this case, 3
SELECT ProductName as Product, Brand, StoreAddress as Address, StockQuantity as Quantity
FROM 
Stock INNER JOIN Products on Stock.ProductID = Products.ProductID
INNER JOIN Store on Stock.StoreID = Store.StoreID
WHERE Stock.StockQuantity <= 3;

-- Product stock query: Get the stock of a given product at all locations
SELECT ProductName as Product, Brand, StoreAddress as Address, StockQuantity as Quantity
FROM 
Stock INNER JOIN Products on Stock.ProductID = Products.ProductID
INNER JOIN Store on Stock.StoreID = Store.StoreID
WHERE Products.ProductID = '54321';