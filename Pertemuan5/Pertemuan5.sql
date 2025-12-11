/* 
SubQuery
Didalam query ada query lagi 

--COMMON TABLE EXPRESSIONS--
Membuat table sementara yang berlaku untuk satu query (Harus dijalani semua) dan akan hilang setelah tidak dipake

--SET OPERATOR--
membandingkan atau menggabung hasil dari 2 query 

UNIO : gabungan jadi query pertama digabung dengan query kedua
UNION All : digabung sama publikasinya
INTESEC : ambil data yang ada di keduanya 
EXCEPT : Ambil data yang ada di query pertama tapi ngk ada di query ke-2 

--GROUPING SETS (ROLL UP & CUBE)--
Sesuai sama apa yang kita mau
beberapa pengelompokan (GROUP BY) dalam satu query"

--ROLL UP--
membuat ringkasan dari kiri ke kanan GROUP BY

--CUBE--
Menghasilkan semua kombinasi 

--WINDOWS FUNCTION--
menghitung nilai agregat tanpa mengelompokan baris

---------------------
PRAKTEK
--------------------- */
USE KampusDB;

------------------------------------------------------------
--SUB QUERY
--menampilkan dosen yang mengajar di matakuliah basis data
------------------------------------------------------------
SELECT NamaDosen
FROM Dosen
WHERE DosenID = (
	SELECT DosenID
	FROM MataKuliah
	WHERE NamaMK = 'Basis Data'
);

--Menampilkan Mahasiswa yang memiliki nilai A
SELECT NamaMahasiswa
FROM Mahasiswa
WHERE MahasiswaID IN (  --pake IN karena Datanya ada banyak
	SELECT MahasiswaID
	FROM Nilai
	WHERE NilaiAkhir = 'A'
);

--Menampilkan daftar prodi yang mahasiswanya >2
SELECT Prodi, TotalMhs
FROM(   --Sub querynya ada di FROM
	SELECT Prodi, COUNT(*) AS TotalMhs
	FROM Mahasiswa
	GROUP BY Prodi
)AS HitungMhs
WHERE TotalMhs > 2;

--menampilkan matakuliah yang diajar oleh dosen dari prodi informatika
SELECT NamaMK
FROM  MataKuliah
WHERE DosenID IN (
	SELECT DosenID
	FROM Dosen
	WHERE Prodi = 'Informatika'
);

--------------------------------------------
--COMMOT TABLE EXPRESSIONS
--CTE untuk daftar mahasiswa Informatika
--------------------------------------------
WITH MhsIF AS (
	SELECT *
	FROM Mahasiswa
	WHERE Prodi = 'Informatika'
)
SELECT NamaMahasiswa, Angkatan
FROM MhsIF

--CTE untuk menghitung Jumlah Mahaiswa per prodi
WITH JumlahPerProdi AS (
	SELECT Prodi, COUNT(*) AS TotalMahasiswa
	FROM Mahasiswa
	GROUP BY Prodi
)
SELECT *
FROM JumlahPerProdi;

-----------------------------------------------------------
--SET OPERATOR
--UNION: Menggabungkan daftar nama dosen dan nama mahasiswa
-----------------------------------------------------------
SELECT NamaDosen AS Nama
FROM Dosen 
UNION
SELECT NamaMahasiswa 
FROM Mahasiswa;

--UNION ALL: Menggabungkan ruangan yang kapasitasnya >40 dan <40
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas > 40
UNION ALL
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas < 40;

--INTERSECT: mahasiswa yang ada di table KRS DAN table nilai
SELECT MahasiswaID
FROM KRS
INTERSECT
SELECT MahasiswaID
FROM Nilai

--EXCEPT: Mahasiswa yang terdapat di table KRS tapi belum memiliki nilai
SELECT MahasiswaID
FROM KRS
EXCEPT
SELECT MahasiswaID
FROM Nilai

---------------------------------------------------------------------
--ROLL UP: RollUp jumlah Mahasiswa per prodi dan total keseluruhan
---------------------------------------------------------------------
SELECT Prodi, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY ROLLUP(Prodi);

---------------------------------------------------------
--CUBE: Jumlah mahasiswa berdasarkan prodi dan angkatan
---------------------------------------------------------
SELECT Prodi, Angkatan,  COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY CUBE (Prodi, Angkatan)

---------------------------------------------------------------------
--GROUPNG SET
--Total mahasiswa berdasarkan prodi, angkatan, dan total keseluruhan
---------------------------------------------------------------------
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY GROUPING SETS(
	(Prodi), --Subtotal per Prodi
	(Angkatan), -- Subtotal Per Angkatan
	() -- Grand Total/ total mahasiswa
);

--------------------------------------------
--WINDOWS FUNCTION
--Menampilkan mahaiswa 
--------------------------------------------
SELECT
	NamaMahasiswa,
	Prodi,
	COUNT(*) OVER (PARTITION BY Prodi) AS TotalMahasiswaPerProdi
FROM Mahasiswa;