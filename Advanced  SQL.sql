CREATE Database AssignmentDB;
USE AssignmentDB;
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2)
);
INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATE,
FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
INSERT INTO Sales (SaleId, ProductID, Quantity, SaleDate) VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11'); 

-- QUESTION 6
WITH ProductRevenue AS (
    SELECT 
        p.ProductName, 
        (p.Price * s.Quantity) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
)
SELECT * FROM ProductRevenue 
WHERE TotalRevenue > 3000;

-- QUESTION 7
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category, 
    COUNT(ProductID) AS TotalProducts, 
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

-- QUESTION 8
CREATE VIEW vw_ProductBasicInfo AS
SELECT ProductID, ProductName, Price
FROM Products;

UPDATE vw_ProductBasicInfo 
SET Price = 1300 
WHERE ProductID = 1;

-- QUESTION 9
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN catName VARCHAR(50))
BEGIN
    SELECT * FROM Products WHERE Category = catName ;
    END //
    
-- QUESTION 10
CREATE TRIGGER AfterProductDelete
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price);
END;