/*Create a stored procedure called sp_products listing a specified product ordered during a specified month and year. 
The product name, month, and year will be input parameters for the stored procedure. 
Display the product name, unit price, and units in stock from the Products table, and the supplier name from the Suppliers table.*/
alter proc sp_products (@i_ProductName varchar(40), @i_month varchar(20), @i_year int) AS
BEGIN
	DECLARE @INTMONTH INT, @MONTHCOMP VARCHAR(30);
	SET @MONTHCOMP = CONCAT(@i_month, ' 1 ', @i_year);
	SET @INTMONTH = (SELECT MONTH(@MONTHCOMP));

	SELECT p.ProductName, p.UnitPrice, p.UnitsInStock, s.Name, o.OrderDate
	FROM Products AS p
		INNER JOIN Suppliers AS s
			ON p.SupplierID = s.SupplierID
		INNER JOIN OrderDetails AS od
			ON p.ProductID = od.ProductID
		INNER JOIN Orders AS o
			ON od.OrderID = o.OrderID
	WHERE p.ProductName like @i_ProductName
	AND DATEPART(MM, o.OrderDate) = @INTMONTH
	AND DATEPART(YY, o.OrderDate) = @i_year
END

SELECT MONTH(

-- Testing Stored Procedure
EXEC sp_products '%tofu%', 'December', 1992

/* Create a stored procedure called sp_unit_prices listing the products where the unit price is between particular values. 
The two unit prices will be input parameters for the stored procedure. 
Display the product id, product name, English name, and unit price from the Products table.
*/
CREATE PROC sp_unit_prices (@i_val1 money, @i_val2 money) AS
BEGIN
	SELECT ProductID, ProductName, EnglishName, UnitPrice
	FROM Products
	WHERE UnitPrice BETWEEN @i_val1 AND @i_val2
END

-- Testing Stored Procedure
EXEC sp_unit_prices 6.00, 8.00

/* Create a stored procedure called sp_customer_city displaying the customers living in a particular city. 
The city will be an input parameter for the stored procedure. Display the customer id, company name, address, city and phone from the Customers table. 
*/
CREATE PROC sp_customer_city (@i_city nvarchar(15)) AS 
BEGIN
	SELECT CustomerID, CompanyName, Address, City, Phone
	FROM Customers
	WHERE City = @i_city
END

-- Testing Stored Procedure
EXEC sp_customer_city 'Paris'

/* Create a stored procedure called sp_reorder_qty to show when the reorder level subtracted from the units in stock is less than a specified value. 
The unit value will be an input parameter for the stored procedure. 
Display the product id, product name, units in stock, and reorder level from the Products table, and the supplier name from the Suppliers table.
*/
CREATE PROC sp_reorder_qty (@i_unit smallint) AS
BEGIN
	SELECT 
		p.ProductID, 
		p.ProductName, 
		p.UnitsInStock,
		p.ReorderLevel,
		s.Name
	FROM Products AS p
		INNER JOIN Suppliers AS s
			ON p.SupplierID = s.SupplierID
	WHERE (p.UnitsInStock - p.ReorderLevel) < @i_unit
END

-- Testing Stored Procedure
EXEC sp_reorder_qty 9

/*Create a stored procedure called sp_shipping_date where the shipped date is equal to the order date plus 10 days. 
The shipped date will be an input parameter for the stored procedure. 
Display the order id, order date and shipped date from the Orders table, the company name from the Customers table
and the company name from the Shippers table.
*/
CREATE PROC sp_shipping_date (@i_ShippedDate smalldatetime) AS
BEGIN
	SELECT o.OrderID, o.OrderDate, o.ShippedDate, c.CompanyName, s.CompanyName
	FROM Orders AS o
		INNER JOIN Customers AS c
			ON o.CustomerID = c.CustomerID
		INNER JOIN Shippers AS s
			ON o.ShipperID = s.ShipperID
	WHERE DATEADD(day, 10, o.OrderDate) = @i_ShippedDate
END

-- Testing Stored Procedure
EXEC sp_shipping_date '1993-11-29'

/*Create a stored procedure called sp_del_inactive_cust to delete customers that have no orders. 
The stored procedure should delete 1 row.*/
CREATE PROC sp_del_inactive_cust AS
BEGIN
	DELETE Customers WHERE CustomerID IN(
										SELECT CustomerID
										FROM Customers AS c
										EXCEPT 
										SELECT CustomerID
										FROM Orders AS o
										)
END

EXEC sp_del_inactive_cust