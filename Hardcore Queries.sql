USE Northwind
-- Query 88: Shippers with Orders Greater Than 250
USE Northwind
SELECT S.ShipperID, S.CompanyName, 
       COUNT(*) AS CountOrders, 
       SUM(O.Freight) AS SumFreight
FROM Shippers AS S 
INNER JOIN Orders AS O ON O.ShipVia = S.ShipperID
GROUP BY S.ShipperID, S.CompanyName
HAVING COUNT(*) > 250;
-- Definition: This query returns the shipper's ID, company name, the number of orders they have shipped, 
-- and the total freight amount for shippers who have shipped more than 250 orders.

-- Query 89: Customers' and Suppliers' Revenue
SELECT C.CompanyName AS 'NAME',
       SUM(OD.Quantity * OD.UnitPrice) AS 'S REV',
       'C' AS 'INFO'
FROM Customers AS C 
INNER JOIN Orders AS O 
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
     ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
UNION
SELECT S.CompanyName,
       SUM(OD.Quantity * OD.UnitPrice),
       'S'
FROM Suppliers AS S 
INNER JOIN Products AS P 
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
     ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.CompanyName
UNION
SELECT '********', 
       SUM(OD.Quantity * OD.UnitPrice),
       'TOTAL'
FROM [Order Details] AS OD
ORDER BY 'INFO';
-- Definition: This query returns the revenue from customers and suppliers, combining both into a summary. 
-- It includes total revenue from customers (labeled as 'C'), suppliers (labeled as 'S'), and the total revenue.

-- Query 90: Employees with Latest Birthdate
SELECT E.FirstName + ' ' + E.LastName AS FullName, YEAR(E.BirthDate) AS BirthYear
FROM Employees AS E
WHERE E.BirthDate = 
  (SELECT MAX(E.BirthDate) FROM Employees AS E);
-- Definition: This query returns the full name and birth year of the employee with the latest (most recent) birthdate.

-- Query 91: Count of Distinct Countries from Employees
SELECT COUNT(DISTINCT E.Country) AS CountriesCount
FROM Employees AS E;
-- Definition: This query returns the count of distinct countries that employees belong to.

-- Query 92: Count of Distinct Countries Using Subquery
SELECT COUNT(*) 
FROM 
  (SELECT DISTINCT E.Country FROM Employees AS E) AS T1;
-- Definition: This query returns the count of distinct countries from the subquery that selects unique countries of employees.

-- Query 93: Suppliers' Price Difference for 'BEVERAGES' Category
SELECT S.CompanyName, 
       AVG(P.UnitPrice) - 
       (SELECT AVG(P.UnitPrice) FROM PRODUCTS AS P) AS 'Diff'
FROM Suppliers AS S 
INNER JOIN Products AS P 
INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID
     ON P.SupplierID = S.SupplierID
WHERE C.CategoryName LIKE 'BEVERAGES'
GROUP BY S.SupplierID, S.CompanyName;
-- Definition: This query calculates the price difference between the average price of 'BEVERAGES' products 
-- supplied by each supplier and the overall average price across all products.

-- Query 94: Customer Freight and Quantity for '[ABP]%' Customers
SELECT Q1.CompanyName, Q1.Country, Q1.[Sum of Freight], Q2.[Sum of Quantity]
FROM
  (SELECT C.CustomerID, C.CompanyName, C.Country, SUM(O.Freight) AS 'Sum of Freight'
   FROM Customers AS C 
   INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
   WHERE C.CompanyName LIKE '[ABP]%'
   GROUP BY C.CustomerID, C.CompanyName, C.Country) AS Q1
INNER JOIN
  (SELECT O.CustomerID, SUM(OD.Quantity) AS 'Sum of Quantity'
   FROM Orders AS O 
   INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
   GROUP BY O.CustomerID) AS Q2
ON Q1.CustomerID = Q2.CustomerID;
-- Definition: This query returns customer names, countries, the sum of freight costs, 
-- and the total quantity of products ordered for customers whose company names start with '[ABP]%'.

-- Query 95: Products in the Same Category as 'CHAI' and Price Condition
SELECT P.ProductName
FROM PRODUCTS AS P
WHERE P.CategoryID = 
  (SELECT P.CategoryID
   FROM PRODUCTS AS P
   WHERE P.ProductName LIKE 'CHAI')
AND P.UnitPrice BETWEEN
  (SELECT AVG(P.UnitPrice)
   FROM Products AS P 
   INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
   WHERE C.CategoryName LIKE 'PRODUCE') AND 100;
-- Definition: This query returns products that belong to the same category as 'CHAI' and have a unit price 
-- between the average price of products in the 'PRODUCE' category and 100.
-- Query 96: Full Payment of Customers (Revenue + Freight)
USE Northwind
SELECT Q_Rev.CustomerID,
       Q_Freight.CompanyName,
       Q_Rev.[Sum Rev],
       Q_Freight.[Sum Freight],
       Q_Rev.[Sum Rev] + Q_Freight.[Sum Freight] AS 'Full Pay'
FROM 
  (SELECT O.CustomerID,
          SUM(OD.Quantity * OD.UnitPrice) AS 'Sum Rev'
   FROM Orders AS O 
   INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
   GROUP BY O.CustomerID) AS Q_Rev
INNER JOIN
  (SELECT C.CustomerID, C.CompanyName,
          SUM(O.Freight) AS 'Sum Freight'
   FROM Customers AS C 
   INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
   GROUP BY C.CustomerID, C.CompanyName) AS Q_Freight
ON Q_Rev.CustomerID = Q_Freight.CustomerID;
-- Definition: This query returns each customer’s total revenue, total freight, and their combined payment (revenue + freight).

-- Query 97: Average Total Units for Suppliers with More Than 3 Products
SELECT AVG(Q_Su.[Sum of Units]) AS 'AVG TOTAL SUM OF UNITS'
FROM 
  (SELECT P.SupplierID,
          SUM(P.UnitsInStock) AS 'Sum of Units',
          COUNT(*) AS 'Count Products By Suppliers'
   FROM Products AS P
   GROUP BY P.SupplierID) AS Q_Su
WHERE Q_Su.[Count Products By Suppliers] > 3;
-- Definition: This query calculates the average total number of units in stock for suppliers who have more than 3 products.

-- Query 98: Minimum and Maximum Revenue per Employee
SELECT MIN(SumPerEmployee.SUMRevenue) AS MINPerEmp, 
       MAX(SumPerEmployee.SUMRevenue) AS MAXPerEmp
FROM
  (SELECT SUM(OD.UnitPrice * OD.Quantity) AS SUMRevenue
   FROM Orders AS O 
   INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
   GROUP BY O.EmployeeID) AS SumPerEmployee;
-- Definition: This query returns the minimum and maximum total revenue generated by each employee based on their order details.
