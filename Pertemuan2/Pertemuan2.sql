IF DB_ID('TokoRetailDB') IS NOT NULL
BEGIN
USE master;
DROP DATABASE TokoRetailDB;
END
GO

CREATE DATABASE TokoRetailDB;
GO

USE TokoRetailDB;
GO

CREATE TABLE KategoriProduk (
KategoriID INT IDENTITY(1,1) PRIMARY KEY,
NamaKategori VARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Produk (
ProdukID INT IDENTITY(1001, 1) PRIMARY KEY,
SKU VARCHAR(20) NOT NULL UNIQUE,
NamaProduk VARCHAR(150) NOT NULL,
Harga DECIMAL(10, 2) NOT NULL,
Stok INT NOT NULL,
KategoriID INT NULL,
CONSTRAINT CHK_HargaPositif CHECK (Harga >= 0),
CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),
CONSTRAINT FK_Produk_Kategori
FOREIGN KEY (KategoriID)
REFERENCES KategoriProduk(KategoriID)
);
GO


CREATE TABLE Pelanggan (
PelangganID INT IDENTITY(1,1) PRIMARY KEY,
NamaDepan VARCHAR(50) NOT NULL,
NamaBelakang VARCHAR(50) NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
NoTelepon VARCHAR(20) NULL,
TanggalDaftar DATE DEFAULT GETDATE()
);
GO

CREATE TABLE PesananHeader (
PesananID INT IDENTITY(50001, 1) PRIMARY KEY,
PelangganID INT NOT NULL,
TanggalPesanan DATETIME2 DEFAULT GETDATE(),
StatusPesanan VARCHAR(20) NOT NULL,
CONSTRAINT CHK_StatusPesanan CHECK (StatusPesanan IN ('Baru', 'Proses',
'Selesai', 'Batal')),
CONSTRAINT FK_Pesanan_Pelanggan
FOREIGN KEY (PelangganID)
REFERENCES Pelanggan(PelangganID)
);
GO

CREATE TABLE PesananDetail (
PesananDetailID INT IDENTITY(1,1) PRIMARY KEY,
PesananID INT NOT NULL,
ProdukID INT NOT NULL,
Jumlah INT NOT NULL,
HargaSatuan DECIMAL(10, 2) NOT NULL,
CONSTRAINT CHK_JumlahPositif CHECK (Jumlah > 0),
CONSTRAINT FK_Detail_Header
FOREIGN KEY (PesananID)
REFERENCES PesananHeader(PesananID)
ON DELETE CASCADE,
CONSTRAINT FK_Detail_Produk
FOREIGN KEY (ProdukID)
REFERENCES Produk(ProdukID)
);
GO

INSERT INTO Pelanggan (NamaDepan, NamaBelakang, Email, NoTelepon)
VALUES
('Budi', 'Santoso', 'budi.santoso@email.com', '081234567890'),
('Citra', 'Lestari', 'citra.lestari@email.com', NULL); 

INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Elektronik'),
('Pakaian'),
('Buku');

PRINT 'Data Pelanggan:';
SELECT * FROM Pelanggan;
PRINT 'Data Kategori:';

SELECT * FROM KategoriProduk;

INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-001', 'Laptop Pro 14 inch', 15000000.00, 50, 1), 
('PAK-001', 'Kaos Polos Putih', 75000.00, 200, 2),
('BUK-001', 'Dasar-Dasar SQL', 120000.00, 100, 3); 

PRINT 'Data Produk:';
SELECT P.*, K.NamaKategori
FROM Produk AS P
JOIN KategoriProduk AS K ON P.KategoriID = K.KategoriID;

PRINT 'Uji Coba Error 1 (UNIQUE):';
INSERT INTO Pelanggan (NamaDepan, Email)
VALUES ('Budi', 'budi.santoso@email.com');
GO

PRINT 'Uji Coba Error 2 (FOREIGN KEY):';
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES ('XXX-001', 'Produk Aneh', 1000, 10, 99);
GO

PRINT 'Uji Coba Error 3 (CHECK):';
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES ('NGT-001', 'Produk Minus', -50000, 10, 1);
GO


PRINT 'Data Citra SEBELUM Update:';
SELECT * FROM Pelanggan WHERE PelangganID = 2;
BEGIN TRANSACTION; 
UPDATE Pelanggan
SET NoTelepon = '085566778899'
WHERE PelangganID = 2;
PRINT 'Data Citra SETELAH Update (Belum di-COMMIT):';
SELECT * FROM Pelanggan WHERE PelangganID = 2;
COMMIT TRANSACTION;

PRINT 'Data Citra setelah di-COMMIT:';
SELECT * FROM Pelanggan WHERE PelangganID = 2;

