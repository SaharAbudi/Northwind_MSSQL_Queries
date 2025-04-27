USE Northwind
-- Query 26: Orders with Specific Freight and Date Conditions
SELECT *
FROM Orders AS O
WHERE O.Freight NOT BETWEEN 3 AND 35 
  AND DATEPART(DAY, O.OrderDate) % 2 = 0
-- Definition: Filters orders with freight outside the range of 3 and 35, and orders placed on even days of the month.

-- Query 27: Orders with Specific Freight and Date Conditions (Alternate)
SELECT *
FROM Orders AS O
WHERE (O.Freight < 8 OR O.Freight > 35)
  AND DATEPART(DAY, O.OrderDate) % 2 = 0
-- Definition: Equivalent to the previous query, but uses OR to filter freight that is less than 8 or greater than 35, with orders placed on even days.

-- Query 28: Products with Specific Name and Quantity Conditions
SELECT P.ProductName, P.UnitPrice, P.QuantityPerUnit
FROM Products AS P
WHERE (P.ProductName LIKE '[GD]%' OR P.ProductName LIKE '_____')
  AND P.QuantityPerUnit LIKE '%OZ%'
-- Definition: Filters products where the product name starts with 'G' or 'D', or has exactly 5 characters, and the quantity per unit contains 'OZ'.

-- Query 29: Employees with Specific Last Name and Birth Date Conditions
SELECT E.LastName, E.City
FROM Employees AS E
WHERE E.LastName LIKE '[BDF]%vo%' 
  AND MONTH(E.BirthDate) % 2 = 0
-- Definition: Filters employees whose last name starts with 'B', 'D', or 'F' and contains 'vo', and their birth month is an even month.

-- Query 30: Products with Supplier Information
SELECT P.ProductName, P.UnitPrice, S.CompanyName, S.City
FROM Products AS P
INNER JOIN Suppliers AS S
  ON S.SupplierID = P.SupplierID
-- Definition: Joins the Products table with the Suppliers table to get product names, unit prices, and supplier company names and cities.

-- Query 31: Products Supplied by Finnish Suppliers
SELECT P.ProductName, P.UnitPrice, S.Country
FROM Products AS P
INNER JOIN Suppliers AS S
  ON S.SupplierID = P.SupplierID
WHERE S.Country LIKE 'FINLAND'
-- Definition: Filters products that are supplied by suppliers located in Finland.

-- Query 32: Orders with Required and Shipped Dates, Customer Information
SELECT O.OrderID, O.RequiredDate, O.ShippedDate, C.*
FROM Orders AS O
INNER JOIN Customers AS C
  ON C.CustomerID = O.CustomerID
WHERE O.ShippedDate > O.RequiredDate
ORDER BY C.CompanyName
-- Definition: Joins orders with customers to get orders where the shipped date is later than the required date, and orders the results by customer company name.

-- Query 33: Order Details with Revenue Calculation
SELECT P.ProductName, OD.Quantity, P.UnitPrice AS 'ListPrice', OD.UnitPrice AS 'SellingPrice'
FROM [Order Details] AS OD
INNER JOIN Products AS P
  ON P.ProductID = OD.ProductID
-- Definition: Joins order details with products to retrieve the product name, quantity, unit price (list price), and selling price for each order.

-- Query 34: Order Details with Revenue Calculation
SELECT P.ProductName, OD.Quantity, P.UnitPrice AS 'ListPrice', OD.UnitPrice AS 'SellingPrice',
       OD.Quantity * OD.UnitPrice AS 'Revenue'
FROM [Order Details] AS OD
INNER JOIN Products AS P
  ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
  ON O.OrderID = OD.OrderID
-- Definition: Joins order details, products, and orders, and calculates the revenue (quantity * selling price) for each order.

-- Query 35: Customer Revenue Information
SELECT C.CompanyName, O.OrderID, OD.UnitPrice, OD.Quantity, OD.Quantity * OD.UnitPrice AS Revenue
FROM Customers AS C
INNER JOIN Orders AS O
  ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
  ON O.OrderID = OD.OrderID
-- Definition: Joins customers, orders, and order details to get customer company names, order details, and the revenue for each order.

-- Query 36: Revenue Information for Orders in Odd Months
SELECT C.CompanyName, O.OrderDate, OD.Quantity * OD.UnitPrice AS Revenue
FROM Customers AS C
INNER JOIN Orders AS O
  ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
  ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) % 2 != 0
-- Definition: Joins customers, orders, and order details to get the revenue for orders placed in odd months.

-- Query 37: Customers with Orders and Specific Conditions
SELECT C.CustomerID, C.CompanyName, O.OrderDate, P.ProductName
FROM Customers AS C
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] AS OD
  ON OD.OrderID = O.OrderID
INNER JOIN Products AS P
  ON P.ProductID = OD.ProductID
WHERE C.CompanyName NOT LIKE '[AB]%' 
  OR O.OrderDate > '2000-01-30'
