/*

- Variable: penulisan pake '@'
- Fungsi Buitd it: fungsi bawaan dari sqlnya 
     GETDATE()
     UPPER()LOWER()
- Control of Flow: 
     If, Else, While, Break, begind_end, continue
- ERROR HANDLING: medeteksi kesalahan tapi sistemnya tetap berjalan dengan aman(ngk bakal dijalanin sampai selesai)

=================
VIEW
=================
seperti function yang bisa digunakan berkali"
panggilnya pke SELECT * FROM

STORED PROCEDURE
kumpulan perintah sql database yang bisa dipanngil kapan saja
pake perintha EXEC baru nama procedurenya(nama file function tapi tidak mereturn nilai)

TRIGGER = alarm otomatis
perintah sql yang otomatis jalan saat terjadi suatu aksi di table 
-AFTER: jalan setelah perintah
-instead: menggantikan perintah

UDF
function buatan sendiri yang akan mereturn nilai

==================
LATIHAN
==================
*/


USE KampusDB;
------------------
--VIEW
------------------
--menampilkan daftar ruangan
CREATE OR ALTER VIEW vw_Ruangan --pake alter bisa bebas untuk ubah"
AS
SELECT
    KodeRuangan,
    Gedung,
    Kapasitas
FROM Ruangan;

SELECT * FROM vw_Ruangan;


--view jumlas mahasiswa per prodi
CREATE OR ALTER VIEW vw_JumlahMahasiswaPerProdi
AS
SELECT
    Prodi,
    COUNT(*) AS JumlahMahasiswa
FROM Mahasiswa
GROUP BY Prodi;

SELECT * FROM vw_JumlahMahasiswaPerProdi;


--View menampilkan mahasiswa dan semester yang diambil
CREATE OR ALTER VIEW vw_mahasiswa_krs
AS
SELECT
    m.NamaMahasiswa,
    k.Semester
FROM Mahasiswa m
JOIN krs k ON m.MahasiswaID = k.MahasiswaID;

SELECT * FROM vw_mahasiswa_krs;

-------------------
--STORED
-------------------
--menampilkan semua mahasiswa
CREATE OR ALTER PROCEDURE sp_LihaMahasiswa
AS
BEGIN
    SELECT * FROM Mahasiswa;
END;
--panggil procedure
EXEC sp_LihaMahasiswa;


--SP menambahkan mahasiswa baru
CREATE OR ALTER PROCEDURE sp_TambahMahasiswa
    --variable 2 yang dibutuhkan
    @Nama VARCHAR(100),
    @Prodi VARCHAR(50),
    @Angkatan INT
AS
BEGIN
    INSERT INTO Mahasiswa (NamaMahasiswa, Prodi,Angkatan)
    VALUES (@Nama, @Prodi, @Angkatan);
END;
--cara penulisan pemanggilan
EXEC sp_TambahMahasiswa
'Axel', 'Informatika', 2025;
--cara penulisan ke-2
EXEC sp_TambahMahasiswa
    @Nama = 'peaches',
    @Prodi = 'Informatika',
    @Angkatan = 2025;
--cek apakah data sudah masuk atau belum
SELECT * FROM Mahasiswa;


-----------------
--TRIGGER
-----------------
--Triger dengan nilai kosong
CREATE OR ALTER TRIGGER tgr_CekNilai
ON Nilai --karna akan dilakuin di table nilai
AFTER INSERT --dilakuian setelah insert
AS
BEGIN
    IF EXISTS (
        SELECT * FROM Inserted -- data yang barusan ditambah tapi nilai akhirnya null 
        WHERE NilaiAkhir IS NULL --kalau nilainya null bakla masuk ke blok begin ke-2
    )
    BEGIN
    --Pesan: 
    --16: level error (error karena input user)
    --1: State (penanda error di message)
    RAISERROR('Nilai Tidak Boleh Kosong', 16, 1)
    ROLLBACK;
    END
END;
--tes trigger yang error
INSERT INTO Nilai(MahasiswaID, NilaiAkhir)
VALUES(5, NULL);
--tes trigger yang error
INSERT INTO Nilai(MahasiswaID, NilaiAkhir)
VALUES(5, 90);


-------------
--UDF
-------------
--fungsi konversi nilai
CREATE OR ALTER FUNCTION fn_IndexNilai(@Nilai INT)
RETURNS CHAR(1)
AS
BEGIN
    RETURN 
    CASE
        WHEN @Nilai >= 85 THEN 'A'
        WHEN @Nilai >= 70 THEN 'B'
        WHEN @Nilai >= 55 THEN 'C'
        WHEN @Nilai >= 40 THEN 'D'
        ELSE 'E'
    END
END;

SELECT dbo.fn_IndexNilai(30);

--fungsi cek lulus atau tidak
CREATE OR ALTER FUNCTION fn_StatusLulus(@Nilai CHAR(2))
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN
    CASE 
        WHEN @Nilai IN('A', 'B', 'C')THEN 'Lulus'
        ELSE 'Tidak Lulus'
    END
END;

SELECT dbo.fn_StatusLulus('A');
