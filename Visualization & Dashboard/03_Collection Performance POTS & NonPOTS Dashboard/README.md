# Monthly Report Dashboard: POTS & NON-POTS 📊

![Project](https://img.shields.io/badge/Project-Data_Analytics-blue)
![Tools](https://img.shields.io/badge/Tools-Power_BI_%7C_DAX-green)
![Company](https://img.shields.io/badge/Company-PT_Telkom_Indonesia-red)

## ⚠️ Disclaimer
**Seluruh data yang digunakan dan ditampilkan dalam *dashboard* ini adalah data sintetis (*dummy data*).** 
Data asli perusahaan telah diubah, disamarkan, dan diacak sepenuhnya guna mematuhi kebijakan privasi dan menjaga kerahasiaan informasi pelanggan serta performa finansial riil PT Telkom Indonesia. Tidak ada data asli atau informasi sensitif yang dipublikasikan dalam portofolio/repositori ini.

---

## 📌 Project Overview
Proyek ini merupakan pengembangan *dashboard* analitik dan visualisasi data yang dirancang untuk memonitor kinerja penagihan (*collection*) dan pendapatan bulanan di PT Telkom Indonesia Witel Suramadu, khususnya pada Unit Shared Service and General Support (SSGS) Divisi Payment Collection. Tujuan utamanya adalah membangun sistem pelaporan interaktif yang dapat melacak status *billing*, *pencairan* (pembayaran), serta tunggakan pelanggan untuk berbagai segmen bisnis.

## ❓ Problem Statement
Pemantauan pendapatan, saldo akhir pelanggan, dan tingkat keberhasilan penagihan (seperti C3MR dan PRANPC) di perusahaan telekomunikasi berskala besar membutuhkan pengawasan yang ketat. Laporan manual sering kali menyulitkan proses identifikasi pelanggan dengan tunggakan terbesar atau tren penurunan persentase pembayaran antar area.

Proyek ini bertujuan untuk mengotomatisasi visualisasi data *collection* tersebut ke dalam satu *dashboard* komprehensif, memungkinkan eksekutif dan manajer akun untuk mengambil keputusan berbasis data secara cepat dan tepat sasaran.

## 📂 Dataset
Dataset yang digunakan mereplikasi struktur data *collection* bulanan internal.
- **Sumber Data:** Data internal *Collection* Divisi SSGS PT Telkom Indonesia (telah disamarkan dengan *dummy data*).
- **Produk:** Terbagi menjadi dua kategori utama, yaitu **POTS** (C3MR ALL, C3MR RBS, PRANPC RBS) dan **NON-POTS**.
- **Segmen Bisnis (Unit):** Meliputi RBS, DGS, DPS, dan DSS.

## ⚙️ Methodology & Data Processing

### 1. Data Preprocessing & Modeling
Melakukan pembersihan data, penyesuaian tipe data, dan pembentukan relasi antar tabel (seperti tabel pelanggan, transaksi *billing*, dan area/TELDA) untuk memastikan filter dinamis berjalan lancar.

### 2. DAX (Data Analysis Expressions)
Pembuatan *measure* khusus untuk menghitung indikator kinerja utama (KPI) yang kompleks, seperti:
- Kalkulasi *Total Pencairan* dan *% Bayar* (Pencairan terhadap Target).
- Perhitungan *Unpaid Revenue* dan agregasi *Shortage*.
- Klasifikasi umur tunggakan (*Aging*) pelanggan.

### 3. UI/UX & Interactivity Design
Menggunakan fitur *Bookmarks* dan *Buttons* di Power BI untuk menciptakan navigasi yang mulus (seperti berpindah dari halaman *Report* matriks ke *Visualisasi* grafis tanpa harus membuka *tab* baru).

## 📊 Dashboard Features
Dashboard ini dirancang dengan antarmuka yang bersih dan fitur interaktif, mencakup:
- **Dynamic Sidebar Navigation:** Menu navigasi di sisi kiri untuk beralih secara instan antara produk (POTS / NONPOTS) dan unit bisnis spesifik.
- **Executive KPI Cards:** Menampilkan metrik *high-level* seperti Total Pelanggan, Total Saldo Akhir, Billing Rev, dan Total Pencairan beserta persentase perubahannya dibanding bulan sebelumnya.
- **Top 10 Debtors Matrix:** Tabel peringkat pelanggan dengan saldo akhir dan tunggakan terbesar beserta detail nama *Account Manager* (AM).
- **Trend & Distribution Charts:** 
  - *Line chart* untuk memantau fluktuasi *Pencairan % Bayar* antar TELDA selama beberapa periode.
  - *Bar chart* untuk melihat distribusi *Outstanding* berdasarkan TELDA.
  - *Donut chart* untuk proporsi pelanggan yang memiliki tagihan vs tidak ada tagihan.
- **Report & Visualization Toggles:** Fleksibilitas untuk melihat data dalam bentuk tabel rincian (Report) atau grafik ringkasan (Visualisasi).

## 👤 Author
**Brahmayudha Elrangga Putra**  
Data Analyst & Visualization Intern (Unit Shared Service and General Support (SSGS) Divisi Payment Collection) - PT Telkom Indonesia Witel Suramadu  
S1 Statistika - Institut Teknologi Sepuluh Nopember (ITS)
