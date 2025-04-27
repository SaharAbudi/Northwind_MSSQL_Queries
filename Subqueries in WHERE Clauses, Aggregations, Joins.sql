USE Northwind
-- Query 72: Products with Units in Stock Greater Than the Average Units in Stock
SELECT *
FROM products AS p
WHERE p.UnitsInStock > 
  (SELECT AVG(p.UnitsInStock)
   FROM Products AS p)
-- Definition: This query returns products with units in stock greater than the average units in stock across all products.

-- Query 73: Orders with Freight Greater Than the Average Freight Plus 100
SELECT C.CompanyName, O.OrderDate, O.Freight
FROM Customers AS C INNER JOIN Orders AS O
ON O.CustomerID = C.CustomerID
WHERE O.Freight > 
  (SELECT AVG(O.Freight)
   FROM Orders AS O) + 100
-- Definition: This query returns customer company names, order dates, and freight charges where the freight charge is greater than the average freight by 100.

-- Query 74: Most Recent Order of a Specific Customer (HANARI CARNES)
SELECT DISTINCT C.CompanyName
FROM Customers AS C INNER JOIN Orders AS O
ON O.CustomerID = C.CustomerID
WHERE O.OrderDate = 
  (SELECT MAX(O.OrderDate)
   FROM Customers AS C INNER JOIN Orders AS O
   ON O.CustomerID = C.CustomerID
   WHERE C.CompanyName LIKE 'HANARI CARNES')
-- Definition: This query returns the most recent order date for the customer "HANARI CARNES."

-- Query 75: Products in the Same Category as 'TOFU', Excluding 'TOFU'
SELECT P.ProductName
FROM PRODUCTS AS P 
WHERE P.CategoryID = 
  (SELECT P.CategoryID
   FROM Products AS P
   WHERE P.ProductName LIKE 'TOFU')
AND P.ProductName NOT LIKE 'TOFU'
-- Definition: This query returns the products that belong to the same category as "TOFU", excluding "TOFU".

-- Query 76: Product with Maximum Unit Price
SELECT P.ProductName
FROM PRODUCTS AS P
WHERE P.UnitPrice = 
  (SELECT MAX(P.UnitPrice)
   FROM Products AS P)
-- Definition: This query returns the product with the maximum unit price.

-- Query 77: Suppliers for Products Ordered by 'ALFKI'
SELECT DISTINCT S.CompanyName
FROM Suppliers AS S INNER JOIN Products AS P
ON P.SupplierID = S.SupplierID
WHERE P.ProductID IN (
  SELECT DISTINCT OD.ProductID
  FROM Orders AS O INNER JOIN [Order Details] AS OD
  WHERE O.CustomerID LIKE 'ALFKI')
-- Definition: This query returns the supplier company names for the products ordered by customer "ALFKI."

-- Query 78: Customers in the UK with Orders by Employees from the USA
SELECT DISTINCT C.CompanyName 
FROM Customers AS C INNER JOIN Orders AS O
ON O.CustomerID = C.CustomerID
WHERE C.Country LIKE 'UK'
AND O.EmployeeID IN 
  (SELECT E.EmployeeID
   FROM Employees AS E 
   WHERE E.Country LIKE 'USA')
-- Definition: This query returns customer company names in the UK who placed orders with employees from the USA.

-- Query 79: Employees with the Earliest and Latest Birthdates
SELECT E.FirstName, E.LastName, E.BirthDate
FROM Employees AS E
WHERE E.BirthDate = 
  (SELECT MIN(e.BirthDate)
   FROM Employees AS E) 
OR E.BirthDate = 
  (SELECT MAX(e.BirthDate)
   FROM Employees AS E)
-- Definition: This query returns employees with the earliest and latest birthdates.

-- Query 80: Employees with the Oldest and Youngest Birthdates and Labels
SELECT E.FirstName, E.LastName, E.BirthDate, 'OLD' AS 'INFO'
FROM Employees AS E
WHERE E.BirthDate = 
  (SELECT MIN(e.BirthDate)
   FROM Employees AS E) 
UNION
SELECT E.FirstName, E.LastName, E.BirthDate, 'YOUNG'
FROM Employees AS E
WHERE E.BirthDate = 
  (SELECT MAX(e.BirthDate)
   FROM Employees AS E)
