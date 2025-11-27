--menampilkan semua data pada table produk
SELECT * FROM Production.Product;

--menampilkan Name, ProductNumber,dan ListPrice
SELECT NAME, ProductNumber, ListPrice FROM Production.Product;

--menampilkan data pakai alias kolom (AS)
SELECT Name AS [Nama Barang], ListPrice AS 'Harga Jual' FROM Production.Product;

--menampilkan harga baru = ListPrice * 1.1
SELECT Name, ListPrice, (ListPrice * 1.1) AS HargaBaru FROM Production.Product;

--menampilkan data dengan menggabungkan string
SELECT Name + '(' + ProductNumber + ')' AS ProdukLengkap FROM Production.Product;

--Filterisasi Data
--menampilkan product yang berwarna red
SELECT Name, Color, ListPrice FROM Production.Product WHERE Color = 'blue';

--menampilkan data yang LIstPricenya lebih dari 1000
SELECT Name, ListPrice FROM Production.Product WHERE ListPrice > 1000;

--menampilkan product yang berwarna black dan harganya diatas 500 (AND)
SELECT Name, Color, ListPrice FROM Production.Product WHERE Color = 'black' AND ListPrice > 500;

--menampilkan product yang berwarna red, blue atau black
SELECT Name, Color FROM Production.Product WHERE Color IN ('Red', 'Blue', 'Black')
ORDER BY Color DESC; --mengurutkan

--menampilkan data yang mengandung data 'Road'
SELECT Name, ProductNumber FROM Production.Product  WHERE Name LIKE '%Road%';

--agregasi dan pengelompokan 
--menghitung total baris
SELECT COUNT(*) AS TotalProduck FROM Production.Product;

--menampilkan warna dan jumlahnya 
SELECT Color, COUNT(*) AS JumlahProduct FROM Production.Product GROUP BY Color;

--menghitung jumlah order orderqyt dan rata2 unit price dari table sales
SELECT ProductID, SUM(OrderQty) AS TotalTerjua, AVG(UnitPrice) AS RataRataHarga FROM Sales.SalesOrderDetail 
GROUP BY ProductID;

--Grouping lebih dari satu kelompok
SELECT Color, Size, COUNT(*) AS Jumlah FROM Production.Product GROUP BY Color, Size;

SELECT * FROM Production.Product;

--Filter Agregasi memakai Having
--menampilka warna dan jumlahnya tetapi jumlahnya lebih dari 20
SELECT Color, COUNT(*) AS Jumlah FROM Production.Product GROUP BY Color HAVING COUNT(*) > 2;

--menampilkan warna yang listpericenya lebih dari 500 dan jumlah warnyanya lebih dari 1
SELECT Color, COUNT(*) AS Jumlah FROM Production.Product WHERE ListPrice >  500 GROUP BY Color HAVING COUNT(*) > 1;

--menampilkan data yang jumlah penjualnya lebih dari 1000
SELECT ProductID, SUM(OrderQty) AS TotalQty FROM Sales.SalesOrderDetail GROUP BY ProductID HAVING SUM(OrderQty) >  10;

--menampilkan data yang rata2 qtynya kurang dari 2
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli  FROM Sales.SalesOrderDetail GROUP BY SpecialOfferID HAVING AVG(OrderQty) > 2;

--menampilkan product yang harganya lebih dari 300 memakai MAX
SELECT Color FROM Production.Product GROUP BY Color HAVING MAX(ListPrice) > 3000;

SELECT Color, ListPrice FROM Production.Product;

--Advance Select dan Order By
--Menampilkan jobtitle dari kabel employee tapi tidak boleh ada duplikat
SELECT DISTINCT JobTitle FROM HumanResources.Employee;

SELECT JobTitle FROM HumanResources.Employee;

--menampilkan produk yang termahal ke murah
SELECT Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC;

--mengambil data 5 produk termahal
SELECT TOP 5 Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC;

--OFFSET FETCH
SELECT Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC OFFSET 2 ROWS FETCH NEXT 4 ROWS ONLY;

SELECT Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC;

SELECT TOP 3 Color, SUM(ListPrice) AS TotalNilaiStok FROM Production.Product WHERE ListPrice > 0 GROUP BY Color ORDER BY TotalNilaiStok DESC;