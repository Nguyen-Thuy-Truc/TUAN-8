USE TRUC
CREATE DATABASE BANHANG
ON PRIMARY
( NAME = 'BANHANG', FILENAME = 'D:\CSDL\BANHANG.mdf' , 
SIZE = 4048KB , MAXSIZE = 10240KB , FILEGROWTH = 20%)
LOG ON
( NAME = 'BANHANG_log', FILENAME = 'D:\CSDL\BANHANG_log1.ldf' , 
SIZE = 1024KB , MAXSIZE = 10240KB , FILEGROWTH = 10%)

USE TRUC
CREATE TABLE Products
(ProductID INT PRIMARY KEY NOT NULL,
ProductName VARCHAR(255) NOT NULL,
SupplierID INT,
UnitPrice DECIMAL(10,2),
UnitInStock INT)

CREATE TABLE Customers
(CustomerID INT PRIMARY KEY,      
CompanyName VARCHAR(255),        
Address VARCHAR(255),           
City VARCHAR(100),             
Region VARCHAR(100),             
Country VARCHAR(100))

CREATE TABLE Employees 
(EmployeeID INT PRIMARY KEY NOT NULL,      
LastName VARCHAR(100),           
FirstName VARCHAR(100),         
BirthDate DATE,                  
City VARCHAR(100))  

CREATE TABLE Orders 
(OrderID INT PRIMARY KEY,         
CustomerID INT,                  
EmployeeID INT,                
OrderDate DATE,                  
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID))

CREATE TABLE OrderDetails 
(OrderID INT NOT NULL,                    
ProductID INT NOT NULL,                  
UnitPrice DECIMAL(10,2),      
Quantity INT,                     
Discount DECIMAL(5,2),           
PRIMARY KEY (OrderID, ProductID),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID))

CREATE TABLE Suppliers 
(SupplierID INT PRIMARY KEY NOT NULL,
SupplierName VARCHAR(255))

INSERT INTO Products VALUES
(1, 'Cà phê đen', 1, 25000, 100),
(2, 'Trà xanh', 2, 20000, 50),
(3, 'Bánh ngọt', 3, 15000, 30),
(4, 'Panacotta', 4, 16000, 20)

INSERT INTO Customers VALUES
(1, 'Công ty A', '123 Đường ABC', 'Hà Nội', 'Miền Bắc', 'Việt Nam'),
(2, 'Công ty B', '456 Đường XYZ', 'TP. HCM', 'Miền Nam', 'Việt Nam'),
(3, 'Công ty C', '789 Đường DEF', 'Đà Nẵng', 'Miền Trung', 'Việt Nam'),
(4, 'Banali', '356 Lê Lợi', 'LonDon', 'Trung','Anh'),
(5, 'Manali', '123 Lê Lai', 'Boise', 'Idaho', 'Hoa Kỳ'),
(6, 'Beauty', '64 Trần Hưng Đạo', 'Paris', 'France', 'Pháp'),
(7, 'GoGo', '25 Lê Quang Định', 'Lyon', 'Rhone', 'Pháp'),
(8, 'Meme', '25 Lê Quang Định', 'Mianma', 'Rhone', 'Pháp')

INSERT INTO Employees VALUES
(1, 'Nguyễn', 'Văn A', '1990-05-10', 'Hà Nội'),
(2, 'Trần', 'Thị B', '1995-08-20', 'TP. HCM'),
(3, 'Lê', 'Văn C', '2000-12-15', 'Đà Nẵng'),
(4, 'Phạm', 'Vy', '1960-03-10', 'Lyon'),
(5, 'Nguyễn', 'My', '1960-01-13', 'LonDon'),
(6, 'Trần', 'Mạnh', '1960-09-01', 'Boise'),
(7, 'Huỳnh', 'Vinh', '1960-03-02', 'Paris')

INSERT INTO Orders VALUES
(1, 1, 1, '2025-03-10'),
(2, 2, 2, '2025-03-11'),
(3, 3, 3, '2025-03-12'),
(4, 4, 4, '1997-07-12'),
(5, 5, 5, '1997-01-04')

