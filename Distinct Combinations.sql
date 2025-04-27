USE Northwind 
-- Query 61: List of Cities of Customers Ordered by City Name
SELECT DISTINCT C.CITY
FROM CUSTOMERS AS C
ORDER BY C.City
-- Definition: This query returns a list of distinct cities of customers, sorted by city name.

-- Query 62: List of Orders with Product Quantity Greater Than 50
SELECT DISTINCT O.OrderID
FROM [Order Details] AS OD
WHERE OD.Quantity > 50
-- Definition: This query returns a list of distinct order IDs where the quantity of a product ordered is greater than 50.

-- Query 63: Count of Distinct Cities of Customers
SELECT COUNT(DISTINCT C.City)
FROM Customers AS C
-- Definition: This query returns the count of distinct cities where customers are located.

-- Query 64: Count of Cities per Country (Distinct Cities of Customers in Each Country)
SELECT C.Country, COUNT(DISTINCT C.City)
FROM Customers AS C
GROUP BY C.Country
-- Definition: This query returns the count of distinct cities for each country based on customer data.

-- Query 65: Orders by Year with Count of Orders, Order Lines, and Sum of Quantities Sold
SELECT YEAR(O.OrderDate) AS 'Year',
       COUNT(DISTINCT O.OrderID) AS 'Count Orders',
       COUNT(*) AS 'Count Order Details',
       SUM(OD.Quantity) AS 'Sum Quantities'
FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate)
ORDER BY 'Year'
-- Definition: This query returns for each year the count of orders, the number of order lines (details), and the sum of quantities sold.

-- Query 66: Number of Delivery Cities and Order Lines per Product
SELECT P.ProductID, P.ProductName,
       COUNT(DISTINCT O.ShipCity) AS COUNTCities,
       COUNT(O.OrderID) AS COUNTOrders
FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
GROUP BY P.ProductID, P.ProductName
-- Definition: This query returns each product's ID and name, the count of distinct delivery cities, and the count of order lines.

-- Query 67: Customer Details with Fax (Where Fax Exists)
SELECT C.*
FROM Customers AS C
WHERE C.Fax IS NOT NULL
-- Definition: This query returns the details of customers who have a fax number listed.

-- Query 68: All Customers with Order Dates (Including Customers Without Orders)
SELECT C.CompanyName, O.OrderDate
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID
ORDER BY C.CompanyName
-- Definition: This query returns all customers and their order dates, including those without orders, sorted by customer name.

-- Query 69: Customers Who Have Not Placed Any Orders
SELECT C.CompanyName
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL
ORDER BY C.CompanyName
-- Definition: This query returns the names of customers who have not placed any orders.

-- Query 70: All Customers with Order Count (Including Those Without Orders)
SELECT C.CustomerID, C.CompanyName, COUNT(O.OrderID)
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
-- Definition: This query returns all customers and the count of their orders. For customers without orders, the count is 0.

-- Query 71: Customers with Total Freight Cost and Less Than or Equal to 5 Orders
SELECT C.CustomerID, C.CompanyName, SUM(O.Freight)
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(O.OrderID) <= 5
ORDER BY C.CustomerID, C.CompanyName
-- Definition: This query returns customers with total freight cost who have placed 5 or fewer orders, sorted by customer ID and name.

-- Query 72: Customer Product Orders (Order Lines and Quantities Ordered)
SELECT C.CustomerID, C.CompanyName, 
       COUNT(*) AS 'Count Order Lines', 
       COUNT(DISTINCT OD.ProductID) AS 'Count Unique Products',
       SUM(OD.Quantity) AS 'SUM Quantities'
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.CompanyName
-- Definition: This query returns each customer's ID, company name, the count of order lines, the count of unique products, and the total quantities ordered.

-- Query 73: Total Orders and Freight Costs for Orders in 1997 and 1998
SELECT COUNT(*) AS 'Count', SUM(O.Freight) AS 'Sum Freight'
FROM Orders AS O
WHERE YEAR(O.OrderDate) IN (1998, 1997)
-- Definition: This query returns the total number of orders and the total freight cost for orders placed in 1997 and 1998.

-- Query 74: Number of Countries Orders Were Shipped To in 1997 and 1998
SELECT COUNT(DISTINCT O.ShipCountry) AS 'Count Countries'
FROM Orders AS O
WHERE YEAR(O.OrderDate) IN (1997, 1998)
-- Definition: This query returns the number of distinct countries to which orders were shipped in 1997 and 1998.