ORDER BY C.CompanyName, O.OrderDate DESC
-- Definition: Joins customers, orders, order details, and products to retrieve customers with specific order conditions, excluding those with company names starting with 'A' or 'B', and orders placed after January 30, 2000.

-- Query 38: Count of Orders in Specific Quarters (1996, 1997, 1998)
SELECT YEAR(O.OrderDate) AS 'Y',
       DATEPART(QUARTER, O.OrderDate) AS 'Q',
       COUNT(*) AS 'COUNT'
FROM Orders AS O
WHERE DATEPART(QUARTER, O.OrderDate) = 4 
  AND YEAR(O.OrderDate) IN (1996, 1997, 1998)
GROUP BY YEAR(O.OrderDate), DATEPART(QUARTER, O.OrderDate)
-- Definition: This query counts the number of orders placed in the fourth quarter of the years 1996, 1997, and 1998.

-- Query 39: Count of Orders by Quarter and Year for Specific Quantity Range
SELECT DATEPART(QUARTER, O.OrderDate),
       DATEPART(YEAR, O.OrderDate),
       COUNT(*)
FROM Orders AS O
INNER JOIN [Order Details] AS OD
  ON OD.OrderID = O.OrderID
WHERE OD.Quantity NOT BETWEEN 5 AND 30
GROUP BY DATEPART(QUARTER, O.OrderDate), DATEPART(YEAR, O.OrderDate)
-- Definition: This query counts the number of orders by quarter and year where the quantity is not between 5 and 30.

-- Query 40: Count of Orders by Year and Quarter
SELECT YEAR(O.OrderDate) AS 'Y',
       DATEPART(QUARTER, O.OrderDate) AS 'Q',
       COUNT(*) AS 'Count of Orders'
FROM Orders AS O
GROUP BY YEAR(O.OrderDate), DATEPART(QUARTER, O.OrderDate)
-- Definition: This query counts the total number of orders by year and quarter.

-- Query 41: Employee Count by City
SELECT E.City, COUNT(*) AS 'C'
FROM Employees AS E
INNER JOIN Orders AS O
  ON E.EmployeeID = O.EmployeeID
GROUP BY E.City
-- Definition: This query counts the number of employees working in each city who have processed orders.

-- Query 42: Total Number of Orders
SELECT COUNT(*)
FROM Orders AS O
-- Definition: This query returns the total number of orders in the Orders table.

-- Query 43: Total Number of Employees
SELECT COUNT(*)
FROM Employees AS E
-- Definition: This query returns the total number of employees in the Employees table.

-- Query 44: Customer Order Count and Freight Sum
SELECT C.CustomerID, C.CompanyName,
       COUNT(*) AS CountOrders,
       SUM(O.Freight) AS SumFreight
FROM Customers AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName
-- Definition: This query counts the number of orders and sums the freight charges for each customer.

-- Query 45: Supplier Product Count, Average and Maximum Price
SELECT S.CompanyName, 
       COUNT(*) AS CountSuppProducts,
       AVG(P.UnitPrice) AS AvgPrice,
       MAX(P.UnitPrice) AS 'MAX Price'
FROM Suppliers AS S 
INNER JOIN Products AS P
  ON P.SupplierID = S.SupplierID
GROUP BY S.SupplierID, S.CompanyName
-- Definition: This query counts the number of products from each supplier, calculates the average product price, and finds the maximum product price.

-- Query 46: Customer Revenue and Order Details Count for Orders with Quantity > 10
SELECT C.CompanyName, 
       SUM(OD.UnitPrice * OD.Quantity) AS SumRevenue,
       COUNT(*) AS CountOrderDetails
FROM Customers AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] AS OD
  ON OD.OrderID = O.OrderID
WHERE OD.Quantity > 10
GROUP BY C.CustomerID, C.CompanyName
ORDER BY SumRevenue DESC
-- Definition: This query calculates the total revenue and counts the order details for each customer where the quantity is greater than 10, ordering the results by revenue.

-- Query 47: Supplier Quantity Sum for Products with UnitPrice > 10
SELECT S.CompanyName, SUM(OD.Quantity) AS SumQuantities
FROM Suppliers AS S 
INNER JOIN Products AS P
  ON P.SupplierID = S.SupplierID
INNER JOIN [Order Details] AS OD
  ON OD.ProductID = P.ProductID
WHERE P.UnitPrice > 10
GROUP BY S.SupplierID, S.CompanyName
-- Definition: This query sums the quantities of products supplied by each supplier where the unit price is greater than 10.

-- Query 48: Monthly Order Count and Average Freight
SELECT MONTH(O.OrderDate) AS OrderMonth,
       COUNT(*) AS CountOrders,
       AVG(O.Freight) AS AvgFreight
FROM Orders AS O
GROUP BY MONTH(O.OrderDate)
ORDER BY OrderMonth
-- Definition: This query counts the number of orders and calculates the average freight for each month.

