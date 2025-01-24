
-- 1. Menggabungkan Tabel Identitas Mahasiswa dengan Akademik untuk Analisis Nilai Mahasiswa
-- Tujuan: Menampilkan data mahasiswa bersama nilai IPS dan IPK berdasarkan semester.
-- Penjelasan: Query ini menggabungkan tabel Identitas_Mahasiswa dan Akademik untuk menampilkan informasi seperti NIM, nama mahasiswa, jenis kelamin, IPS, dan IPK, serta status mahasiswa di setiap semester.

SELECT 
    im.NIM, 
    im.Nama_Mahasiswa, 
    im.Jenis_Kelamin, 
    ak.Semester, 
    ak.IPS, 
    ak.IPK, 
    ak.Status_Mahasiswa
FROM 
    Identitas_Mahasiswa im
JOIN 
    Akademik ak ON im.NIM = ak.NIM;

-- 2. Menggabungkan Tabel Identitas Mahasiswa dengan Kehadiran untuk Menganalisis Kehadiran Mahasiswa
-- Tujuan: Menampilkan data kehadiran mahasiswa untuk setiap mata kuliah dan semester.
-- Penjelasan: Query ini menggabungkan tabel Identitas_Mahasiswa dan Kehadiran untuk melihat jumlah kehadiran dan persentase kehadiran per mata kuliah.

SELECT 
    im.NIM, 
    im.Nama_Mahasiswa, 
    ke.Semester, 
    ke.Mata_Kuliah, 
    ke.Jumlah_Kehadiran, 
    ke.Persentase_Kehadiran
FROM 
    Identitas_Mahasiswa im
JOIN 
    Kehadiran ke ON im.NIM = ke.NIM;

-- 3. Analisis Status Pembayaran dan Beasiswa Mahasiswa dengan Data Keuangan
-- Tujuan: Menampilkan data pembayaran, status pembayaran, dan jenis beasiswa yang diterima mahasiswa.
-- Penjelasan: Query ini menggabungkan Identitas_Mahasiswa dengan Keuangan untuk menunjukkan informasi mengenai pembayaran mahasiswa dan apakah mereka menerima beasiswa.

SELECT 
    im.NIM, 
    im.Nama_Mahasiswa, 
    ke.Semester, 
    ke.Jumlah_Pembayaran, 
    ke.Status_Pembayaran, 
    ke.Jenis_Beasiswa
FROM 
    Identitas_Mahasiswa im
JOIN 
    Keuangan ke ON im.NIM = ke.NIM;

-- 4. Menganalisis Prestasi Non-Akademik Mahasiswa
-- Tujuan: Menampilkan kegiatan non-akademik yang diikuti mahasiswa.
-- Penjelasan: Menggabungkan tabel Identitas_Mahasiswa dengan Aktivitas_Non_Akademik untuk melihat kegiatan non-akademik dan tingkat keterlibatan mahasiswa.

SELECT 
    im.NIM, 
    im.Nama_Mahasiswa, 
    an.Jenis_Kegiatan, 
    an.Nama_Kegiatan, 
    an.Prestasi_Non_Akademik, 
    an.Tingkat_Keterlibatan
FROM 
    Identitas_Mahasiswa im
JOIN 
    Aktivitas_Non_Akademik an ON im.NIM = an.NIM;

-- 5. Menggabungkan Semua Tabel untuk Analisis Lengkap
-- Tujuan: Menganalisis data mahasiswa secara menyeluruh, termasuk identitas, akademik, kehadiran, keuangan, dan prestasi non-akademik.
-- Penjelasan: Query ini menggabungkan seluruh tabel yang relevan untuk mendapatkan gambaran lengkap mengenai mahasiswa, jurusan, nilai akademik, dan prestasi non-akademik.

SELECT 
    im.NIM, 
    im.Nama_Mahasiswa, 
    im.Jenis_Kelamin, 
    ak.Semester, 
    ak.IPS, 
    ak.IPK, 
    ak.Status_Mahasiswa, 
    ke.Mata_Kuliah, 
    ke.Jumlah_Kehadiran, 
    ke.Persentase_Kehadiran, 
    ke.Jumlah_Pembayaran, 
    ke.Status_Pembayaran, 
    ke.Jenis_Beasiswa, 
    an.Jenis_Kegiatan, 
    an.Nama_Kegiatan, 
    an.Prestasi_Non_Akademik, 
    an.Tingkat_Keterlibatan
FROM 
    Identitas_Mahasiswa im
JOIN 
    Akademik ak ON im.NIM = ak.NIM
JOIN 
    Kehadiran ke ON im.NIM = ke.NIM
JOIN 
    Keuangan ke ON im.NIM = ke.NIM
JOIN 
    Aktivitas_Non_Akademik an ON im.NIM = an.NIM;