INSERT INTO OrderDetails VALUES
(1, 1, 25000, 2, 0.05),
(2, 2, 20000, 1, 0.00),
(3, 3, 15000, 5, 0.10),
(4, 4, 16000, 4, 0)

INSERT INTO Suppliers VALUES
(1, 'Nhà cung cấp X'),
(2, 'Nhà cung cấp Y'),
(3, 'Nhà cung cấp Z')

/*TUAN5*/
SELECT*FROM Products 
SELECT CustomerID,CompanyName,City, Phone FROM Customers 
SELECT ProductID, ProductName, UnitPrice FROM Products
SELECT EmployeeID, LastName +''+ FirstName AS EmployeeName, Year(getdate()) - Year(BirthDate) Age FROM Employees
SELECT*FROM Customers WHERE CONTACTTITLE LIKE '0%'
SELECT*FROM Customers WHERE City IN ('LonDon', 'Boise', 'Paris')
SELECT*FROM Customers WHERE CustomerID LIKE 'V%' AND City = 'Lyon'
SELECT*FROM Customers WHERE Fax IS NULL
SELECT*FROM Customers WHERE Fax IS NOT NULL
SELECT*FROM Employees WHERE BirthDate <= '1960-12-31'
SELECT*FROM Products WHERE QuantityPerUnit LIKE '%Boxes%'
SELECT*FROM Products WHERE UnitPrice > 12.00 AND UnitPrice < 20.00
SELECT*FROM Orders WHERE OrderDate >= '1996-09-01' AND OrderDate <= '1990-10-01' ORDER BY CustomerID, OrderDate DESC
SELECT*FROM Orders WHERE OrderDate >= '1997-10-01' AND OrderDate < '1998-01-01' ORDER BY OrderDate
SELECT OrderID, CustomerID, EmployeeID, OrderDate, DATENAME(WEEKDAY, OrderDate) AS WEEKDAY 
FROM Orders WHERE MONTH(OrderDate) = 12 AND YEAR(OrderDate) = 1997 AND DATENAME(WEEKDAY, OrderDate) = 'Saturday' OR DATENAME(WEEKDAY, OrderDate) = 'Sunday'
SELECT ProductID, ProductName, UniPrice, UnitInStock, UniPrice*UnitInStock AS Total FROM Products 
SELECT TOP 5 * FROM Customers WHERE City LIKE 'M%'
SELECT TOP 2 EmployeeID, LastName + ' ' + FirstName AS EmployeeName, YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees ORDER BY Age DESC
SELECT*FROM Products WHERE UnitInStock < 20
SELECT OrderID, ProductID, UnitPrice, Quantity, Discount, (UnitPrice*Quantity - 0.2*Discount) AS Total FROM OrderDetails

/*TUAN6*/
SELECT Customers.CustomerID, Customers.CompanyName, Customers.Address, Orders.OrderID, Orders.OrderDate 
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE OrderDate >=' 1997-07-01' AND OrderDate <= '1997-08-01'
ORDER BY OrderDate DESC

SELECT*FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.OrderID 
WHERE OrderDate >= '1997-01-01' AND OrderDate <= '1997-01-15'

SELECT*FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON Orders.OrderID = OrderDetails.OrderID
WHERE OrderDate = '1997-07-12'

ALTER TABLE Orders ADD RequiredDate DATE NULL
INSERT INTO Orders VALUES 
(6, 1, 1, '1997-04-01', '1997-03-22'),
(7, 2, 2, '1997-04-01', '1997-03-22')

SELECT Orders.OrderID, Customers.CompanyName, Orders.OrderDate, Orders.RequiredDate
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE MONTH(OrderDate) IN (4, 9) AND YEAR(OrderDate) = 1997
ORDER BY Customers.CompanyName, Orders.OrderDate DESC

INSERT INTO Employees VALUES (14, 'Fuller', 'Mary', '2005-01-04', 'TP. HCM')
INSERT INTO Orders VALUES (17, 1, 14, '1996-12-06', '1996-12-17')

SELECT*FROM Orders INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.LastName = 'Fuller'

