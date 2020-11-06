 /*List the order details where the quantity is between 65 and 70. Display the order id and quantity from the OrderDetails table, 
 the product id and reorder level from the Products table, and the supplier id from the Suppliers table. 
Order the result set by the order id.*/
SELECT 
	od.OrderID, 
	od.Quantity,
	p.ProductID,
	p.ReorderLevel,
	s.SupplierID
FROM OrderDetails AS od
	INNER JOIN Products AS p
		ON od.ProductID = p.ProductID
	INNER JOIN suppliers AS s
		ON p.SupplierID = s.SupplierID
WHERE od.Quantity between 65 AND 70
ORDER BY od.OrderID

/*List the product id, product name, English name, and unit price from the Products table where the unit price is less than $8.00. 
Order the result set by the product id. */
SELECT
	ProductID,
	ProductName,
	EnglishName,
	UnitPrice
FROM Products
WHERE UnitPrice < 8
ORDER BY ProductID

/*List the customer id, company name, country, and phone from the Customers table where the country is equal to Canada or USA. 
Order the result set by the customer id. The query should produce the result set listed below. */
SELECT 
	CustomerID,
	CompanyName,
	Country,
	Phone
FROM Customers
WHERE Country IN ('Canada', 'USA')
ORDER BY CustomerID

/*List the products where the reorder level is equal to the units in stock. Display the supplier id and supplier name from the Suppliers table, 
the product name, reorder level, and units in stock from the Products table. Order the result set by the supplier id. */
SELECT 
	s.SupplierID,
	s.Name,
	p.ProductName,
	p.ReorderLevel,
	p.UnitsInStock
FROM Products AS p
	INNER JOIN Suppliers AS s
		ON p.SupplierID = s.SupplierID
WHERE p.ReorderLevel = p.UnitsInStock
ORDER BY s.SupplierID

/* List the orders where the shipped date is >= 1st Jan 1994 and calculate the length in years from the shipped date to 1st Jan 2019.
Display the order id, and the shipped date from the Orders table, the company name, and the contact name from the Customers table, and the calculated length in years for each order. 
Display the shipped date in the format MMM DD YYYY. Order the result set by order id and the calculated years. */
SELECT 
	o.OrderID,
	CONVERT(VARCHAR, o.ShippedDate, 107) AS ShippedDate,
	c.CompanyName,
	c.ContactName,
	DATEDIFF(year, o.ShippedDate, '2009-01-01') AS 'Length_Years'
FROM Orders AS o
	INNER JOIN Customers AS c
		ON o.CustomerID = c.CustomerID
WHERE o.ShippedDate >= '1994-01-01'
ORDER BY o.OrderID, Length_Years

/* List all the orders where the order date is beetween 1st Jan and 30th Mar 1992, and the cost of the order is >= $1500.00. 
Display the order id, order date, and a new shipped date calculated by adding 10 days to the shipped date from the Orders table, 
the product name from the Products table, the company name from the Customer table, and the cost of the order. 
Format the date order date and the shipped date as MON DD YYYY. Use the formula (OrderDetails.Quantity * Products.UnitPrice) to 
calculate the cost of the order. Order the result set by order id. */
SELECT 
	o.OrderID,
	CONVERT(VARCHAR, o.OrderDate, 107) AS OrderDate,
	CONVERT(VARCHAR, DATEADD(day, 10, o.ShippedDate), 107) AS NewShippedDate,
	p.ProductName,
	c.CompanyName,
	(od.Quantity * p.UnitPrice) as OrderCost
FROM Orders AS o
	INNER JOIN OrderDetails AS od
		ON o.OrderID = od.OrderID
	INNER JOIN Products AS p
		ON od.ProductID = p.ProductID
	INNER JOIN Customers AS c
		ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '1992-01-01' AND '1992-03-30'
AND (od.Quantity * p.UnitPrice) >= 1500
ORDER BY o.OrderID