CREATE DATABASE CustomerSegmentation;
USE CustomerSegmentation;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);
INSERT INTO Orders VALUES
(1,101,'2025-01-10',500),(2,101,'2025-03-15',700),
(3,101,'2025-05-01',800),(4,102,'2025-02-20',1000),
(5,103,'2025-04-05',300),(6,103,'2025-05-10',400),
(7,104,'2025-01-25',1500),(8,104,'2025-03-30',1200),
(9,105,'2025-05-20',2500),(10,105,'2025-05-25',3000);
SELECT * FROM Orders;
SELECT
    CustomerID,
    COUNT(OrderID) AS Frequency,
    SUM(Amount) AS Monetary
FROM Orders
GROUP BY CustomerID;
SELECT
    CustomerID,
    MAX(OrderDate) AS LastPurchaseDate
FROM Orders
GROUP BY CustomerID;
SELECT
    CustomerID,
    MAX(OrderDate) AS LastPurchaseDate,
    COUNT(OrderID) AS Frequency,
    SUM(Amount) AS Monetary
FROM Orders
GROUP BY CustomerID;
SELECT
    CustomerID,
    MAX(OrderDate) AS LastPurchaseDate,
    COUNT(OrderID) AS Frequency,
    SUM(Amount) AS Monetary,

    CASE
        WHEN COUNT(OrderID) >= 3
             AND SUM(Amount) >= 2000
        THEN 'Champion'

        WHEN COUNT(OrderID) >= 2
        THEN 'Loyal Customer'

        WHEN COUNT(OrderID) = 1
        THEN 'At Risk'

        ELSE 'Regular Customer'
    END AS CustomerSegment

FROM Orders
GROUP BY CustomerID;
SELECT
    CustomerID,
    SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
SELECT
    CustomerID,
    DATEDIFF(CURDATE(), MAX(OrderDate)) AS Recency,
    COUNT(OrderID) AS Frequency,
    SUM(Amount) AS Monetary
FROM Orders
GROUP BY CustomerID;
SELECT * FROM CustomerRFM;
DROP VIEW CustomerRFM;
CREATE VIEW CustomerRFM AS
SELECT
    CustomerID,
    DATEDIFF(CURDATE(), MAX(OrderDate)) AS Recency,
    COUNT(OrderID) AS Frequency,
    SUM(Amount) AS Monetary
FROM Orders
GROUP BY CustomerID;
SELECT *,
CASE
    WHEN Recency < 30
         AND Frequency >= 2
         AND Monetary >= 2000
         THEN 'Champion'

    WHEN Recency < 60
         AND Frequency >= 2
         THEN 'Loyal Customer'

    WHEN Recency > 90
         THEN 'At Risk'

    ELSE 'Regular Customer'
END AS Segment
FROM CustomerRFM;

