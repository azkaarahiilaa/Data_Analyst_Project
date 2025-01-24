import pandas as pd
import mysql.connector
from datetime import datetime

# 1. Load Data dari CSV
file_path = 'Data Mahasiswa nya.csv'
data = pd.read_csv(file_path)

# 2. Mengonversi kolom Tanggal Lahir ke format yang bisa diterima MySQL (YYYY-MM-DD)
data['Tanggal Lahir'] = pd.to_datetime(data['Tanggal Lahir'], errors='coerce').dt.strftime('%Y-%m-%d')

# 3. Mengonversi kolom Tahun Masuk menjadi integer jika perlu
data['Tahun Masuk'] = data['Tahun Masuk'].astype(int)

# 4. Menyesuaikan kolom Jenis Kelamin ke nilai yang sesuai dengan enum
data['Jenis Kelamin'] = data['Jenis Kelamin'].apply(lambda x: 'Laki-Laki' if 'Laki-Laki' in x else 'Perempuan')

# 5. Koneksi ke Database MySQL
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',
    database='datasets_mahasiswa'
)
cursor = conn.cursor()

# 6. Query untuk Insert Data
query = """
INSERT INTO identitas_mahasiswa (NIM, Nama_Mahasiswa, Jenis_Kelamin, Tanggal_Lahir, Alamat, Program_Studi, Tahun_Masuk)
VALUES (%s, %s, %s, %s, %s, %s, %s)
"""

# 7. Iterasi dan Eksekusi Insert
for index, row in data.iterrows():
    values = (
        row['NIM'],
        row['Nama Mahasiswa'],
        row['Jenis Kelamin'],
        row['Tanggal Lahir'],
        row['Alamat'],
        row['Program Studi'],
        row['Tahun Masuk']
    )
    try:
        cursor.execute(query, values)
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        continue  # Skip row if error occurs

# 8. Commit dan Tutup Koneksi
conn.commit()
cursor.close()
conn.close()

print("Data berhasil diimport ke tabel MySQL.")
