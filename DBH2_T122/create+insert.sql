GO
CREATE DATABASE HIToyz
GO
USE HIToyz

USE master
--DROP DATABASE HIToyz
GO
CREATE TABLE MsStaffPosition 
(
    positionID		CHAR(5) CHECK(positionID LIKE 'SP[0-9][0-9][0-9]') PRIMARY KEY,
    positionName	VARCHAR(512),
    salary			INT
);

INSERT INTO MsStaffPosition (positionID, positionName, salary) VALUES ('SP001', 'employee', '4500000');
INSERT INTO MsStaffPosition (positionID, positionName, salary) VALUES ('SP002', 'officer', '5500000');
INSERT INTO MsStaffPosition (positionID, positionName, salary) VALUES ('SP003', 'manager', '7000000');

CREATE TABLE MsCity 
(
    cityID		CHAR(5) CHECK(cityID LIKE 'CI[0-9][0-9][0-9]') PRIMARY KEY,
    cityName	VARCHAR(512)
);

INSERT INTO MsCity (cityID, cityName) VALUES ('CI001', 'Jakarta');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI002', 'Semarang');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI003', 'Kudus');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI004', 'Pati');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI005', 'Rembang');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI006', 'Jogja');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI007', 'Tangerang');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI008', 'Surabaya');
INSERT INTO MsCity (cityID, cityName) VALUES ('CI009', 'Pontianak');


CREATE TABLE MsSupplier 
(
    supplierID		CHAR(5) CHECK(supplierID LIKE 'SP[0-9][0-9][0-9]') PRIMARY KEY,
    supplierName	VARCHAR(512)
);

INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP001', 'Unicorn Toys');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP002', 'Multi Toys');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP003', 'Hell Duck');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP004', 'J-Shop');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP005', 'Gunplatown');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP006', 'Terminal Tamiya');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP007', 'Omocha Hobby');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP008', 'Felo Geek Store');
INSERT INTO MsSupplier (supplierID, supplierName) VALUES ('SP009', 'Wahkhilaf');


CREATE TABLE MsBrand 
(
    brandID		CHAR(5) CHECK(brandID LIKE 'BR[0-9][0-9][0-9]') PRIMARY KEY,
    brandName	VARCHAR(512)
);

INSERT INTO MsBrand (brandID, brandName) VALUES ('BR001', 'Tamiya');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR002', 'Bandai');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR003', 'Hot Toys');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR004', 'Aoshima');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR005', 'Banpresto');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR006', 'ZD Toys');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR007', 'Figure-Rise Model Kit');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR008', 'Kotobukiya');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR009', 'Acrylo');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR010', 'Gaia Notes');
INSERT INTO MsBrand (brandID, brandName) VALUES ('BR011', 'DSPIAE');

CREATE TABLE MsType 
(
    typeID		CHAR(5) CHECK(typeID LIKE 'TP[0-9][0-9][0-9]') PRIMARY KEY,
    typeName	VARCHAR(512)
);

INSERT INTO MsType (typeID, typeName) VALUES ('TP001', '1/144 model kit');
INSERT INTO MsType (typeID, typeName) VALUES ('TP002', '1/100 model kit');
INSERT INTO MsType (typeID, typeName) VALUES ('TP003', '1/60 model kit');
INSERT INTO MsType (typeID, typeName) VALUES ('TP004', 'fixed statue');
INSERT INTO MsType (typeID, typeName) VALUES ('TP005', 'figure');
INSERT INTO MsType (typeID, typeName) VALUES ('TP006', 'water based paint');
INSERT INTO MsType (typeID, typeName) VALUES ('TP007', 'enamel based paint');
INSERT INTO MsType (typeID, typeName) VALUES ('TP008', 'thinner');
INSERT INTO MsType (typeID, typeName) VALUES ('TP009', 'tools');
INSERT INTO MsType (typeID, typeName) VALUES ('TP010', 'Mini 4WD');


GO