INSERT INTO Orders VALUES (41, 1, 1, '1997-05-15', '1997-06-01')
INSERT INTO OrderDetails VALUES (41, 1, 25000, 1, 0)
SELECT*FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE Products.SupplierID IN (1, 3, 6) AND Orders.OrderDate BETWEEN '1997-04-01' AND '1997-06-30'
ORDER BY Products.SupplierID, Products.ProductID

SELECT * FROM Products 
WHERE UnitPrice = (SELECT UnitPrice FROM OrderDetails WHERE Products.ProductID = OrderDetails.ProductID)

INSERT INTO Orders VALUES(10248, 1, 1, '1996-12-14', '1996-12-28')					
INSERT INTO OrderDetails VALUES (10248, 1, 25000, 1,0)
SELECT*FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.OrderID = 10248

INSERT INTO Orders VALUES (9, 1, 1, '1996-07-14', '1996-12-28')

SELECT*FROM Orders INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Orders.OrderDate BETWEEN '1996-07-01' AND '1996-07-31'

SELECT Products.ProductID, Products.ProductName, Orders.OrderID, Orders.OrderDate, Orders.CustomerID, OrderDetails.UnitPrice, OrderDetails.Quantity, OrderDetails.Quantity*OrderDetails.UnitPrice AS Total, DATENAME(WEEKDAY, OrderDate) AS WEEKDAY
FROM OrderDetails INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID 
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE Month(OrderDate) = 12 and Year(OrderDate) = 1996 AND DATENAME(WEEKDAY, OrderDate) = 'Saturday' OR  DATENAME(WEEKDAY, OrderDate) = 'Sunday' 
ORDER BY OrderDetails.ProductID, OrderDetails.Quantity DESC

SELECT Employees.EmployeeID, Employees.LastName + ' ' + Employees.FirstName AS EmployName, Orders.OrderID, Orders.OrderDate, OrderDetails.ProductID, OrderDetails.Quantity, OrderDetails.UnitPrice, OrderDetails.Quantity * OrderDetails.UnitPrice AS Total
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(OrderDate) = 1996

SELECT Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, DATENAME(WEEKDAY, OrderDate) AS WEEKDAY
FROM Orders
WHERE Month(OrderDate) = 12 and Year(OrderDate) = 1996 AND DATENAME(WEEKDAY, OrderDate) = 'Saturday'

SELECT*FROM Employees LEFT JOIN OrderS ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.EmployeeID IS NULL

INSERT INTO Products VALUES (10, 'Phấn phủ', 1, 300000, 9)

SELECT*FROM Products LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.ProductID IS NULL

SELECT*FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL

/*TUAN7*/
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock) VALUES
(20, 'Bánh Quy', 1, 15.00, 500),
(21, 'Nước Ngọt', 2, 10.00, 400),
(22, 'Sữa Chua', 3, 20.00, 50),
(23, 'Cà Phê', 4, 25.00, 100)

INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country) VALUES
('20', 'Công ty X', '123 Lê Lợi', 'Hà Nội', 'Miền Bắc', 'Việt Nam'),
('21', 'Công ty Y', '456 Nguyễn Huệ', 'Hồ Chí Minh', 'Miền Nam', 'Việt Nam'),
('22', 'Công ty Z', '789 Trần Phú', 'Madrid', 'Tây Ban Nha', 'Spain')

INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City) VALUES
(20, 'Nguyễn', 'Linh', '1980-05-15', 'Hà Nội'),
(21, 'Trần', 'Toản', '1990-07-20', 'Hồ Chí Minh'),
(22, 'Lê', 'Mạnh', '1985-10-10', 'Madrid')

ALTER TABLE Orders ADD Shipcity VARCHAR(200)

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate) VALUES
(20, '20', 20, '1997-01-10', '1997-01-20'),
(21, '21', 21, '1997-07-15', '1997-07-25'),
(22, '22', 22, '1997-07-20', '1997-07-30'),
(23, '20', 21, '1998-01-05', '1998-01-15')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, Shipcity) VALUES
(24, '20', 21, '1998-01-05', '1998-01-15', 'Madrid')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, Shipcity) VALUES
(25, '20', 20, '1998-01-10', '1998-01-18', 'Madrid')
SELECT * FROM Orders

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
(20, 21, 15.00, 10, 0),
(21, 22, 10.00, 5, 0),
(22, 23, 20.00, 15, 0.1),
(23, 20, 25.00, 20, 0),
(23, 21, 15.00, 30, 0)

