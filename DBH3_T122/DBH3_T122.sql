USE JalIhara

-- no 1
SELECT CustomerName, TicketName, CustomerAddress, TicketPrice
FROM TransactionHeader TH
JOIN TransactionDetail TD ON TH.TransactionID=TD.TransactionID
JOIN MsCustomer MC ON TH.CustomerID=MC.CustomerID
JOIN MsTicket MT ON TD.TicketID=MT.TicketID
WHERE CustomerAddress LIKE '%e' AND YEAR(CURRENT_TIMESTAMP)-YEAR(CustomerDOB)>=15


-- no 2
CREATE NONCLUSTERED INDEX IX_MsTicket_TicketName
ON MsTicket(TicketName);


-- no 3
SELECT TicketID, TicketName, CONCAT('Rp.', TicketPrice, '.00') AS TicketPrice
FROM MsTicket
WHERE LEN(TicketName)<=20

-- no 4
SELECT REPLACE(TD.TicketID, 'TC', 'Ticket ') AS TicketID, TicketName, CONVERT(varchar, TicketDate, 6) AS TicketDate, TicketPrice
FROM TransactionDetail TD
JOIN TransactionHeader ON TD.TransactionID=TransactionHeader.TransactionID
JOIN MsTicket MT ON TD.TicketID=MT.TicketID
WHERE YEAR(TransactionDate)=2022

-- no 5
GO
CREATE VIEW Senior_Female_Staff AS 
	SELECT MS.StaffID, concat('Ms./Mrs. ', UPPER(StaffName)) AS StaffName, StaffAddress, LEFT(StaffWorkingShift,1) AS StaffWorkingShift
	FROM MsStaff MS
	JOIN TransactionHeader ON MS.StaffID=TransactionHeader.StaffID
	JOIN TransactionDetail ON TransactionHeader.TransactionID=TransactionDetail.TransactionID
	WHERE StaffGender LIKE 'Female' AND Quantity>=15
GO
SELECT *
FROM Senior_Female_Staff

-- no 6
SELECT TH.TransactionID, TransactionDate, CustomerName, TicketName, DATEDIFF(YEAR, CustomerDOB, CURRENT_TIMESTAMP) AS [CustomerAge]
FROM TransactionHeader TH
JOIN TransactionDetail TD ON TH.TransactionID=TD.TransactionID
JOIN MsTicket ON TD.TicketID=MsTicket.TicketID
JOIN MsCustomer ON TH.CustomerID=MsCustomer.CustomerID
WHERE StaffID IN ('SF003', 'SF008')


-- no 7
SELECT DISTINCT TransactionDetail.TransactionID
FROM TransactionHeader
JOIN TransactionDetail ON TransactionHeader.TransactionID = TransactionDetail.TransactionID
WHERE DAY(TransactionDate) >= 15


-- no 8
SELECT CustomerName, REPLACE(TH.StaffID, 'SF', 'Staff ') AS StaffId, DATEDIFF(YEAR, CustomerDOB, CURRENT_TIMESTAMP) AS [CustomerAge], TicketName, FORMAT(Quantity*TicketPrice, 'C', 'id-ID') AS [TotalTicketPrice]
FROM MsCustomer
JOIN TransactionHeader TH ON MsCustomer.CustomerID=TH.CustomerID
JOIN TransactionDetail ON TH.TransactionID=TransactionDetail.TransactionID
JOIN MsTicket MT ON TransactionDetail.TicketID=MT.TicketID
JOIN MsStaff MS ON TH.StaffID=MS.StaffID
WHERE Quantity<15 AND MONTH(StaffDOB)<6

-- no 9
SELECT CustomerName, CONCAT(SUBSTRING(TicketTypeName, 1, CHARINDEX(' ', TicketTypeName)), ': ', TicketName) AS [Ticket], DATENAME(MONTH, TicketDate) AS [TicketMonth]
FROM MsCustomer
JOIN TransactionHeader TH ON MsCustomer.CustomerID=TH.CustomerID
JOIN TransactionDetail TD ON TH.TransactionID=TD.TransactionID
JOIN MsTicket ON TD.TicketID=MsTicket.TicketID
JOIN MsTicketType ON MsTicket.TicketTypeID=MsTicketType.TicketTypeID
WHERE TicketTypeName LIKE '%Music'


-- no 10
SELECT CustomerName, UPPER(REPLACE(TransactionHeader.TransactionID, 'TD', LEFT(TicketTypeName, 2))) AS CouponCode, TicketName
FROM TransactionHeader
JOIN TransactionDetail TD ON TransactionHeader.TransactionID=TD.TransactionID
JOIN MsTicket MT ON TD.TicketID=MT.TicketID
JOIN MsTicketType ON MT.TicketTypeID=MsTicketType.TicketTypeID
JOIN MsCustomer MC ON TransactionHeader.CustomerID=MC.CustomerID
WHERE DATENAME(WEEKDAY, TransactionDate) IN ('Friday', 'Saturday', 'Sunday') AND Quantity<10