CREATE TABLE MsStaff 
(
    staffID			CHAR(5) CHECK(staffID LIKE 'ST[0-9][0-9][0-9]') PRIMARY KEY,
    staffName		VARCHAR(512),
    staffDOB		Date,
    staffAddress	VARCHAR(512),
    staffPositionID	CHAR(5) REFERENCES MsStaffPosition(positionID)
);

INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST001', 'Hans', '2003-02-01', 'Kemanggisan Barat 12', 'SP001');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST002', 'Marvin', '2003-01-05', 'Kemanggisan Timur 11', 'SP002');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST003', 'Zenli', '2003-12-02', 'Anggrek Tengah 12', 'SP002');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST004', 'Alberic', '2002-01-18', 'Syahdan Tenggara 12', 'SP003');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST005', 'Gabriella', '1990-05-02', 'Bekasi Utara 88', 'SP001');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST006', 'Jaysie', '1992-08-12', 'Kijang Timur 14', 'SP002');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST007', 'Glory', '2003-05-12', 'Anggrek Utara 16', 'SP001');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST008', 'Valentino', '1999-12-12', 'Kebon Jeruk 12', 'SP003');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST009', 'Rico', '2003-07-19', 'Kebon Jeruk II 19', 'SP001');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST010', 'Kevin', '1996-11-29', 'Anggrek III 18', 'SP001');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST011', 'Mario', '1992-01-11', 'Syahdan Elit 20', 'SP002');
INSERT INTO MsStaff (staffID, staffName, staffDOB, staffAddress, staffPositionID) VALUES ('ST012', 'Jose', '2003-05-11', 'Alam Sutera Tengah 12', 'SP001');

CREATE TABLE MsCustomer 
(
    customerID		CHAR(5) CHECK(customerID LIKE 'CU[0-9][0-9][0-9]') PRIMARY KEY,
    customerName	VARCHAR(512),
    customerGender	VARCHAR(512),
    phoneNumber		VARCHAR(512),
    nationality		VARCHAR(512),
    cityID			CHAR(5) REFERENCES MsCity(cityID)
);

INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU001', 'Jannette Miyashita', 'Female', '09182331234', 'Japanese', 'CI003');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU002', 'Jusuf Verochka', 'Male', '09812309832', 'Indonesian', 'CI002');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU003', 'Ryuu Danniell', 'Male', '0812931233', 'English', 'CI005');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU004', 'Wells Alaina Younge', 'Female', '0918230983', 'English', 'CI007');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU005', 'Ryou Dianne Charles', 'Male', '09812309834', 'Indonesian', 'CI001');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU006', 'Jones Harlow Boris', 'Male', '0812983242', 'German', 'CI002');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU007', 'Ilary Therese Enid', 'Female', '0192830983', 'English', 'CI004');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU008', 'Amir Sofia Deemer', 'Female', '0192830928', 'German', 'CI008');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU009', 'Eben Maria Romilly', 'Male', '08129038203', 'Indonesian', 'CI006');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU010', 'Terrence Kontatntin Hayter', 'Male', '091823098', 'Japanese', 'CI009');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU011', 'Kaiden Meredith Nona Feen', 'Female', '09081233', 'Japanese', 'CI002');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU012', 'Denis Adamina', 'Male', '091823093', 'Indonesian', 'CI002');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU013', 'Hachirou Hermanson', 'Male', '08120320', 'Indonesian', 'CI005');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU014', 'Shin Vikentiy Victors', 'Female', '08123908', 'German', 'CI003');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU015', 'Ashlet Katerina', 'Female', '098120398', 'Indonesian', 'CI008');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU016', 'Horatio Alfie', 'Male', '081239332', 'Indonesian', 'CI007');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU017', 'Rikuto Lake', 'Male', '0918203982', 'Japanese', 'CI009');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU018', 'Davie Trey Georgene', 'Male', '081239082', 'English', 'Ci004');
INSERT INTO MsCustomer (customerID, customerName, customerGender, phoneNumber, nationality, cityID) VALUES ('CU019', 'Dotty Arkhip', 'Female', '08129384', 'Indonesian', 'Ci008');