INSERT INTO Suppliers (SupplierID, SupplierName) VALUES
(20, 'Nhà cung cấp X'),
(21, 'Nhà cung cấp Y'),
(22, 'Nhà cung cấp Z'),
(23, 'Nhà cung cấp N')

SELECT Orders.OrderID, Orders.OrderDate, SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) AS TotalAccount
FROM Orders 
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Orders.OrderID, Orders.OrderDate

SELECT Orders.OrderID, Orders.OrderDate, SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) AS TotalAccount
FROM Orders 
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE Orders.Shipcity = 'Madrid'
GROUP BY Orders.OrderID, Orders.OrderDate

SELECT TOP 1 Products.ProductID, Products.ProductName, COUNT(OrderDetails.Quantity) AS CountOfOrders
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductID, Products.ProductName
ORDER BY CountOfOrders DESC

SELECT Customers.CustomerID, Customers.CompanyName, COUNT(Orders.OrderID) AS CountOfOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName

SELECT Employees.EmployeeID, Employees.LastName, Employees.FirstName, 
COUNT(Orders.OrderID) AS CountOfOrders, SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalSales
FROM Employees INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName

SELECT Employees.EmployeeID, Employees.LastName+' '+Employees.FirstName AS EmployName, 
SUM(OrderDetails.Quantity*OrderDetails.UnitPrice)*0.1 AS Salary, DATEPART(MONTH, Orders.OrderDate) AS Month_Salary
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1996
GROUP BY Employees.EmployeeID, Employees.LastName+' '+ Employees.FirstName, DATEPART(MONTH, Orders.OrderDate) 
ORDER BY Month_Salary, Salary DESC

SELECT Customers.CustomerID, Customers.CompanyName, SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) AS TotalAccount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE Orders.OrderDate>= '1996-12-31' AND Orders.OrderDate < '1998-01-01'
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM(OrderDetails.Quantity*OrderDetails.UnitPrice)> 20000

SELECT Customers.CustomerID, Customers.CompanyName, 
SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) AS TotalAccount, COUNT(Orders.OrderID) AS CountOfOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE Orders.OrderDate>= '1996-12-31' AND Orders.OrderDate < '1998-01-01'
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) > 20000
ORDER BY Customers.CustomerID, TotalAccount DESC

CREATE TABLE Categories 
(CategoryID INT PRIMARY KEY, 
CategoryName NVARCHAR(255) NOT NULL)

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(20, 'Thực phẩm'),
(21, 'Đồ uống'),
(22, 'Đồ gia dụng')

ALTER TABLE Products ADD CategoryID INT REFERENCES Categories (CategoryID)

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID) VALUES
(25, 'Bánh táo', 1, 15.00, 500, 20),
(26, 'Coca', 2, 10.00, 400, 21),
(27, 'Panacotta', 3, 20.00, 50, 20),
(28, 'Đèn bàn', 4, 25.00, 100, 22)

SELECT Categories.CategoryID, Categories.CategoryName, SUM(Products.UnitInStock) AS Total_UnitInStock, AVG(Products.UnitPrice) AS Average_UnitPrice
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID, Categories.CategoryName
HAVING SUM(Products.UnitInStock) > 300 AND AVG(Products.UnitPrice) < 25

SELECT Categories.CategoryID, Categories.CategoryName, 
COUNT(Products.ProductID), COUNT(Products.ProductID) AS TotalOfProduct
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID, Categories.CategoryName
HAVING COUNT(Products.ProductID) < 10
ORDER BY Categories.CategoryName, TotalOfProduct

SELECT Products.ProductID, Products.ProductName, SUM(OrderDetails.Quantity) AS SumofQuatity
FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE YEAR(Orders.OrderDate) = 1998 AND MONTH(Orders.OrderDate) IN (1, 2, 3)
GROUP BY Products.ProductID, Products.ProductName
HAVING SUM(OrderDetails.Quantity) > 200

