CREATE TABLE ProductDetail_1NF AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(Product) AS Product
FROM (
    SELECT 
        OrderID,
        CustomerName,
        unnest(string_to_array(Products, ',')) AS Product
    FROM ProductDetail
) AS split_products;



CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;


ALTER TABLE Orders ADD PRIMARY KEY (OrderID);
ALTER TABLE OrderItems ADD PRIMARY KEY (OrderID, Product);

ALTER TABLE OrderItems
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
