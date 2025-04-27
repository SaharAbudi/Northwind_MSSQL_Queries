USE Northwind
-- Query 1: Employees' Details 
Select E.FirstName, E.LastName, E.City, E.BirthDate
From   Employees As E
-- Definition: This query selects the first name, last name, city, and birth date of all employees from the Employees table in the Northwind database.

-- Query 2: Product Details
Select P.ProductID, P.ProductName, P.UnitPrice
From   Products As P
-- Definition: This query selects the product ID, product name, and unit price from the Products table.

-- Query 3: Customer Details
Select C.*
From   Customers As C
-- Definition: This query selects all columns (*) from the Customers table.

-- Query 4: Product Category Details
Select C.CategoryID, C.CategoryName
From   Categories As C
-- Definition: This query selects the category ID and category name from the Categories table.

--Query 5: Product Price Calculations
Select P.ProductName, 
P.UnitPrice, 
P.UnitPrice*3.62 As Shekel,
P.UnitPrice*1.2 As 'After Increase',
P.UnitPrice*0.9 As 'After Discount'  
From   Products As P
--Definition: This query selects the product name and unit price from the Products table. It also calculates the price in Shekels (multiplying the unit price by 3.62), the price after a 20% increase, and the price after a 10% discount.

--Query 6: Employee Full Name and City
Select E.FirstName+' '+E.LastName as FullName, E.City
From   Employees As E
--Definition: This query concatenates the first and last names of employees to create a full name, and selects the full name along with the city of the employees.

--Query 7: Employee Birth Date Information
Select E.FirstName, E.BirthDate, 
Year(E.birthdate) as 'Year Of Birth',
Month(E.birthdate) as 'Month Of Birth' 
From   Employees As E
-- Definition: This query selects the first name and birth date of employees and extracts the year and month of birth using the Year() and Month() functions.

-- Query 8: Orders from Specific Years
SELECT O.* 
FROM Orders AS O 
WHERE YEAR(O.OrderDate) IN (1996, 1998)
-- Definition: Filters orders from the years 1996 and 1998.

-- Query 9: Employees from Specific Cities
SELECT E.* 
FROM Employees AS E 
WHERE E.City IN ('LONDON', 'SEATTLE', 'TACOMA')
-- Definition: Filters employees who live in one of the specified cities.

-- Query 10: Customers from Specific Countries
SELECT C.* 
FROM Customers AS C 
WHERE C.Country IN ('GERMANY', 'MEXICO', 'UK')
-- Definition: Filters customers from Germany, Mexico, or the UK.

-- Query 11: Orders with Specific Freight and ShipVia Conditions
SELECT O.OrderID, O.* 
FROM Orders AS O 
WHERE (O.Freight < 10 OR O.Freight > 100) AND O.ShipVia IN (1, 3)
-- Definition: Filters orders where freight is less than 10 or greater than 100, and the shipping method is either 1 or 3.

-- Query 12: Orders with Excluded Freight Range
SELECT O.OrderID, O.* 
FROM Orders AS O 
WHERE O.Freight NOT BETWEEN 10 AND 100 AND O.ShipVia IN (1, 3)
-- Definition: Equivalent to the previous query but uses the `NOT BETWEEN` operator to exclude the specified range.

-- Query 13: Orders from a Specific Date Range
SELECT O.* 
FROM Orders AS O 
WHERE O.OrderDate BETWEEN '1/1/1998' AND '12/31/1998'
-- Definition: Filters orders placed between January 1, 1998, and December 31, 1998.

-- Query 14: Products with Names Starting with 'G'
SELECT P.* 
FROM Products AS P 
WHERE P.ProductName LIKE 'G%'
-- Definition: Filters products whose names start with the letter 'G'.

-- Query 15: Products with Names Ending with 'A'
SELECT P.* 
FROM Products AS P 
WHERE P.ProductName LIKE '%A'
-- Definition: Filters products whose names end with the letter 'A'.

-- Query 16: Products with Specific Patterns in Names
SELECT P.* 
FROM Products AS P 
WHERE P.ProductName LIKE 'G%A'
-- Definition: Filters products whose names start with 'G' and contain 'A' later in the name.

-- Query 17: Products with 'E' as Second Character in Name
SELECT P.* 
FROM Products AS P 
WHERE P.ProductName LIKE '_E%'
-- Definition: Filters products where the second character of the product name is 'E'.

-- Query 18: Products with 'BOX' in QuantityPerUnit
SELECT P.* 
FROM Products AS P 
WHERE P.QuantityPerUnit LIKE '%BOX%'
-- Definition: Filters products with 'BOX' in their quantity per unit.

-- Query 19: Products with 'OZ' in QuantityPerUnit
SELECT P.* 
FROM Products AS P 
WHERE P.QuantityPerUnit LIKE '%OZ%'
-- Definition: Filters products with 'OZ' in their quantity per unit.

-- Query 20: Employees with First Name of At Least 5 Characters
SELECT E.* 
FROM Employees AS E 
WHERE E.FirstName LIKE '_____%'
-- Definition: Filters employees whose first name contains at least 5 characters.

-- Query 21: Employees with First Name Starting with 'A' and At Least 3 Characters
SELECT E.* 
FROM Employees AS E 
WHERE E.FirstName LIKE 'A__%'
-- Definition: Filters employees whose first name starts with 'A' and has at least 3 characters.

-- Query 22: Orders with Freight Between 8 and 80 for Even Months in 1996 and 1997
SELECT O.OrderID, O.OrderDate, 
       MONTH(O.OrderDate) AS 'M', 
       O.Freight * 1.2 AS 'Freight In Euro'
FROM Orders AS O 
WHERE YEAR(O.OrderDate) IN (1996, 1997) 
      AND MONTH(O.OrderDate) % 2 = 0 
      AND O.Freight BETWEEN 8 AND 80
-- Definition: Filters orders from 1996 and 1997, selects orders from even months, and calculates freight in Euro (applying a 20% increase).

-- Query 23: Employees Born in Specific Years
SELECT E.* 
FROM Employees AS E 
WHERE DATEPART(YEAR, E.BirthDate) IN (1970, 1980, 1990)
-- Definition: Filters employees born in 1970, 1980, or 1990.

-- Query 24: Employees Born Before 1950 and Living in Specific Cities
SELECT E.* 
FROM Employees AS E 
WHERE DATEPART(YEAR, E.BirthDate) <= 1950 AND E.City IN ('Seattle', 'London')
-- Definition: Filters employees born before 1950 and living in Seattle or London.

-- Query 25: Orders from Specific Quarters and Freight Range Exclusion
SELECT O.OrderID, O.OrderDate, 
       DATEPART(QUARTER, O.OrderDate) AS 'Q',
       YEAR(O.OrderDate) AS 'Y', 
       MONTH(O.OrderDate) AS 'M', 
       O.Freight
FROM Orders AS O
WHERE (DATEPART(QUARTER, O.OrderDate) % 2 = 0 AND YEAR(O.OrderDate) = 1996 
       OR DATEPART(QUARTER, O.OrderDate) % 2 != 0 AND YEAR(O.OrderDate) = 1997)
  AND O.Freight NOT BETWEEN 12 AND 350
-- Definition: Filters orders from 1996 in even quarters and from 1997 in odd quarters, excluding orders with freight between 12 and 350.