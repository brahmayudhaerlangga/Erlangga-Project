# Psychological State Identification Dashboard 🧠

![Course](https://img.shields.io/badge/Course-Data_Mining_A-blue)
![Tools](https://img.shields.io/badge/Tools-R_Shiny_%7C_Python-green)

## 📌 Project Overview
Proyek ini dikembangkan untuk memenuhi tugas Final Project mata kuliah **Data Mining A**. Tujuan utamanya adalah membangun sistem klasifikasi kondisi psikologis seseorang (seperti Stres atau Rileks) menggunakan data biosensor fisiologis. Proyek ini mencakup eksplorasi data, visualisasi interaktif menggunakan **R-Shiny**, serta komparasi model *machine learning*.

## ❓ Problem Statement
Kesehatan mental merupakan isu krusial di era digital. Metode diagnosis konvensional sering kali bersifat subjektif. Biosensor menawarkan pendekatan objektif dengan mengukur perubahan fisiologis (seperti detak jantung dan pernapasan) secara *real-time*. 

Proyek ini bertujuan untuk mengklasifikasikan kondisi psikologis berdasarkan indikator-indikator biosensor tersebut guna mendeteksi tanda awal gangguan mental.

## 📂 Dataset
Dataset yang digunakan adalah **Psychological State Identification Dataset** yang bersumber dari Kaggle.
* [cite_start]**Sumber:** [Kaggle Dataset](https://www.kaggle.com/datasets/willianoliveiragibin/psychological-state/data)
* [cite_start]**Jumlah Data:** 1.000 entri (Baris)
* [cite_start]**Variabel Target:** `Psychological State` dengan 4 kategori kelas: *Stressed, Relaxed, Anxious, Focused*.
* [cite_start]**Kondisi Data:** Tidak ditemukan duplikasi maupun *missing value*.

## ⚙️ Methodology

### 1. Feature Selection
Menggunakan metode *Mutual Information* dan *Recursive Feature Elimination*, terpilih 4 fitur paling signifikan yang digunakan untuk pemodelan:
* **GSR (µS):** *Galvanic Skin Response*
* **EEG Delta:** Gelombang otak frekuensi rendah
* **EEG Beta:** Gelombang otak frekuensi tinggi
* **Cognitive Load:** Beban kognitif

### 2. Modeling Algorithms
Tiga algoritma klasifikasi digunakan untuk memprediksi kondisi psikologis:
1.  **Decision Tree**
2.  **Logistic Regression**
3.  **Gaussian Naive Bayes**

### 3. Evaluation Method
Model dievaluasi menggunakan dua skenario:
* **Repeated Holdout (Stratified):** 10 kali pengulangan (Train: 667, Test: 333).
* **K-Fold Cross Validation:** $K=10$.

## 📊 Results & Evaluation
Berikut adalah performa rata-rata model berdasarkan pengujian **K-Fold Cross Validation**:

| Model | Accuracy | Sensitivity | Specificity | AUC |
| :--- | :--- | :--- | :--- | :--- |
| **Decision Tree** | **24.40%** | **24.85%** | **73.23%** | **0.498** |
| Logistic Regression | 23.80% | 24.33% | 75.50% | 0.467 |
| Naive Bayes | 23.40% | 23.69% | 74.45% | 0.456 |

**Kesimpulan:**
Berdasarkan Kurva ROC dan nilai AUC, model terbaik untuk eksperimen ini adalah **Decision Tree** dengan nilai AUC sebesar **49.8%**. Meskipun demikian, nilai AUC menunjukkan bahwa model masih memerlukan pengembangan lebih lanjut untuk mencapai prediksi yang akurat.

## 💻 Dashboard Features (R-Shiny)
Dashboard ini menyediakan visualisasi interaktif untuk eksplorasi data, mencakup:
* **Histogram:** Distribusi variabel numerik.
* **Scatter Plot:** Hubungan antar variabel.
* **Pie Chart & Count Plot:** Proporsi data kategorik (seperti Mood State dan Task Type).

## 👤 Author
**Brahmayudha Erlangga Putra** NRP: 5003221084  
Mahasiswa Statistika - Institut Teknologi Sepuluh Nopember (ITS).
