/*Create an UPDATE trigger called tr_check_qty on the OrderDetails table to prevent the updating of orders for products in the Products table 
that have units-in-stock less than the quantity ordered.
*/
CREATE TRIGGER tr_check_qty
ON OrderDetails
AFTER UPDATE AS
BEGIN
	DECLARE @O_DIFFSOTCKQUANTITY INT;
	SELECT @O_DIFFSOTCKQUANTITY = (p.UnitsInStock - od.Quantity)
	FROM OrderDetails AS od
		INNER JOIN Products AS p
			ON od.ProductID = p.ProductID
	WHERE od.OrderID = (SELECT OrderID from inserted)
	AND od.ProductID = (SELECT ProductID from inserted)

	IF @O_DIFFSOTCKQUANTITY < 0
		PRINT 'LESS UNITS IN STOCK THAN QUANTITY ORDER.'
END

-- Test Trigger
UPDATE OrderDetails
SET Quantity = 40 WHERE OrderID = 10044
AND ProductID = 77

/*Create an INSTEAD OF INSERT trigger called tr_insert_shippers on the Shippers 
table preventing inserting a row with a company name which already exists. */
CREATE TRIGGER tr_insert_shippers
ON Shippers
INSTEAD OF INSERT AS
BEGIN
	DECLARE @EXIST int;
	SELECT @EXIST = SupplierID
	FROM Suppliers
	WHERE name = (SELECT name FROM inserted)

	IF @EXIST IS NOT NULL
		PRINT 'ERRO NA INSERÇAO'
END

INSERT Shippers
VALUES ( 4, 'Federal Shipping' )