SELECT Customers.CustomerID, Customers.CompanyName, CONCAT(MONTH(Orders.OrderDate), '/', YEAR(Orders.OrderDate)) AS Month_Year, 
SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS Total
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerID, Customers.CompanyName, MONTH(Orders.OrderDate), YEAR(Orders.OrderDate)

SELECT TOP 1 Employees.EmployeeID, Employees.LastName, Employees.FirstName, SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS Tongban
FROM Employees INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1997 AND MONTH(Orders.OrderDate) = 7
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName
ORDER BY Tongban DESC

SELECT TOP 3 Customers.CustomerID, Customers.CompanyName, COUNT(Orders.OrderID) AS TongOrders
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 1996
GROUP BY Customers.CustomerID, Customers.CompanyName
ORDER BY TongOrders DESC

SELECT Employees.EmployeeID, Employees.LastName, Employees.FirstName, COUNT(Orders.OrderID) AS CountOfOrders, 
SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS sumoftotal
FROM Employees INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1997 AND MONTH(Orders.OrderDate) = 3
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName
HAVING SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) > 4000

/*TUAN8*/

SELECT Products.ProductID, Products.ProductName, AVG(OrderDetails.UnitPrice) AS DONGIA_TB
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.UnitPrice > (SELECT AVG(Products.UnitPrice) FROM Products)

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID) 
VALUES	(29, 'Noca', 2, 25.00, 400, 20),
		(30, 'Nica', 3, 20.00, 200, 21)

SELECT * FROM Products
WHERE Products.UnitPrice > (SELECT AVG(Products.UnitPrice) FROM Products WHERE ProductName LIKE 'N%')

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID) 
VALUES	(31, 'Nuci', 2, 250.000, 400, 20),
		(32, 'Nick', 3, 200.000, 200, 21) 

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID) 
VALUES	(33, 'Nini', 2, 250.0000000, 400, 20)

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID) 
VALUES	(34, 'NiM', 2, 25000000.000, 400, 20)

SELECT * FROM Products
WHERE ProductName LIKE 'N%' AND UnitPrice=(SELECT MIN(UnitPrice) FROM Products)

SELECT Products.ProductID, Products.ProductName, Products.UnitPrice
FROM Products INNER JOIN OrderDetails ON Products.ProductID=OrderDetails.ProductID

ALTER TABLE Products ADD ImportPrice MONEY
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, ImportPrice) VALUES
(30, 'Hadalabo', 20, 50000, 300, 40000)

SELECT*FROM Products WHERE Products.ImportPrice > (SELECT MIN(Products.UnitPrice) FROM Products)

INSERT INTO Customers VALUES
(23, 'Công ty M', '34 Lê Lợi','LonDon', 'Trung', 'Trung Quốc'),
(24, 'Công ty N', '44 Nguyễn Văn Dung', 'Madrid', 'France', 'Phap')

SELECT * FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City IN ('LonDon' , 'Madrid')

ALTER TABLE Products ADD QuantityPerUnit VARCHAR(200)

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID, QuantityPerUnit) 
VALUES	(35, 'Kẹo dẻo', 2, 150.00, 200, 20, 'Box')

SELECT * FROM Products
WHERE Products.QuantityPerUnit LIKE '%Box%'
AND Products.UnitPrice < (SELECT AVG(Products.UnitPrice) FROM Products)

SELECT Products.ProductID, Products.ProductName, SUM(OrderDetails.Quantity) AS Total_Quantity
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID 
WHERE OrderDetails.Quantity >= (SELECT MAX(OrderDetails.Quantity) FROM OrderDetails)
GROUP BY Products.ProductID, Products.ProductName

SELECT * FROM Customers
WHERE Customers.CustomerID NOT IN ( SELECT Orders.CustomerID FROM Orders)


INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID, QuantityPerUnit) 
VALUES	(36, 'Kẹo mềm', 1, 150000.00, 300, 21, 'Box12')

