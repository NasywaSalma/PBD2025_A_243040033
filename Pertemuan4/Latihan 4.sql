USE KampusDB;

-------------------------
--CROSS JOIN
-------------------------
--Menampilkan semua kombinsi Mahasiswa dan Matakuliah
SELECT M.NamaMahasiswa, MK.NamaMK --M itu alias
FROM Mahasiswa AS M
CROSS JOIN MataKuliah AS MK;

--Menampilkan semua kombinasi Dosen dan Ruangan
SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
CROSS JOIN Ruangan R; --total dosen dikali jumlah ruangan makanya jadi 50

-------------------------
--LEFT JOIN
-------------------------
--Menampilkan semua Mahasiswa, termasuk yang belum ambil KRS
SELECT M.NamaMahasiswa, K.MataKuliahID
FROM Mahasiswa M
LEFT JOIN KRS K ON M.MahasiswaID = K.MahasiswaID;

--menampilkan semua matakuliah, termasuk yang belum mempunyai jadwal
SELECT MK.NamaMK, J.Hari
FROM MataKuliah MK
LEFT JOIN JadwalKuliah J ON MK.MataKuliahID = J.MataKuliahID;

-------------------------
--RIGHT JOIN
-------------------------
--menampilkan semua jadwal, walaupun tidak ada matakuliah
SELECT MK.NamaMK, J.Hari
FROM MataKuliah MK
RIGHT JOIN JadwalKuliah J ON MK.MataKuliahID = J.MataKuliahID;

--menampilkan semua ruangan, apakah dipakai di jadwal atau tidak
SELECT R.KodeRuangan, J.Hari
FROM JadwalKuliah J
RIGHT JOIN Ruangan R ON J.RuanganID = R.RuanganID;

-------------------------
--INNER JOIN
-------------------------
--menampilkan gabungan tabel mahasiswa + matakuliah melalui tabel KRS
SELECT M.NamaMahasiswa, MK.NamaMK
FROM KRS K
INNER JOIN Mahasiswa M ON K.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON K.MataKuliahID = MK.MataKuliahID;

--menampilkan matakuliah dan dosen pengampunya
SELECT MK.NamaMK, D.NamaDosen
FROM MataKuliah MK
INNER JOIN Dosen D ON MK.DosenID = D.DosenID;

--Menampilkan Jadwal lengkap MK + Dosen + Ruangan
SELECT MK.NamaMK, D.NamaDosen, R.KodeRuangan, J.Hari
FROM JadwalKuliah J
INNER JOIN MataKuliah MK ON J.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON J.DosenID = D.DosenID
INNER JOIN Ruangan R ON J.RuanganID = R.RuanganID;

--menampilkan nama mahasiswa, nama matakuliah, dan nilai akhir
SELECT M.NamaMahasiswa, MK.NamaMK, N.NilaiAkhir
FROM Nilai N 
INNER JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON N.MataKuliahID = Mk.MataKuliahID;

--Menampilkan dosen dan matakuliah yang diajar
SELECT D.NamaDosen, MK.NamaMK
FROM Dosen D
INNER JOIN MataKuliah MK ON D.DosenID = MK.DosenID;

-------------------------
--SELF JOIN
-------------------------
--Mencari pasangan mahasiswa dari prodi yang sama
SELECT A.NamaMahasiswa AS Mahasiswa1,
		B.NamaMahasiswa AS Mahasiswa2,
		A.Prodi
FROM Mahasiswa A 
INNER JOIN Mahasiswa B ON A.Prodi = B.Prodi 
WHERE A.MahasiswaID < B.MahasiswaID; --agar tidak ada pasangan yang sama (agar tidak ada duplikat)


-------------------------
--LATIHAN
-------------------------
--1.Tampilkan nama mahasiswa beserta prodi-nya dari tabel Mahasiswa,tetapi hanya mahasiswa yang memiliki nilai di tabel Nilai.
SELECT M.NamaMahasiswa, M.Prodi, N.NilaiAkhir
FROM Mahasiswa M
INNER JOIN Nilai N ON M.MahasiswaID = N.MahasiswaID;

--2.Tampilkan nama dosen dan ruangan tempat dosen tersebut mengajar
SELECT D.NamaDosen, R.KodeRuangan
FROM JadwalKuliah J
INNER JOIN Dosen D ON J.DosenID = D.DosenID
INNER JOIN Ruangan R ON J.RuanganID = R.RuanganID;

--3. Tampilkan daftar mahasiswa yang mengambil suatu mata kuliah beserta nama mata kuliah dan dosen pengampu-nya.
SELECT M.NamaMahasiswa, MK.NamaMK, D.NamaDosen
FROM KRS K
INNER JOIN Mahasiswa M ON K.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON K.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen  D ON MK.DosenID = D.DosenID;

--4. Tampilkan jadwal kuliah berisi nama mata kuliah, nama dosen, dan hari kuliah, tetapi tidak perlu menampilkan ruangan.
SELECT MK.NamaMK, D.NamaDosen, J.Hari
FROM JadwalKuliah  J
INNER JOIN MataKuliah MK ON J.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON j.DosenID =  D.DosenID;

--5. Tampilkan nilai mahasiswa lengkap dengan nama mahasiswa, nama mata kuliah, nama dosen pengampu, dan nilai akhirnya.
SELECT M.NamaMahasiswa, MK.NamaMK, D.NamaDosen, N.NilaiAkhir
FROM Nilai N 
INNER JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON N.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON MK.DosenID = D.DosenID;

