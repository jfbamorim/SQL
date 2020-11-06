/*List all the orders with a shipping city of Vancouver. 
Display the order from the Orders table, and the unit price and quantity from the OrderDetails table. 
Order the result set by the order id. */
SELECT 
	o.OrderID,
	od.UnitPrice,
	od.Quantity
FROM Orders AS o
	INNER JOIN OrderDetails AS od
		ON o.OrderID = od.OrderID
WHERE o.ShipCity = 'Vancouver'
ORDER BY o.OrderID;
/*List all the orders that have not been shipped (shipped date is null). 
Display the customer id, company name and fax number from the Customers table, and the order id and order date from the Orders table. 
Order the result set by the customer id and order date. */
SELECT 
	c.CustomerID,
	c.CompanyName,
	c.Fax,
	o.OrderID,
	o.OrderDate
FROM Customers AS c
	INNER JOIN Orders AS o
		ON c.CustomerID = o.CustomerID
WHERE o.ShippedDate IS NULL
ORDER BY c.CustomerID, o.OrderDate

/* List the products which contain choc or tofu in their name. 
Display the product id, product name, quantity per unit and unit price from the Products table. 
Order the result set by product id. */
SELECT 
	ProductID,
	ProductName,
	QuantityPerUnit,
	UnitPrice
FROM Products
WHERE ProductName LIKE '%CHOC%'
OR ProductName LIKE '%TOFU%'
ORDER BY ProductID

/*List the number of products and their names beginning with each letter of the alphabet.
Only display the letter and count if there are at least three product names begin with the letter. */
SELECT 
	SUBSTRING(ProductName, 1, 1) AS ProductName,
	COUNT(*) AS Total
FROM Products
GROUP BY SUBSTRING(ProductName, 1, 1)
HAVING COUNT(*) >= 3