CREATE TABLE MsProduct 
(
    productID	CHAR(5) CHECK(productID LIKE 'PR[0-9][0-9][0-9]') PRIMARY KEY,
    productName	VARCHAR(512),
    brandID		CHAR(5) REFERENCES MsBrand(brandID),
    typeID		CHAR(5) REFERENCES MsType(typeID),
    Price		INT
);

INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR001', 'Cooper Fang', 'BR001', 'TP010', 450000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR002', 'Silwolf', 'BR001', 'TP010', 330000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR003', 'Heat Edge', 'BR001', 'TP010', 600000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR004', 'Super Avante', 'BR001', 'TP010', 450000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR005', 'Rowdy Bull', 'BR001', 'TP010', 340000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR006', 'Beat Magnum', 'BR001', 'TP010', 340000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR007', 'Spin Cobra', 'BR001', 'TP010', 900000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR008', 'Geo Emperor', 'BR001', 'TP010', 340000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR009', 'Aerial Gundam', 'BR002', 'TP001', 230000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR010', 'Unicorn Gundam', 'BR002', 'TP001', 210000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR011', 'Sinanju Gundam', 'BR002', 'TP001', 800000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR012', 'Sazabi', 'BR002', 'TP002', 400000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR013', 'RX-78 Gundam', 'BR002', 'TP002', 500000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR014', 'RX-78-2 Gundam', 'BR002', 'TP002', 670000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR015', 'Unicorn Gundam Ver.Ka', 'BR002', 'TP002', 900000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR016', 'Hi Nu Gundam Ver.Ka', 'BR002', 'TP003', 560000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR017', 'ZZ Gundam', 'BR002', 'TP002', 440000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR018', 'Z Gundam', 'BR002', 'TP001', 540000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR019', 'Iron Patriot', 'BR003', 'TP005', 560000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR020', 'Thor End Game Ver', 'BR003', 'TP005', 340000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR021', 'The Mandalorian The Armorer', 'BR003', 'TP005', 900000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR022', 'Captain America 2012', 'BR003', 'TP005', 450000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR023', 'The Flash', 'BR003', 'TP005', 903000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR024', 'Captain Marvel', 'BR003', 'TP005', 340000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR025', 'Miles Morales Spiderman', 'BR003', 'TP005', 600000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR026', 'Cable', 'BR003', 'TP005', 300000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR027', 'Mysterios Iron Man Illusion', 'BR003', 'TP005', 540000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR028', 'GT R Nissan', 'BR004', 'TP003', 900000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR029', 'Skyline GT R R343', 'BR004', 'TP003', 450000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR030', 'Skyline 2000GT', 'BR004', 'TP003', 230000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR031', 'Present Mic', 'BR005', 'TP004', 450000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR032', 'Luffy', 'BR005', 'TP004', 600000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR033', 'Izuku Midoriya', 'BR005', 'TP004', 230000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR034', 'Naruto', 'BR005', 'TP004', 904000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR035', 'Ultraman Agul', 'BR005', 'TP004', 450000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR036', 'Ultraman Evil Tiga', 'BR005', 'TP004', 540000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR037', 'Miku', 'BR005', 'TP004', 780000);
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR038', 'Thor End Game Ver', 'BR006', 'TP005', '500000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR039', 'Gold Spiderman', 'BR006', 'TP005', '450000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR040', 'Iron Man Mark VII', 'BR006', 'TP005', '300000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR041', 'Iron Man Mark VI', 'BR006', 'TP005', '330000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR042', 'Iron Man Mark V', 'BR006', 'TP005', '320000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR043', 'War Machine Mark I', 'BR006', 'TP005', '540000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR044', 'Iron Man Mark III', 'BR006', 'TP005', '310000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR045', 'Iron Man Mark 50', 'BR006', 'TP005', '453000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR046', 'Kamen Rider Kuuga', 'BR007', 'TP005', '410000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR047', 'Kamen Rider Ryuki', 'BR007', 'TP005', '440000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR048', 'Kamen Rider Agito', 'BR007', 'TP005', '520000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR049', 'Kamen Rider Blade', 'BR007', 'TP005', '330000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR050', 'Kamen Rider Den-O', 'BR007', 'TP005', '442000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR051', 'Kamen Rider Rabbit', 'BR007', 'TP005', '320000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR052', 'Armored Core Verdict Day', 'BR008', 'TP001', '402000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR053', 'Armored Core SunShine', 'BR008', 'TP001', '230000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR054', 'Flat Bronze M204', 'BR009', 'TP006', '35000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR055', 'Titanium Gold M209', 'BR009', 'TP006', '35000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR056', 'Eva Yellow C54', 'BR009', 'TP006', '35000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR057', 'Eva Red C53', 'BR009', 'TP006', '35000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR058', 'Violet C48', 'BR009', 'TP006', '40000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR059', 'Skin Beige C47', 'BR009', 'TP006', '35000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR060', 'Primer White P01', 'BR009', 'TP006', '40000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR061', 'Primer Grey P02', 'BR009', 'TP006', '40000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR062', 'Red Brown 203', 'BR010', 'TP007', '70000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR063', 'Sunshine 005', 'BR010', 'TP007', '70000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR064', 'Semi Gloss White 021', 'BR010', 'TP007', '70000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR065', 'Stainless Silver 1000', 'BR010', 'TP007', '70000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR066', 'Natural Brown 014', 'BR010', 'TP007', '70000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR067', 'Stepless Circular Cutter', 'BR011', 'TP009', '800000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR068', 'Sanding Sponge Set SS-S02', 'BR011', 'TP009', '12000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR069', 'Siren Ultimate', 'BR011', 'TP009', '70000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR070', 'Anti Rust Oil', 'BR011', 'TP009', '65000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR071', 'Clamp Holding Handle', 'BR011', 'TP009', '300000');
INSERT INTO MsProduct (productID, productName, brandID, typeID, Price) VALUES ('PR072', 'Sanding Board', 'BR011', 'TP009', '80000');