-- Query 49: Customer Country and Company Count
SELECT C.Country, COUNT(*) AS CountCompanies
FROM Customers AS C
GROUP BY C.Country
-- Definition: This query counts the number of companies in each country.

-- Query 50: Total Revenue from Order Details
SELECT SUM(OD.UnitPrice * OD.Quantity) AS TotalRevenue
FROM [Order Details] AS OD
-- Definition: This query calculates the total revenue from the order details table by summing the unit price multiplied by the quantity.

-- Query 51: Order Year, Month, and Sum of Freight
SELECT YEAR(O.OrderDate) AS OrderYear, 
       MONTH(O.OrderDate) AS OrderMonth,
       SUM(O.Freight) AS SumFreight
FROM Orders AS O
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
ORDER BY OrderYear, OrderMonth
-- Definition: This query calculates the sum of freight charges for each month and year, and orders the results by year and month.

-- Query 52: Customer Country and City Order Count
SELECT C.Country, COUNT(*)
FROM Customers AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
GROUP BY C.Country, C.City
-- Definition: This query counts the number of orders for customers in each country and city.

-- Solution A: Customer Order Count
SELECT C.CustomerID, C.CompanyName, COUNT(*)
FROM CUSTOMERS AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY C.CompanyName
-- Definition: This query counts the number of orders for each customer and orders the results by company name.

-- Solution B: Customer Order Details Count
SELECT C.CustomerID, C.CompanyName, COUNT(*)
FROM CUSTOMERS AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] AS OD
  ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY C.CompanyName
-- Definition: This query counts the number of order details for each customer and orders the results by company name.

-- Query 53: Count of Customers
SELECT COUNT(*)
FROM CUSTOMERS AS C
-- Definition: This query returns the total count of customers.

-- Query 54: Count of Customers with Orders
SELECT COUNT(*) 
FROM CUSTOMERS AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
-- Definition: This query counts the number of customers who have placed orders.

-- Query 55: Count of Customers with Order Details
SELECT COUNT(*) 
FROM CUSTOMERS AS C 
INNER JOIN Orders AS O
  ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] AS OD
  ON OD.OrderID = O.OrderID
-- Definition: This query counts the number of customers with order details.

-- Query 56: Customers with More Than 15 Orders
USE Northwind
SELECT C.CustomerID, C.CompanyName,
       COUNT(*) AS 'Count of Orders'
FROM Customers AS C 
INNER JOIN ORDERS AS O 
  ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(*) > 15
-- Definition: This query counts the number of orders for each customer and filters to show only customers with more than 15 orders.

-- Query 57: Customers with Revenue > 30,000 and Freight >= 30
SELECT C.CustomerID, C.CompanyName, 
       SUM(OD.UnitPrice * OD.Quantity) AS 'SumRevenue'
FROM Customers AS C
INNER JOIN Orders AS O
  ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
  ON O.OrderID = OD.OrderID
WHERE O.Freight >= 30 
  AND OD.UnitPrice * OD.Quantity NOT BETWEEN 10 AND 300
GROUP BY C.CustomerID, C.CompanyName
HAVING SUM(OD.UnitPrice * OD.Quantity) > 30000
-- Definition: This query calculates the total revenue for each customer, filtering to include only those with freight charges of 30 or more and total revenue exceeding 30,000.

-- Query 58: Customer Revenue for Products with QuantityPerUnit like '%Boxes%' and UnitsInStock > 50
SELECT C.CustomerID, C.CompanyName,
       SUM(OD.Quantity * OD.UnitPrice) AS 'Sum of Revenue'
FROM Customers AS C 
INNER JOIN Orders AS O 
  ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD 
  ON O.OrderID = OD.OrderID 
INNER JOIN Products AS P 
  ON OD.ProductID = P.ProductID
WHERE P.QuantityPerUnit LIKE '%Boxes%' 
  AND P.UnitsInStock > 50 
GROUP BY C.CustomerID, C.CompanyName
HAVING SUM(OD.Quantity * OD.UnitPrice) > 1500
ORDER BY 'Sum of Revenue' DESC
-- Definition: This query calculates the total revenue for each customer based on products that come in boxes and have more than 50 units in stock, filtering customers with total revenue greater than 1500.

-- Query 59: Customer Countries with at Least 10 Companies
SELECT C.Country, COUNT(*)
FROM Customers AS C
GROUP BY C.Country
HAVING COUNT(*) >= 10
-- Definition: This query counts the number of customers in each country and filters to show only countries with at least 10 customers.

-- Query 60: Customer Countries with 'OWNER' in Contact Title
SELECT C.Country, COUNT(*)
FROM Customers AS C
WHERE C.ContactTitle LIKE '%OWNER%'
GROUP BY C.Country
HAVING COUNT(*) >= 10
-- Definition: This query counts the number of customers with 'OWNER' in the contact title, grouped by country, and filters to show only countries with at least 10 customers.