-- Definition: This query returns the employees with the oldest and youngest birthdates and labels them as "OLD" and "YOUNG."

-- Query 81: Suppliers for Products Ordered by Customer 'ALFKI'
SELECT DISTINCT S.CompanyName
FROM Suppliers AS S INNER JOIN Products AS P
ON P.SupplierID = S.SupplierID
WHERE P.ProductID IN
  (
  SELECT DISTINCT OD.ProductID
  FROM Orders AS O INNER JOIN [Order Details] AS OD
  ON OD.OrderID = O.OrderID
  WHERE O.CustomerID LIKE 'ALFKI'
  )
-- Definition: This query returns the distinct company names of suppliers for the products ordered by customer 'ALFKI'.

-- Query 82: Customers in the UK with Orders Handled by Employees from the USA
SELECT DISTINCT C.CompanyName
FROM Customers AS C INNER JOIN Orders AS O
ON O.CustomerID = C.CustomerID
WHERE C.Country LIKE 'UK'
AND O.EmployeeID IN
  (
  SELECT E.EmployeeID
  FROM Employees AS E
  WHERE E.Country LIKE 'USA'
  )
-- Definition: This query returns the company names of customers in the UK whose orders were handled by employees from the USA.

-- Query 83: Full Names of Managers
SELECT E.FirstName + ' ' + E.LastName AS FullName, E.EmployeeID
FROM Employees AS E
WHERE E.EmployeeID IN (SELECT DISTINCT E.ReportsTo FROM Employees AS E)
-- Definition: This query returns the full names and employee IDs of all managers (employees who manage others).

-- Query 84: Categories with Above-Average Unit Price for 'PRODUCE' Category
SELECT C.CategoryName
FROM Categories AS C INNER JOIN Products AS P
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryID, C.CategoryName
HAVING AVG(P.UnitPrice) > 
  (SELECT AVG(P.UnitPrice)
   FROM Products AS P INNER JOIN Categories AS C
   ON C.CategoryID = P.CategoryID
   WHERE C.CategoryName = 'PRODUCE')
-- Definition: This query returns categories where the average unit price of products is higher than the average unit price in the 'PRODUCE' category.

-- Query 85: Customers' Order Details with First Order Year and Quarter
USE Northwind
SELECT O.OrderDate, O.Freight,
  (SELECT YEAR(MIN(O.OrderDate)) FROM Orders AS O) AS FirstYear,
  (SELECT DATEPART(QUARTER, MIN(O.OrderDate)) FROM Orders AS O) AS FirstQuarter
FROM Customers AS C INNER JOIN Orders AS O
ON O.CustomerID = C.CustomerID
-- Definition: This query returns the order date, freight, and the year and quarter of the customer's first order for each customer.

-- Query 86: Customers' Revenue and Contribution Percentage to the Company
USE Northwind
SELECT C.CompanyName, 
  SUM(OD.UnitPrice * OD.Quantity) AS SUMRevenue,
  SUM(OD.UnitPrice * OD.Quantity) * 100 / 
  (SELECT SUM(OD.UnitPrice * OD.Quantity)
   FROM [Order Details] AS OD) AS 'Percent'
FROM Customers AS C INNER JOIN Orders AS O
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName
-- Definition: This query returns each customer's total revenue and their percentage contribution to the company's total revenue.

-- Query 87: Customers' Last Order Date and Number of Orders with Freight Condition
USE Northwind
SELECT C.CompanyName, 
  COUNT(O.OrderID) AS NumOrders, 
  MONTH(MAX(O.OrderDate)) AS LastOrderMonth, 
  YEAR(MAX(O.OrderDate)) AS LastOrderYear
FROM Customers AS C LEFT JOIN Orders AS O
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(O.OrderID) = 0 OR
  AVG(O.Freight) <= 
  (SELECT AVG(O.Freight)
   FROM Customers AS C LEFT JOIN Orders AS O
   ON O.CustomerID = C.CustomerID
   WHERE C.City LIKE 'LONDON')
ORDER BY SUM(O.Freight) DESC
-- Definition: This query returns each customer’s number of orders and the month and year of their last order, with only customers who have no orders or have a freight cost lower than the average freight cost of customers in London. The results are ordered by the total freight cost in descending order.
