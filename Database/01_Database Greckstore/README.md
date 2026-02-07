# Greckstore Database System (Samsung Authorized Official Store) 📱

![Course](https://img.shields.io/badge/Course-Basis_Data_B-blue)
![Tools](https://img.shields.io/badge/Tools-MySQL_%7C_Google_Spreadsheet-orange)

## 📌 Project Overview
Proyek ini adalah Tugas Besar untuk mata kuliah **Basis Data B**. Tujuan utamanya adalah merancang dan mengembangkan sistem basis data relasional untuk **Greckstore**, sebuah *Samsung Authorized Official Store*. Sistem ini dibangun untuk menangani operasional toko mulai dari manajemen stok, transaksi penjualan, hingga pelaporan keuangan secara efisien dan terstruktur.

## ❓ Problem Statement
Sebelum pengembangan sistem ini, toko menghadapi kendala operasional seperti:
* **Redundansi Data:** Penyimpanan data yang berulang dan tidak efisien.
* **Anomali Data:** Risiko kesalahan saat penambahan, penghapusan, atau modifikasi data.
* **Inefisiensi Informasi:** Lambatnya akses informasi produk dan riwayat transaksi pelanggan.

Solusinya adalah membangun basis data yang ter-normalisasi hingga tingkat **3NF (Third Normal Form)** untuk menjamin integritas dan konsistensi data.

## ⚙️ Database Design

### 1. Normalization
Proses perancangan dimulai dari *Unnormalized Form (UNF)* dan dinormalisasi bertahap hingga **3NF**. Hasil akhirnya terdiri dari 9 entitas utama:
* `Customer` & `Member`
* `Staff`
* `Produk`
* `Pemesanan` & `Pengiriman`
* `Supplier` & `Order_Stock`
* `Ongkos_Kirim`

### 2. Entity Relationship Diagram (ERD)
Sistem menggunakan relasi antar tabel sebagai berikut:
* **One-to-Many:** Member ke Customer, Ongkos Kirim ke Pemesanan.
* **One-to-One:** Pemesanan ke Pengiriman.
* **Many-to-Many:** Relasi kompleks yang dihubungkan melalui tabel transaksi (seperti Pemesanan yang menghubungkan Produk dan Customer).

## 💻 SQL Features & Implementation
Sistem ini diimplementasikan menggunakan **MySQL** dengan fitur-fitur otomasi berikut:

### 🚀 Triggers
* **Auto-Update Stock:** Stok produk otomatis berkurang saat terjadi penjualan (`INSERT` pada tabel `Pemesanan`) dan otomatis bertambah saat restock dari supplier (`INSERT` pada tabel `Order_Stock`).

### 📦 Stored Procedures
Sistem dilengkapi dengan *Stored Procedures* untuk analisis bisnis instan:
1.  **`Income()`**: Menampilkan laporan pendapatan toko per bulan secara otomatis.
2.  **`Produk_Terjual()`**: Mengidentifikasi produk terlaris (*Best Seller*) berdasarkan total kuantitas terjual.
3.  **`Nota_Transaksi(ID_Pesan)`**: Menghasilkan struk belanja/nota pembelian yang detail, mencakup perhitungan diskon member dan ongkos kirim.

## 👥 Authors
* **Giffani Rizky Febrian** (5003221014)
* **Brahmayudha Erlangga Putra** (5003221084)
* **Rizal Afandi** (5003221116)

**Departemen Statistika** Fakultas Sains dan Analitika Data - Institut Teknologi Sepuluh Nopember (ITS)

---
*Dibuat untuk memenuhi Tugas Besar Mata Kuliah Basis Data B Tahun 2023/2024.*