CREATE TABLE TransactionHeader 
(
    transactionID	CHAR(5) CHECK(transactionID LIKE 'TR[0-9][0-9][0-9]') PRIMARY KEY,
    transactionDate	DATE,
    StaffID			CHAR(5) REFERENCES MsStaff(staffID),
    customerID		CHAR(5) REFERENCES MsCustomer(customerID)
);

INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR001', '2022-01-01', 'ST001', 'CU003');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR002', '2021-05-10', 'ST009', 'CU001');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR003', '2022-11-12', 'ST001', 'CU005');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR004', '2022-09-03', 'ST010', 'CU002');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR005', '2022-10-13', 'ST003', 'CU007');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR006', '2021-06-23', 'ST004', 'CU010');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR007', '2021-07-21', 'ST001', 'CU011');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR008', '2022-04-21', 'ST006', 'CU019');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR009', '2022-08-27', 'ST007', 'CU018');
INSERT INTO TransactionHeader (transactionID, transactionDate, StaffID, customerID) VALUES ('TR010', '2022-09-21', 'ST008', 'CU014');

CREATE TABLE SalesHeader 
(
    salesID		CHAR(5) CHECK(salesID LIKE 'SL[0-9][0-9][0-9]') PRIMARY KEY,
    salesDate	DATE,
    staffID		CHAR(5) REFERENCES MsStaff(staffID),
    supplierID	CHAR(5) REFERENCES MsSupplier(supplierID)
);

INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL001', '2021-09-25', 'ST005', 'SP002');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL002', '2021-05-10', 'ST002', 'SP004');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL003', '2021-11-12', 'ST006', 'SP007');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL004', '2021-09-03', 'ST012', 'SP002');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL005', '2021-10-13', 'ST011', 'SP001');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL006', '2021-06-23', 'ST008', 'SP002');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL007', '2021-07-21', 'ST003', 'SP009');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL008', '2021-04-21', 'ST001', 'SP002');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL009', '2021-08-27', 'ST004', 'SP001');
INSERT INTO SalesHeader (salesID, salesDate, staffID, supplierID) VALUES ('SL010', '2021-09-21', 'ST006', 'SP003');


