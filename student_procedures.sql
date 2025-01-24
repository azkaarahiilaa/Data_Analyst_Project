DELIMITER $$

-- Prosedur untuk Mengambil Data Mahasiswa Berdasarkan NIM
-- Prosedur ini akan digunakan untuk mengambil data lengkap mahasiswa, termasuk nama, jurusan, dan data akademik (IPS dan IPK) berdasarkan NIM.
CREATE PROCEDURE Get_Student_Data_By_NIM(
    IN p_NIM VARCHAR(15)
)
BEGIN
    SELECT
        i.NIM,
        i.Nama_Mahasiswa,
        i.Jenis_Kelamin,
        i.Tanggal_Lahir,
        i.Alamat,
        i.Program_Studi,
        i.Tahun_Masuk,
        a.Semester,
        a.IPS,
        a.IPK,
        a.Total_SKS_Diambil,
        a.Status_Mahasiswa
    FROM
        Identitas_Mahasiswa i
    LEFT JOIN
        Akademik a ON i.NIM = a.NIM
    WHERE
        i.NIM = p_NIM;
END $$

DELIMITER ;

DELIMITER $$

-- Prosedur untuk Mengupdate Status Mahasiswa Berdasarkan NIM dan Semester
-- Prosedur ini memungkinkan untuk memperbarui status mahasiswa di tabel akademik (misalnya, mengubah status dari 'Aktif' menjadi 'Cuti').
CREATE PROCEDURE Update_Student_Status(
    IN p_NIM VARCHAR(15),
    IN p_Semester INT,
    IN p_Status_Mahasiswa ENUM('Aktif', 'Cuti', 'Lulus', 'Drop Out')
)
BEGIN
    UPDATE Akademik
    SET Status_Mahasiswa = p_Status_Mahasiswa
    WHERE NIM = p_NIM AND Semester = p_Semester;
END $$

DELIMITER ;

DELIMITER $$

-- Prosedur untuk Mengambil Data Kehadiran Mahasiswa Berdasarkan NIM dan Semester
-- Prosedur ini akan digunakan untuk mengambil data kehadiran mahasiswa di mata kuliah tertentu berdasarkan NIM dan semester.
CREATE PROCEDURE Get_Attendance_By_NIM_Semester(
    IN p_NIM VARCHAR(15),
    IN p_Semester INT
)
BEGIN
    SELECT
        k.Mata_Kuliah,
        k.Jumlah_Kehadiran,
        k.Persentase_Kehadiran
    FROM
        Kehadiran k
    WHERE
        k.NIM = p_NIM AND k.Semester = p_Semester;
END $$

DELIMITER ;

DELIMITER $$

-- Prosedur untuk Mengambil Data Keuangan Mahasiswa
-- Prosedur ini akan mengambil informasi terkait pembayaran dan beasiswa yang diterima oleh mahasiswa berdasarkan NIM dan semester.
CREATE PROCEDURE Get_Financial_Data_By_NIM_Semester(
    IN p_NIM VARCHAR(15),
    IN p_Semester INT
)
BEGIN
    SELECT
        k.Jumlah_Pembayaran,
        k.Status_Pembayaran,
        k.Jenis_Beasiswa
    FROM
        Keuangan k
    WHERE
        k.NIM = p_NIM AND k.Semester = p_Semester;
END $$

DELIMITER ;

DELIMITER $$

-- Prosedur untuk Menambahkan Data Aktivitas Non-Akademik
-- Prosedur ini memungkinkan Anda untuk menambahkan data aktivitas non-akademik yang diikuti oleh mahasiswa.
CREATE PROCEDURE Add_Non_Academic_Activity(
    IN p_NIM VARCHAR(15),
    IN p_Jenis_Kegiatan VARCHAR(50),
    IN p_Nama_Kegiatan VARCHAR(100),
    IN p_Prestasi_Non_Akademik VARCHAR(100),
    IN p_Tingkat_Keterlibatan ENUM('Aktif', 'Pasif')
)
BEGIN
    INSERT INTO Aktivitas_Non_Akademik
    (NIM, Jenis_Kegiatan, Nama_Kegiatan, Prestasi_Non_Akademik, Tingkat_Keterlibatan)
    VALUES (p_NIM, p_Jenis_Kegiatan, p_Nama_Kegiatan, p_Prestasi_Non_Akademik, p_Tingkat_Keterlibatan);
END $$

DELIMITER ;

DELIMITER $$

-- Prosedur untuk Menghitung Rata-rata IPS dan IPK Mahasiswa
-- Prosedur ini menghitung rata-rata IPS dan IPK dari seorang mahasiswa berdasarkan NIM.
CREATE PROCEDURE Calculate_Avg_Grades(
    IN p_NIM VARCHAR(15)
)
BEGIN
    SELECT
        p_NIM AS NIM,
        AVG(a.IPS) AS Avg_IPS,
        AVG(a.IPK) AS Avg_IPK
    FROM
        Akademik a
    WHERE
        a.NIM = p_NIM
    GROUP BY
        a.NIM;
END $$

DELIMITER ;
