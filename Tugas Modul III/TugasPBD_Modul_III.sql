USE RetailStoreDB;

--1. Tampilkan ProdukID dan total uang yang didapat (LineTotal) dari produk tersebut.
SELECT ProductID, LineTotal AS TotalUang FROM Sales.SalesOrderDetail;

--2. Hanya hitung transaksi yang OrderQty (Jumlah beli) >= 2
SELECT ProductID, SUM(OrderQty) AS TotalQty FROM Sales.SalesOrderDetail GROUP BY ProductID HAVING SUM(LineTotal) >=2;

--3. Kelompokan berdasarkan ProductID
SELECT ProductID, COUNT(*) AS JumlahProduct FROM Sales.SalesOrderDetail GROUP BY ProductID;

--4. Filter agar hanya menampilkan produk yang total uangnya (SUM(LineTotal)) diatas $50,000.
SELECT ProductID, SUM(LineTotal) AS TotalQty FROM Sales.SalesOrderDetail GROUP BY ProductID HAVING SUM(LineTotal) >50;

--5. Urutkan dari pendapatan tertinggi
SELECT ProductID, LineTotal FROM Sales.SalesOrderDetail ORDER BY LineTotal DESC;

--6. Ambil 10 produk teratas saja
SELECT TOP 10 ProductID, LineTotal FROM Sales.SalesOrderDetail ORDER BY LineTotal DESC;