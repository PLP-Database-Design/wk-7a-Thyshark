CREATE TABLE ProductDetail_Non1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(100)
);

INSERT INTO ProductDetail_Non1NF(OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF(OrderID, CustomerName, Product)
SELECT 
    OrderID, 
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail_Non1NF
CROSS APPLY 
    STRING_SPLIT(Products, ',');



CREATE TABLE OrderProducts (
    OrderProductID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    UNIQUE (OrderID, Product)  -- Still enforce uniqueness
);
