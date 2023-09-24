-- no 1
SELECT StaffName AS 'Staff Name', COUNT(*) AS 'Transaction Amount'
FROM MsStaff MS
JOIN TransactionHeader TH ON MS.StaffID = TH.StaffID
WHERE MONTH(TransactionDate) = 10
GROUP BY StaffName

-- no 2
SELECT [Membership Type] = UPPER(MembershipTypeName), Customer = COUNT(*)
FROM MsMembershipType mt 
JOIN MsCustomer mc ON mt.MembershipTypeID = mc.MembershipTypeID
WHERE MembershipTypeName = 'Regular'
GROUP BY MembershipTypeName

-- no 3
SELECT UPPER(CustomerName) AS [Customer Name], CONCAT('Rp ', SUM(DrinkPrice * Quantity), ',-') AS [Total Price]
FROM MsCustomer mc 
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN MsDrink md ON td.DrinkID = md.DrinkID
GROUP BY CustomerName
ORDER BY [Total Price] ASC

-- no 4
SELECT MD.DrinkID AS [Drink ID], DrinkName AS [Drink Name], AVG(Quantity) AS [Average Quantity], DrinkPrice AS [Price]
FROM TransactionDetail TD
JOIN MsDrink MD ON TD.DrinkID = MD.DrinkID
WHERE DrinkName LIKE '%Tea'
GROUP BY MD.DrinkID, DrinkName, DrinkPrice

-- no 5
SELECT LEFT(StaffName, CHARINDEX(' ',StaffName)) AS [Staff Name], CONCAT(SUM(Quantity),' cups') AS [Total Drink Sold]
FROM MsStaff ms
JOIN TransactionHEader th ON ms.StaffID = th.StaffID
JOIN TransactionDetail td ON td.TransactionID=th.TransactionID
GROUP BY StaffName

-- no 6
SELECT REPLACE(MC.CustomerID, 'CU','Customer') AS [Customer ID],
LEFT(CustomerName, CHARINDEX(' ',CustomerName)) AS [Customer First Name],
SUBSTRING(CustomerName, CHARINDEX(' ', REVERSE(CustomerName)), LEN(CustomerName)) AS [Customer Last Name],
CONCAT('Rp.' ,SUM((DrinkPrice + ToppingPrice)*Quantity)) AS [Total Expense]
FROM MSCustomer MC
JOIN TransactionHeader TH ON MC.CustomerID = TH.CustomerID
JOIN TransactionDetail TD ON TD.TransactionID = TH.TransactionID
JOIN MsDrink MD ON MD.DrinkID = TD.DrinkID
JOIN MsTopping MT ON MT.ToppingID = MD.ToppingID
WHERE CustomerGender = 'Male'
GROUP BY MC.CustomerID, CustomerName
ORDER BY SUM((DrinkPrice + ToppingPrice)*Quantity) DESC

-- no 7
SELECT MD.DrinkID AS [Drink ID] , DrinkName AS [Drink Name], ToppingName AS [Topping], MAX(Quantity) AS [Maximum Quantity], CONCAT('Rp ', DrinkPrice) AS [Price]
FROM MsDrink MD
JOIN TransactionDetail TD ON MD.DrinkID = TD.DrinkID
JOIN MsTopping MT ON MD.ToppingID = MT.ToppingID
WHERE DrinkName LIKE '%Macchiato%'
GROUP BY MD.DrinkID, DrinkName, ToppingName, DrinkPrice
ORDER BY [Maximum Quantity] DESC

-- no 8
SELECT MembershipTypeName, COUNT(*) AS Total
FROM TransactionDetail td
JOIN MsDrink md ON td.DrinkID = md.DrinkID
JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
JOIN MsCustomer mc ON mc.CustomerID = th.CustomerID
JOIN MsMembershipType mmt ON mmt.MembershipTypeID = mc.MembershipTypeID
WHERE CustomerGender = 'Male' AND DAY(TransactionDate) > 15
GROUP BY MembershipTypeName

--no 9
SELECT [Transaction ID] = td.TransactionID, [Transaction Date] = TransactionDate, [Staff ID] = mf.StaffID, [Staff Name] = LEFT(StaffName, CHARINDEX(' ',StaffName)), [Staff Address] = RIGHT(StaffAddress, CHARINDEX(' ',REVERSE(StaffAddress))), [Milk Total Quantity] = SUM(Quantity)
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN MsStaff mf ON th.StaffID = mf.StaffID
JOIN MsDrink md ON td.DrinkID=md.DrinkID
WHERE StaffAddress LIKE '_ %' AND DrinkName LIKE '% Milk%' AND DrinkName NOT LIKE '% % Milk%'
GROUP BY td.TransactionID, TransactionDate, mf.StaffID, StaffName, StaffAddress

-- no 10
SELECT REPLACE(ms.StaffID,'ST','Staff ') AS [Staff ID], StaffName AS [Staff Name], DATEDIFF(YEAR,StaffDOB, GETDATE()) AS [Staff Age], CustomerName AS [Customer Name],   DATEDIFF(YEAR,CustomerDOB, GETDATE()) AS [Customer Age],
SUM(Quantity) AS [Total Quantity]
FROM MsStaff ms
JOIN TransactionHeader th ON ms.StaffID = th.StaffID
JOIN MsCustomer mc ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td ON td.TransactionID = th.TransactionID
JOIN MsDrink md ON md.DrinkID = td.DrinkID
JOIN MsTopping mt ON mt.ToppingID = md.ToppingID
WHERE ToppingName LIKE '% Jelly'
GROUP BY ms.StaffID, StaffName, DATEDIFF(YEAR,StaffDOB, GETDATE()), CustomerName, DATEDIFF(YEAR,CustomerDOB, GETDATE())
ORDER BY ms.StaffID ASC