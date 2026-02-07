# Psychological State Identification Dashboard 🧠

![Course](https://img.shields.io/badge/Course-Data_Mining_A-blue)
![Tools](https://img.shields.io/badge/Tools-R_Shiny_%7C_Python-green)

## 📌 Project Overview
Proyek ini dikembangkan untuk memenuhi tugas Final Project mata kuliah **Data Mining A**. Tujuan utamanya adalah membangun sistem klasifikasi kondisi psikologis seseorang (seperti Stres atau Rileks) menggunakan data biosensor fisiologis. [cite_start]Proyek ini mencakup eksplorasi data, visualisasi interaktif menggunakan **R-Shiny**, serta komparasi model *machine learning*[cite: 1, 2, 287].

## ❓ Problem Statement
Kesehatan mental merupakan isu krusial di era digital. Metode diagnosis konvensional sering kali bersifat subjektif. [cite_start]Biosensor menawarkan pendekatan objektif dengan mengukur perubahan fisiologis (seperti detak jantung dan pernapasan) secara *real-time*[cite: 17]. 

[cite_start]Proyek ini bertujuan untuk mengklasifikasikan kondisi psikologis berdasarkan indikator-indikator biosensor tersebut guna mendeteksi tanda awal gangguan mental[cite: 18, 20].

## 📂 Dataset
Dataset yang digunakan adalah **Psychological State Identification Dataset** yang bersumber dari Kaggle.
* [cite_start]**Sumber:** [Kaggle Dataset](https://www.kaggle.com/datasets/willianoliveiragibin/psychological-state/data) [cite: 24]
* [cite_start]**Jumlah Data:** 1.000 entri (Baris) [cite: 27]
* [cite_start]**Variabel Target:** `Psychological State` dengan 4 kategori kelas: *Stressed, Relaxed, Anxious, Focused*[cite: 22].
* [cite_start]**Kondisi Data:** Tidak ditemukan duplikasi maupun *missing value*[cite: 30].

## ⚙️ Methodology

### 1. Feature Selection
[cite_start]Menggunakan metode *Mutual Information* dan *Recursive Feature Elimination*, terpilih 4 fitur paling signifikan yang digunakan untuk pemodelan[cite: 298, 299]:
* [cite_start]**GSR (µS):** *Galvanic Skin Response* [cite: 301]
* [cite_start]**EEG Delta:** Gelombang otak frekuensi rendah [cite: 302]
* [cite_start]**EEG Beta:** Gelombang otak frekuensi tinggi [cite: 303]
* [cite_start]**Cognitive Load:** Beban kognitif [cite: 304]

### 2. Modeling Algorithms
[cite_start]Tiga algoritma klasifikasi digunakan untuk memprediksi kondisi psikologis [cite: 310-312]:
1.  **Decision Tree**
2.  **Logistic Regression**
3.  **Gaussian Naive Bayes**

### 3. Evaluation Method
[cite_start]Model dievaluasi menggunakan dua skenario[cite: 313]:
* [cite_start]**Repeated Holdout (Stratified):** 10 kali pengulangan (Train: 667, Test: 333) [cite: 317-321].
* [cite_start]**K-Fold Cross Validation:** $K=10$[cite: 423].

## 📊 Results & Evaluation
[cite_start]Berikut adalah performa rata-rata model berdasarkan pengujian **K-Fold Cross Validation**[cite: 502]:

| Model | Accuracy | Sensitivity | Specificity | AUC |
| :--- | :--- | :--- | :--- | :--- |
| **Decision Tree** | **24.40%** | **24.85%** | **73.23%** | **0.498** |
| Logistic Regression | 23.80% | 24.33% | 75.50% | 0.467 |
| Naive Bayes | 23.40% | 23.69% | 74.45% | 0.456 |

**Kesimpulan:**
[cite_start]Berdasarkan Kurva ROC dan nilai AUC, model terbaik untuk eksperimen ini adalah **Decision Tree** dengan nilai AUC sebesar **49.8%**[cite: 527]. [cite_start]Meskipun demikian, nilai AUC menunjukkan bahwa model masih memerlukan pengembangan lebih lanjut untuk mencapai prediksi yang akurat[cite: 507].

## 💻 Dashboard Features (R-Shiny)
[cite_start]Dashboard ini menyediakan visualisasi interaktif untuk eksplorasi data[cite: 287], mencakup:
* **Histogram:** Distribusi variabel numerik.
* **Scatter Plot:** Hubungan antar variabel.
* **Pie Chart & Count Plot:** Proporsi data kategorik (seperti Mood State dan Task Type).

## 👤 Author
**Brahmayudha Erlangga Putra** NRP: 5003221084  
[cite_start]Mahasiswa Statistika - Institut Teknologi Sepuluh Nopember (ITS)[cite: 1, 8].

---
*Dibuat sebagai bagian dari Final Project Mata Kuliah Data Mining A.*
