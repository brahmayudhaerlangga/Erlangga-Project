# Stock Price Forecasting: ARIMA vs LSTM 📈

![Course](https://img.shields.io/badge/Course-Analisis_Deret_Waktu_(ADS)_C-blue)
![Tools](https://img.shields.io/badge/Tools-Python_%7C_R-green)

## 📌 Project Overview
Proyek ini merupakan **Final Project** untuk mata kuliah **Analisis Data Statistik (ADS) Kelas C**. Penelitian ini berfokus pada peramalan harga saham **PT Panin Sekuritas Tbk** dengan membandingkan kinerja antara model linier klasik dan model *Deep Learning*.

Tujuan utamanya adalah menentukan metode mana yang paling akurat dalam menangkap pola pergerakan harga saham, apakah pendekatan linier (**ARIMA**) atau pendekatan non-linier (**LSTM**).

## ❓ Problem Statement
Pasar saham memiliki volatilitas yang tinggi dan dipengaruhi oleh berbagai faktor kompleks. Metode peramalan konvensional sering kali kesulitan menangkap pola non-linier dalam data harga saham.

Oleh karena itu, proyek ini membandingkan dua pendekatan berbeda:
1.  **ARIMA (AutoRegressive Integrated Moving Average):** Mewakili metode statistik linier yang kuat untuk data stasioner.
2.  **LSTM (Long Short-Term Memory):** Mewakili metode *Recurrent Neural Network (RNN)* yang mampu mempelajari ketergantungan jangka panjang dan pola non-linier.

## ⚙️ Methodology

### 1. Dataset
Data yang digunakan adalah data historis harga penutupan (*closing price*) saham **PT Panin Sekuritas Tbk**.
* **Preprocessing:** Pengecekan stasioneritas data (Augmented Dickey-Fuller Test), differencing, dan normalisasi data (MinMax Scaler untuk LSTM).

### 2. Modeling Algorithms
* **ARIMA:** Penentuan parameter terbaik $(p,d,q)$ berdasarkan plot ACF dan PACF serta nilai AIC terkecil.
* **LSTM:** Membangun arsitektur jaringan syaraf tiruan dengan *hidden layers* untuk menangkap memori jangka panjang dari data *time series*.

## 📊 Results & Evaluation
Kinerja kedua model dievaluasi menggunakan metrik kesalahan seperti **RMSE (Root Mean Square Error)** dan **MAPE (Mean Absolute Percentage Error)**.

| Model | Karakteristik | Performa |
| :--- | :--- | :--- |
| **ARIMA** | Cocok untuk tren linier dan data stasioner. | Baik untuk jangka pendek, namun kurang responsif terhadap volatilitas ekstrem. |
| **LSTM** | Mampu menangkap pola non-linier yang kompleks. | Lebih unggul dalam mengikuti fluktuasi harga saham yang dinamis. |

**Kesimpulan:**
Hasil analisis menunjukkan perbandingan efektivitas antara metode statistik klasik dan *machine learning* modern dalam konteks pasar saham Indonesia.

## 👥 Authors
* **Brahmayudha Erlangga Putra**
* **Fairuz Afghan Bahari**

**Departemen Statistika**
Fakultas Sains dan Analitika Data - Institut Teknologi Sepuluh Nopember (ITS)
