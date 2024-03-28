-- Receipt query: The receipt displays- Staff first name, Product name, Brand, Order quantity, order id, Store address, phone --


-- Join Orders and OrderItems to get list of items for a given order
-- Join that to staff private info to get staff first name
SELECT FirstName, ProductName, Brand, OrderQuantity, Products.ProductPrice, StoreAddress, OrderCross.OrderID, Store.Telephone,OrderCross.TotalPrice, OrderCross.ShippingDate
FROM `Orders` AS OrderCross
INNER JOIN OrderItem ON OrderCross.OrderID = OrderItem.OrderID
INNER JOIN StaffPrivateInfo ON OrderCross.StaffID = StaffPrivateInfo.StaffID
INNER JOIN Products ON OrderItem.ProductID = Products.ProductID
INNER JOIN Store on OrderCross.StoreID = Store.StoreID
WHERE OrderCross.OrderID = 1001;