ALTER TABLE Products
ALTER COLUMN UnitPrice NUMERIC(15, 2)

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID, QuantityPerUnit) 
VALUES	(37, 'Kẹo cứng', 2, 150000000.00, 200, 20, 'Boxx')

SELECT * FROM Products
WHERE Products.QuantityPerUnit LIKE '%Box%'
AND Products.UnitPrice = (SELECT MAX(Products.UnitPrice) FROM Products)

SELECT * FROM Products
WHERE Products.UnitPrice > (SELECT AVG(Products.UnitPrice) FROM Products
WHERE Products.ProductID <= 5)

SELECT Products.ProductID, Products.ProductName, SUM(OrderDetails.Quantity) AS Total_Quantity, AVG(OrderDetails.Quantity) AS tb
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductID, Products.ProductName
HAVING SUM(OrderDetails.Quantity) > ( SELECT AVG(OrderDetails.Quantity) FROM OrderDetails)

SELECT * FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE OrderDetails.ProductID >= 3

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, Shipcity) VALUES
(26, 1, 20, '1998-07-1', '1998-09-18', 'Madrid')

SELECT Products.ProductID, Products.ProductName
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE Orders.OrderDate>='1998-07-01' AND Orders.OrderDate<'1998-09-30'
GROUP BY Products.ProductID, Products.ProductName
HAVING COUNT(OrderDetails.OrderID) > 20

SELECT * FROM Products
WHERE Products.ProductID NOT IN ( SELECT OrderDetails.ProductID 
FROM OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE Orders.OrderDate>='1996-06-01' AND Orders.OrderDate<'1996-06-30')

SELECT * FROM Employees
WHERE Employees.EmployeeID NOT IN ( SELECT Orders.EmployeeID 
FROM Orders WHERE Orders.OrderDate = GETDATE())

SELECT * FROM Customers
WHERE Customers.CustomerID NOT IN (SELECT Orders.CustomerID FROM Orders 
WHERE YEAR(Orders.OrderDate) = 1997)

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock, CategoryID, QuantityPerUnit) 
VALUES	(38, 'Titan', 1, 15000.00, 500, 20, 'Box123')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, Shipcity) 
VALUES	(28, 3, 20, '1998-07-02', '1998-09-19', 'Min')

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES	(28, 38, 15000.00, 2, 0.04)

SELECT * FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName LIKE 'T%' AND MONTH(Orders.OrderDate) = 7

INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country) VALUES
(25, 'Công ty Q', '123 Lê Lợi', 'Madrid', 'Miền Bắc', 'Việt Nam')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES	(26, 'HIHI A','123 Lê Lợi', 'Hanoi', 'Miền Bắc', 'Việt Nam'),
		(27, 'ME A','123 Lê Lợi', 'Hanoi', 'Miền Bắc', 'Việt Nam'),
		(28, 'MA A','123 Lê Lợi', 'Hanoi', 'Miền Bắc', 'Việt Nam')

SELECT Customers.City, COUNT(Customers.CustomerID) AS Customers_N
FROM Customers
GROUP BY Customers.City
HAVING COUNT(Customers.CustomerID) > 3

--20.Bạn hãy đưa ra câu hỏi cho 3 câu truy vấn sau và cho biết sự khác nhau của 3 
--câu truy vấn này:
--Select ProductId, ProductName, UnitPrice from [Products]
--Where Unitprice>ALL (Select Unitprice from [Products] where 
--ProductName like ‘B%’)
Liệt kê các sản phẩm có đơn giá bán lớn hơn tất cả các sản phẩm có tên bắt đầu bằng chữ 'B'
--Select ProductId, ProductName, UnitPrice from [Products]
--Where Unitprice>ANY (Select Unitprice from [Products] where 
--ProductName like ‘B%’)
Liệt kê các sản phẩm có đơn giá bán lớn hơn ít nhất một sản phẩm có tên bắt đầu bằng chữ 'B'
--Select ProductId, ProductName, UnitPrice from [Products]
--Where Unitprice=ANY (Select Unitprice from [Products] where 
--ProductName like ‘B%’)
Liệt kê các sản phẩm có đơn giá bán bằng với ít nhất một sản phẩm có tên bắt đầu bằng chữ 'B'