CREATE TABLE TransactionDetail 
(
    transactionID	CHAR(5),
    productID		VARCHAR(512),
    quantity		INT
);

INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR001', 'PR045', '4');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR001', 'PR076', '2');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR001', 'PR001', '4');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR002', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR004', 'PR006', '6');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR002', '7');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR010', 'PR008', '34');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR008', 'PR053', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR060', '2');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR009', 'PR024', '5');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR005', 'PR023', '6');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR009', '7');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR008', 'PR004', '8');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR001', 'PR056', '56');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR010', 'PR072', '4');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR004', 'PR045', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR006', 'PR002', '2');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR001', 'PR067', '4');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR006', 'PR045', '56');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR045', '2');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR009', 'PR034', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR010', 'PR032', '2');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR010', 'PR023', '5');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR005', 'PR059', '56');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR006', 'PR071', '6');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR007', 'PR056', '7');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR008', 'PR023', '5');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR033', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR004', 'PR023', '6');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR005', 'PR008', '78');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR005', '2');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR001', 'PR003', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR004', 'PR005', '34');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR002', 'PR006', '45');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR009', 'PR008', '3');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR005', 'PR067', '34');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR007', 'PR065', '56');
INSERT INTO TransactionDetail (transactionID, productID, quantity) VALUES ('TR008', 'PR004', '6');

CREATE TABLE SalesDetail 
(
    salesID	VARCHAR(512),
    productID	VARCHAR(512),
    quantity	INT
);

INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL001', 'PR002', '23');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL002', 'PR005', '63');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL003', 'PR006', '42');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL004', 'PR072', '75');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR045', '23');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL006', 'PR065', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL007', 'PR034', '63');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL008', 'PR035', '123');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL009', 'PR054', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL010', 'PR045', '4546');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR023', '554');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL003', 'PR012', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR013', '234');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL002', 'PR015', '34');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL007', 'PR056', '34');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL008', 'PR067', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL006', 'PR049', '52');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR056', '234');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL002', 'PR023', '345');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL004', 'PR072', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('Sl005', 'PR034', '645');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL004', 'PR004', '63');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL002', 'PR054', '235');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL001', 'PR045', '134');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('Sl009', 'PR023', '47');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL008', 'PR023', '64');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL007', 'PR054', '67');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL009', 'PR012', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL010', 'PR012', '56');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL006', 'PR011', '345');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR005', '67');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR023', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL003', 'PR045', '67');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL002', 'PR056', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL001', 'PR065', '67');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL009', 'PR034', '45');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL005', 'PR012', '457');
INSERT INTO SalesDetail (salesID, productID, quantity) VALUES ('SL001', 'PR011', '34');

SELECT * FROM SalesDetail


-- no 1
SELECT LEFT(DATENAME(dw, th.transactionDate), 3) AS DateName, p.productName, td.quantity
FROM TransactionHeader th
JOIN TransactionDetail td ON th.transactionID = td.transactionID
JOIN MsProduct p ON td.productID = p.productID
WHERE DATENAME(dw, th.transactionDate) IN ('Monday', 'Tuesday', 'Wednesday');


-- no 2
ALTER TABLE MsSupplier
ADD supplierCityID CHAR(5);

ALTER TABLE MsSupplier
ADD CONSTRAINT FK_MsSupplier_MsCity
FOREIGN KEY (supplierCityID) REFERENCES MsCity(cityID);

-- no 3
UPDATE MsSupplier
SET supplierCityID = 'CI001'
WHERE CHARINDEX(' ', supplierName) >= 2;


-- no 4
SELECT
  salesID,
  salesDate,
  supplierName,
  ISNULL(supplierCityID, 'Empty') AS CityID
FROM
  SalesHeader
