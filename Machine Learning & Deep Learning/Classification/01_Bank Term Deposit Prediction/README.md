# Bank Term Deposit Prediction - Data Quest 2025 🏦

![Event](https://img.shields.io/badge/Event-Data_Quest_2025-blue)
![Team](https://img.shields.io/badge/Team-Mafia_Bar_Chart-purple)
![Tools](https://img.shields.io/badge/Tools-CatBoost_%7C_Optuna-orange)

## 📌 Project Overview
Proyek ini dikerjakan sebagai bagian dari kompetisi **Data Quest 2025** yang diselenggarakan oleh **Data Science Indonesia**. Tujuan utamanya adalah membangun model *Machine Learning* untuk memprediksi nasabah perbankan yang berpotensi berlangganan produk **Deposito Berjangka** (*Term Deposit*).

Solusi ini diharapkan dapat membantu bank meningkatkan efektivitas kampanye pemasaran dengan menargetkan nasabah yang memiliki probabilitas tinggi untuk melakukan konversi.

## ❓ Problem Statement
Dalam industri perbankan, pemasaran massal sering kali tidak efisien dan memakan biaya tinggi. Tantangan utamanya adalah:
* **Efisiensi Pemasaran:** Bagaimana mengidentifikasi nasabah yang tepat agar sumber daya *telemarketing* tidak terbuang sia-sia?
* **Ketidakseimbangan Data:** Data nasabah yang berlangganan deposito (kelas positif) jauh lebih sedikit dibandingkan yang tidak berlangganan, membuat model cenderung bias ke kelas mayoritas.

## 📂 Dataset
Dataset yang digunakan terdiri dari data historis demografis dan finansial nasabah.
* **Training Set:** `training_dataset.csv` (Berisi label target).
* **Validation Set:** `validation_set.csv` (Tanpa label, untuk submisi prediksi).

### Key Variables
* **Demografis:** `usia`, `pekerjaan`, `status_perkawinan`, `pendidikan`.
* **Finansial:** `gagal_bayar_sebelumnya` (credit default), `pinjaman_rumah`, `pinjaman_pribadi`.
* **Interaksi:** `jenis_kontak`, `bulan_kontak_terakhir`, `durasi_kontak`.
* **Target:** `berlangganan_deposito` (0: Tidak, 1: Ya).

## ⚙️ Methodology

### 1. Data Preprocessing & Feature Engineering
Langkah-langkah yang dilakukan dalam *notebook* meliputi:
* **Handling Missing Values:** Menangani nilai anomali (seperti '999' pada `pdays`).
* **Feature Creation:** Membuat fitur baru `status_dihubungi` berdasarkan riwayat kontak kampanye sebelumnya.
* **Encoding:** Mengubah variabel kategorikal agar kompatibel dengan model.

### 2. Modeling Strategy
Algoritma utama yang digunakan adalah **CatBoost Classifier**, yang dipilih karena kemampuannya menangani fitur kategorikal dengan baik tanpa *preprocessing* yang rumit.

* **Hyperparameter Tuning:** Menggunakan **Optuna** untuk mencari kombinasi parameter optimal (seperti `learning_rate`, `depth`, `l2_leaf_reg`).
* **Cross-Validation:** Menggunakan **Stratified K-Fold** untuk menjaga proporsi kelas target dalam setiap lipatan validasi.

## 📊 Results & Evaluation
Evaluasi dilakukan menggunakan metrik *ROC-AUC* dan *Accuracy*. Berikut adalah performa model terbaik berdasarkan data latih:

| Metric | Score |
| :--- | :--- |
| **Accuracy** | **~84%** |
| **ROC-AUC** | **~0.79** |
| **Recall (Positive Class)** | **~60%** |

Model berhasil menyeimbangkan antara presisi dan *recall*, sehingga mampu mendeteksi sebagian besar nasabah potensial meskipun terdapat ketidakseimbangan kelas yang signifikan.

## 👥 Authors - Team Mafia Bar Chart
* **Brahmayudha Erlangga Putra**
* **Giffani Rizky Febrian**
* **Andreas Heryanto**
