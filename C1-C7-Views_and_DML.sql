-- PART C - INSERT, UPDATE, DELETE and VIEWS
/*Create a view called vw_supplier_items listing the distinct suppliers and the items they have shipped. 
Display the supplier id and name from the Suppliers table, and the product id and product name from the Products table. 
*/
CREATE VIEW vw_supplier_items
AS 
	SELECT DISTINCT s.SupplierID, s.Name, p.ProductID, p.ProductName
		FROM Suppliers AS s
			INNER JOIN Products AS p
				on s.SupplierID = p.SupplierID
GO;
-- Testing View
SELECT *
FROM vw_supplier_items ORDER BY Name, ProductID;

/*Create a view called vw_employee_info to list all the employees in the Employee table. 
Display the employee id, last name, first name, and birth date. 
Format the name as first name followed by a space followed by the last name. 
*/
CREATE VIEW vw_employee_info
AS
	SELECT EmployeeID, (FirstName + ' ' + LastName) AS FULL_NAME, BIRTHDATE
	FROM Employees
GO
-- Testing View
SELECT *
FROM vw_employee_info WHERE EmployeeID IN (3,6,9)

/*Using the UPDATE statement, change the fax value to Unknown for all rows in the Customers table where the current fax value is null (22 rows affected).*/
UPDATE Customers SET Fax = 'Unknown' WHERE Fax IS NULL;

/*Create a view called vw_order_cost to list the cost of orders. 
Display the order id and order_date from the Orders table, the product id from the Products table, 
the company name from the Customers table and the order cost. 
To calculate the cost of the orders, use the formula: (OrderDetails.Quantity * OrderDetails.UnitPrice).
*/
CREATE VIEW vw_order_cost
AS 
	SELECT  o.OrderID, 
			o.OrderDate, 
			p.ProductID, 
			c.CompanyName,
			(od.Quantity * od.UnitPrice) as price
		FROM Orders AS o
			INNER JOIN OrderDetails AS od
				ON o.OrderID = od.OrderID
			INNER JOIN Products AS p
				ON od.ProductID = p.ProductID
			INNER JOIN Customers AS c
				on o.CustomerID = c.CustomerID
GO;
-- Testing View
SELECT * 
FROM vw_order_cost
WHERE orderID BETWEEN 10100 AND 10200 
ORDER BY ProductID

/*Using the INSERT statement, add a row to the Suppliers table with a supplier id of 16 and a name of ‘Supplier P’.*/
INSERT INTO Suppliers (SupplierID, Name) VALUES(16, 'Supplier P')

/*Using the UPDATE statement, increase the unit price in the Products table by 15% for rows with a current unit price less than $5.00 (2 rows affected).*/
UPDATE Products SET UnitPrice = (UnitPrice * 1.15) WHERE UnitPrice < 5

/*Create a view called vw_orders to list orders. 
Display the order id and shipped date from the Orders table, and the customer id, company name, city, and country from the Customers table. */
CREATE VIEW vw_orders
AS 
	SELECT 
		o.OrderID, 
		o.ShippedDate,
		c.CustomerID,
		c.CompanyName,
		c.City,
		c.Country
	FROM orders AS o
		INNER JOIN Customers AS c
			ON o.CustomerID = c.CustomerID
GO

-- Testing view
SELECT *
FROM vw_orders 
WHERE ShippedDate BETWEEN '1993-01-01' AND '1993-01-31'  
ORDER BY CompanyName, Country