JOIN
  MsSupplier ON SalesHeader.supplierID = MsSupplier.supplierID
WHERE
  ABS(DATEDIFF(MONTH,'2021-01-01', salesDate))<= 4;


-- no 5
SELECT
  LEFT(customerName, 1) + LEFT(SUBSTRING(customerName, CHARINDEX(' ', customerName) + 1, LEN(customerName)), 1) AS CustomerInitial,
  customerName AS customerName,
  nationality,
  cityName,
  transactionDate,
  MsStaff.staffID
FROM
  MsCustomer
JOIN
  TransactionHeader ON MsCustomer.customerID = TransactionHeader.customerID
JOIN
  MsCity ON MsCustomer.cityID = MsCity.cityID
JOIN
  MsStaff ON TransactionHeader.StaffID = MsStaff.staffID
WHERE
  (CHARINDEX(' ', customerName) > 0) AND
  (SUBSTRING(customerName, CHARINDEX(' ', customerName) + 1, LEN(customerName)) <> '') AND
  (nationality = 'English' OR cityName IN ('Kudus', 'Semarang', 'Jakarta'));


-- no 6
DELETE FROM MsSupplier WHERE supplierID = 'SP010'

INSERT INTO MsSupplier (supplierID, supplierName, supplierCityID) VALUES ('SP010', 'GunplaShop', 'CI002');

-- no 7
SELECT
    SL.salesID,
    SL.staffID,
    TD.productID,
    CONVERT(VARCHAR(12), SL.salesDate, 107) AS [Date],
    CASE MONTH(SL.salesDate)
        WHEN 1 THEN 'gennaio'
        WHEN 2 THEN 'febbraio'
        WHEN 3 THEN 'marzo'
        WHEN 4 THEN 'aprile'
        WHEN 5 THEN 'maggio'
        WHEN 6 THEN 'giugno'
        WHEN 7 THEN 'luglio'
        WHEN 8 THEN 'agosto'
        WHEN 9 THEN 'settembre'
        WHEN 10 THEN 'ottobre'
        WHEN 11 THEN 'novembre'
        WHEN 12 THEN 'dicembre'
    END AS [month name in Italy]
FROM
    SalesHeader AS SL
JOIN
    SalesDetail AS SD ON SL.salesID = SD.salesID
JOIN
    TransactionDetail AS TD ON SD.productID = TD.productID
WHERE
    MONTH(SL.salesDate) >= 6
ORDER BY
    SL.salesDate ASC;




-- no 8
SELECT
  Price AS price,
  brandName,
  CONCAT(
    CASE typeName
      WHEN '1/144 model kit' THEN 'HG '
      WHEN '1/100 model kit' THEN 'MG '
      WHEN '1/60 model kit' THEN 'PG '
    END,
    productName
  ) AS productName
FROM
  MsProduct
JOIN
  MsBrand ON MsProduct.brandID = MsBrand.brandID
JOIN
  MsType ON MsProduct.typeID = MsType.typeID
WHERE
  typeName IN ('1/144 model kit', '1/100 model kit', '1/60 model kit');


-- no 9
SELECT
  sh.salesID,
  sh.staffID,
  sd.productID,
  DATENAME(MONTH, sh.salesDate) AS monthName,
  su.supplierName
FROM
  SalesHeader sh
JOIN
  SalesDetail sd ON sh.salesID = sd.salesID
JOIN
  MsSupplier su ON sh.supplierID = su.supplierID
WHERE
  SUBSTRING(DATENAME(MONTH, sh.salesDate), 2, 1) = 'u'
ORDER BY
  sh.salesDate DESC;




-- no 10
SELECT
  CONCAT(
    LEFT(b.brandName, 2),
    SUBSTRING(p.productID, 3, LEN(p.productID))
  ) AS customID,
  b.brandName,
  p.productName,
  td.transactionID
FROM
  MsProduct p
JOIN
  MsBrand b ON p.brandID = b.brandID
JOIN
  TransactionDetail td ON p.productID = td.productID;
