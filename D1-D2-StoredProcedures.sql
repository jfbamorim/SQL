/*Create a stored procedure called sp_emp_info to display the employee id, last name, first name, and phone number from the 
Employees table for a particular employee. The employee id will be an input parameter for the stored procedure.*/
CREATE proc sp_emp_info (@i_EmployeeID int) AS
BEGIN
	SELECT EmployeeID, FirstName, LastName, Phone
	FROM Employees
	WHERE EmployeeID = @i_EmployeeID
END

-- Testing Stored Procedure
EXEC sp_emp_info 7

/*Create a stored procedure called sp_orders_by_dates displaying the orders shipped between particular dates. 
The start and end date will be input parameters for the stored procedure. 
Display the order id, customer id, and shipped date from the Orders table, the company name from the Customer table 
and the shipper name from the Shippers table.*/
CREATE proc sp_orders_by_dates(@i_StartDate smalldatetime, @i_EndDate smalldatetime) AS
BEGIN
	SELECT o.OrderID, o.CustomerID, o.ShippedDate, c.CompanyName, s.CompanyName
	FROM Orders AS o
		INNER JOIN Customers AS c
			ON o.CustomerID = c.CustomerID
		INNER JOIN Shippers AS s
			ON o.ShipperID = s.ShipperID
	WHERE o.ShippedDate BETWEEN @i_StartDate AND @i_EndDate
END

-- Testing Stored Procedure
EXEC sp_orders_by_dates '1991-01-01', '1991-12-31'