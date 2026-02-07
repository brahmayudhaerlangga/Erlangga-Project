library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(ggplot2)
library(dashboardthemes)
library(DT)
library(dplyr)
library(reshape2)
library(ggrepel)
library(randomForest)

data <- read.csv("psychological_state.csv")
data_kategorik <- data %>% select(where(is.factor) | where(is.character))
data_numerik <- data %>% select(where(is.numeric))

Header <- dashboardHeader(
  title = tags$div(
    tags$img(src="https://seeklogo.com/images/I/institut-teknologi-sepuluh-nopember-logo-DD303AEE34-seeklogo.com.png",
             height = '45px', width = '45px', style = "float: left;"),
    tags$img(src="https://www.its.ac.id/statistika/wp-content/uploads/sites/43/2018/03/logo-statistika-white-border.png",
             height = '45px', width = '45px', style = "float: right;"),
    style = "font-family: Arial, sans-serif; font-weight: bold; font-size: 20px; width: 300px; padding-right: 20px;", 
    "   Data Mining A   "
  ), titleWidth = 300
)

Sidebar <- dashboardSidebar(
  width = 300,
  sidebarMenu(
    menuItem("Beranda", icon = icon("home"), tabName = "beranda"),
    menuItem("Tentang Dataset", icon = icon("file-alt"), tabName = "dataset"),
    menuItem("Analisis Data", icon = icon("line-chart"), tabName = "visualisasi",
             menuSubItem("Data Numerik", tabName = "numerik", icon = icon("chart-bar")),
             menuSubItem("Data Kategorik", tabName = "kategorik", icon = icon("chart-pie"))),
    menuItem("Cek Kondisi Psikologismu", icon = icon("user"), tabName = "kondisi",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Tentang Creator", icon = icon("info-circle"), tabName = "info")
  )
)

BodyItem <- dashboardBody(
  tags$head(
    tags$style(HTML('
        /* header (logo) */
        .skin-blue .main-header .logo {
          background-color: #D32F2F; /* Merah kesehatan */
        }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
          background-color: #C2185B; /* Merah muda gelap */
        }

        /* navbar */
        .skin-blue .main-header .navbar {
          background-color: #D32F2F; /* Merah kesehatan */
        }

        /* sidebar */
        .skin-blue .main-sidebar {
          background-color: #F5F5F5; /* Warna netral untuk menyeimbangkan */
        }

        /* active selected tab in sidebar menu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a {
          background-color: #C2185B; /* Merah muda gelap */
          color: white !important; /* Teks putih agar kontras */
        }

        /* other links in sidebar menu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a {
          background-color: #F5F5F5;
          color: #D32F2F;
        }

        /* other links in sidebar menu when hovered */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover {
          background-color: #FFCDD2; /* Merah muda terang */
        }

        /* toggle button when hovered */
        .skin-blue .main-header .navbar .sidebar-toggle:hover {
          background-color: #C2185B;
        }

        /* body */
        .content-wrapper, .right-side {
          background-color: #FFEBEE; /* Latar belakang merah muda */
        }

        /* custom box */
        .custom-box {
          background-color: #FFCDD2 !important; /* Kotak dengan warna merah muda terang */
        }

        /* header box */
        .header-box {
          background-color: #C2185B !important; /* Latar belakang kotak header */
          color: white !important;
          margin: 0;
          padding: 0;
        }

        .header-box h1 {
          margin: 0;
          padding: 20px;
          font-family: "Helvetica Neue", sans-serif;
          font-size: 24px; /* Ukuran font nyaman untuk dibaca */
        }
      ')),
    tags$style(type = "text/css", ".carousel-inner > .item > img {max-width: 50% !important; height: auto !important;}")
  ),
  tabItems(
    tabItem(tabName = "beranda",titlePanel(h1(strong("KONDISI PSIKOLOGIS GA PENTING?!"),style="text-align: center;")),
            br(),
            fluidPage(tags$style(HTML("
                      .card {
                      background-color: #E74C3C; /* Warna merah */
                      color: white; 
                      padding: 20px;
                      border-radius: 10px;
                      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
                      text-align: center;
                      margin: 10px;
                      font-family: Arial, sans-serif;
                      }
                      .icon {
                      font-size: 40px;
                      margin-bottom: 10px;
                      }
                      .value {
                      font-size: 28px;
                      font-weight: bold;
                      }
                      .label {
                      font-size: 14px;
                      font-style: italic;
                      }
            "))),
            fluidRow(
              column(
                width = 6,
                div(class = "card",
                    span(class = "icon", "⚠️"), # Simulasi ikon
                    div(class = "value", "1350"),
                    div(class = "label", "Kasus Bunuh Diri (Indonesia)")
                )
              ),
              column(
                width = 6,
                div(class = "card",
                    span(class = "icon", "❤️"), # Simulasi ikon
                    div(class = "value", "30-32 Juta"),
                    div(class = "label", "Penderita Gangguan Psikologis")
                )
              )
            ),
            fluidRow(
              # Kolom untuk gambar
              tags$div(width = 12,
                       align = "center",
                       img(src = "https://www.its.ac.id/news/wp-content/uploads/sites/2/2020/04/Ilustrasi-kesehatan-mental.png", width = "80%")
              ),
              # Kolom untuk penjelasan paragraf
              box(width = 12,
                  align = "justify",   
                  style = "font-size: 18px;",
                  p("Eksplorasi psikologi sangat penting dalam memahami dan meningkatkan kesejahteraan mental. 
                    Psikologi mempelajari perilaku, pikiran, dan emosi manusia, memberikan wawasan mendalam tentang kompleksitas kehidupan mental. 
                    Dalam konteks kesejahteraan mental, pemahaman psikologis membantu mengidentifikasi faktor-faktor yang memengaruhi kondisi psikologis seseorang. 
                    Pentingnya eksplorasi psikologi dapat terlihat dari peranannya dalam mengatasi masalah mental seperti depresi, kecemasan, dan stres.
                    Dengan memahami aspek-aspek psikologis individu dan faktor-faktor lingkungan, kita dapat membangun strategi yang lebih efektif untuk meningkatkan kesejahteraan mental secara keseluruhan."),
                  br(),
                  p("Sumber : Kumparan 2023")
              )
            ),
            box(title = "Video yang Berkaitan :",
                status = "primary",   
                solidHeader = TRUE,
                width = 12,
                style = "padding: 15px; background-color: #f8f9fa; border: 1px solid #ddd; border-radius: 4px; box-shadow: 2px 2px 5px #aaa;",
                tags$div(style = "display: flex; flex-direction: column; gap: 10px;",
                        tags$iframe(src = "https://www.youtube.com/embed/rDYFMwQhFAU?si=JNGvEr3gSsv7Iid4", 
                                    width = "100%",
                                    height = "315px",
                                    frameborder = "0",
                                    allow = "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture",
                                    allowfullscreen = TRUE
                                    ),
                        tags$iframe(src = "https://www.youtube.com/embed/DqQHIZSoJRI?si=7rIfwZuAuacJ29Y0", 
                                    width = "100%",
                                    height = "315px",
                                    frameborder = "0",
                                    allow = "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture",
                                    allowfullscreen = TRUE
                                    )
                        )
            )

    ),
    tabItem(tabName = "dataset",
            tabsetPanel(tabPanel("Database",icon = icon("address-card"),
                                 titlePanel(h1(strong("Informasi Dataset"),style="text-align: center;")),
                                 tags$head(
                                   # Menambahkan CSS untuk scroll horizontal
                                   tags$style(HTML('
                                              .box-body {
                                              max-height: 400px; /* Tentukan tinggi maksimal box */
                                              overflow-x: auto;  /* Menambahkan scroll horizontal */
                                              }
                                              '))
                                 ),
                                 fluidRow(
                                   box(width = 12,
                                       align = "justify",
                                       div(style = "font-size: 18px;",
                                           p("Dataset ini mensimulasikan data fisiologis, perilaku, dan lingkungan yang dikumpulkan menggunakan biosensor untuk mengevaluasi kondisi psikologis individu, khususnya mahasiswa, selama kegiatan pendidikan ideologi dan politik (IPE).
                                             Dataset ini mendukung penelitian tentang penilaian tingkat stres dan kondisi emosional secara real-time dengan bantuan biosensor."),
                                           p(strong("\n\nTujuan Dataset:")),
                                           tags$ul(
                                             tags$li("Menganalisis kondisi psikologis, tingkat stres, dan keterlibatan emosional mahasiswa selama kegiatan pendidikan."),
                                             tags$li("Mendukung pengembangan model machine learning seperti EOO-DLSTM untuk mengidentifikasi kondisi psikologis berdasarkan data fisiologis dan lingkungan."),
                                             tags$li("Menggali penerapan teknologi biosensor dalam mendukung kesehatan mental, khususnya dalam kegiatan pendidikan IPE."),
                                             br(),
                                             p(HTML("Sumber: <a href='https://www.kaggle.com/datasets/ziya07/psychological-state-identification-dataset' target='_blank' style='color: blue; text-decoration: underline;'>Kaggle</a>"))))),
                                   box(width = 12,
                                       title = "Dataset",
                                       status = "primary",   
                                       solidHeader = TRUE,
                                       dataTableOutput("data")))),
                        tabPanel("Variabel",icon = icon("address-card"),
                                 box(width = 12,
                                     title = "Deskripsi Variabel yang Digunakan",
                                     status = "primary",
                                     solidHeader = TRUE,
                                     tableOutput("tabelvariabel")))
                        )
    ),
    tabItem(tabName = "numerik", 
            h2("Analisis Data Numerik"),
            fluidPage(
              titlePanel(h1(strong("Visualisasi Data Numerik"), style = "text-align: center;")),
              sidebarLayout(
                sidebarPanel(
                  selectInput("numerik_plot", "Pilih Jenis Visualisasi:", 
                              choices = c("Histogram", "Scatter Plot", "Heat Map"),
                              selected = "Histogram"),
                  uiOutput("numerik_var_select")
                ),
                mainPanel(
                  fluidRow(
                    plotOutput("numerik_plot_output", height = "600px")
                  )
                )
              )
            )
    ),
    tabItem(tabName = "kategorik", 
            h2("Analisis Data Kategorik"),
            fluidPage(
              titlePanel(h1(strong("Visualisasi Data Kategorik"), style = "text-align: center;")),
              sidebarLayout(
                sidebarPanel(
                  selectInput("kategorik_plot", "Pilih Jenis Visualisasi:", 
                              choices = c("Pie-Chart", "Count Plot"),
                              selected = "Pie-Chart"),
                  uiOutput("kategorik_var_select")
                ),
                mainPanel(
                  fluidRow(
                    plotOutput("kategorik_plot_output", height = "600px")
                  )
                )
              )
            )
    ),
    tabItem(tabName = "kondisi",
            fluidPage(
              titlePanel(h1(strong("Cek Kondisi Psikologismu"), style = "text-align: center;")),
              sidebarLayout(
                sidebarPanel(
                  numericInput("GSR", "Masukkan GSR (0-2):", value = NULL, min = 0, max = 2),
                  numericInput("EEG_Delta", "Masukkan Skor EEG Delta (0-4):", value = NULL, min = 0, max = 4),
                  numericInput("EEG_Beta", "Masukkan Skor EEG Beta (0-4):", value = NULL, min = 0, max = 4),
                  numericInput("Cognitive_Load", "Masukkan Nilai Beban Pikiran (0-2):", value = NULL, min = 0, max = 2),
                  actionButton("submit_kondisi", "Prediksi Kondisi", icon = icon("check"))
                ),
                mainPanel(
                  h3(strong("Hasil Prediksi"), style = "text-align: center;"),
                  fluidRow(
                    box(
                      width = 12,
                      h4(strong("Kondisi Psikologis Anda:")),
                      textOutput("prediksi_kondisi"),
                      hr(),
                      h4(strong("Saran:")),
                      textOutput("saran_kondisi")
                    )
                  )
                )
              )
            )
    ),
    tabItem(tabName = "info",
            box(
              h1(strong("Halo Semuanya!"), style = "text-align: center; background-color: #D32F2F; color: white;"),
              width = 12,
              height = 300,
              div(
                style = "text-align: center; margin-bottom: 20px;",
                img(src = "https://media.licdn.com/dms/image/v2/D5603AQGzzH-mxCdPaQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1718619661659?e=1740009600&v=beta&t=0__YZBvEBIklN-Zy5ZgFz0DWraRUChCL-OSGOoETGL0", 
                    style = "width: 150px; height: 150px; border-radius: 50%; border: 5px solid #4F6F52;")
              ),
              p("Nama : Brahmayudha Erlangga Putra", style = "font-family: 'arial'; font-size: 16pt; font-weight: bold; text-align: center;"), 
              p("NRP : 5003221084", style = "font-family: 'arial'; font-size: 16pt; font-weight: bold; text-align: center;"),
              p("Departemen : Statistika", style = "font-family: 'arial'; font-size: 16pt; font-weight: bold; text-align: center;"),
              class = "custom-box"
            )
    )
  )
)

ui <- dashboardPage(
  header = Header,
  sidebar = Sidebar, 
  body = BodyItem
)

server <- function(input, output) {
  
  # Definisikan data numerik dan kategorik
  data_numerik <- data %>% select(where(is.numeric))
  data_kategorik <- data %>% select(where(is.factor) | where(is.character))
  
  # Render data untuk tab "Dataset"
  output$data <- DT::renderDataTable({
    datatable(data, options = list(pageLength = 5, autoWidth = TRUE))
  })
  
  # Tabel untuk variabel
  output$tabelvariabel <- renderTable({
    data.frame(
      Variabel = c("Psychological State","HRV (ms)", "GRV (μS)", "EEG Delta", "EEG Alpha", "EEG Beta", "Blood Pressure Category", "Oxygen Saturation (%)",
                   "Heart Rate (BPM)", "Ambient Noise (db)", "Cognitive Load", "Mood State", "Respiration Rate (BPM)", "Skin Temp (°C)", "Focus Duration (s)",
                   "Task Type", "Age", "Educational Level", "Study Major"),
      Deskripsi = c(
        "Kondisi mental atau emosional yang terdeteksi dari data biosensor.",
        "Pengukuran fluktuasi interval antara detak jantung yang menunjukkan keseimbangan antara sistem saraf simpatik dan parasimpatik.",
        "Perubahan konduktansi kulit yang terjadi akibat aktivitas keringat.",
        "Gelombang Delta berhubungan dengan tidur dan pemulihan tubuh.",
        "Gelombang Alpha terkait dengan relaksasi dan perhatian yang terfokus.",
        "Gelombang Beta berhubungan dengan aktivitas mental yang tinggi seperti kecemasan atau fokus intens.",
        "Kategori tekanan darah yang diukur melalui sistolik dan diastolik sesuai dengan kategori WHO.",
        "Persentase oksigen dalam darah.",
        "Tingkat detak jantung yang mencerminkan tingkat kegembiraan fisik atau emosional seseorang.",
        "Intensitas suara sekitar.",
        "Jumlah usaha mental yang diperlukan untuk menyelesaikan suatu tugas.",
        "Kondisi emosional seseorang.",
        "Aktivitas pernapasan seseorang dalam satuan detak per menit (BPM).",
        "Suhu kulit.",
        "Waktu yang dihabiskan untuk mempertahankan perhatian pada suatu tugas.",
        "Jenis aktivitas yang dilakukan dalam konteks pendidikan atau pekerjaan.",
        "Usia seseorang.",
        "Tingkat pendidikan individu.",
        "Bidang studi yang ditekuni oleh individu."
      )
    )
  })
  
  # Render UI untuk memilih variabel numerik di tab "Numerik"
  output$numerik_var_select <- renderUI({
    if (input$numerik_plot == "Scatter Plot") {
      tagList(
        selectInput("x_var", "Pilih Variabel X:", choices = names(data_numerik)),
        selectInput("y_var", "Pilih Variabel Y:", choices = names(data_numerik))
      )
    } else if (input$numerik_plot == "Heat Map") {
      selectInput("heatmap_vars", "Pilih Variabel untuk Korelasi:", choices = names(data_numerik), multiple = TRUE)
    } else {
      selectInput("single_var", "Pilih Variabel:", choices = names(data_numerik))
    }
  })
  
  # Render plot untuk data numerik
  output$numerik_plot_output <- renderPlot({
    if (input$numerik_plot == "Histogram") {
      ggplot(data_numerik, aes_string(x = input$single_var)) +
        geom_histogram(fill = "darkred", color = "white", bins = 30) +
        theme_minimal() +
        labs(title = "Histogram", x = input$single_var, y = "Frequency")
    } else if (input$numerik_plot == "Scatter Plot") {
      ggplot(data_numerik, aes_string(x = input$x_var, y = input$y_var)) +
        geom_point(alpha = 0.7, color = "darkred") +
        theme_minimal() +
        labs(title = "Scatter Plot", x = input$x_var, y = input$y_var)
    } else if (input$numerik_plot == "Heat Map") {
      selected_vars <- input$heatmap_vars
      if (length(selected_vars) >= 2) {
        corr_data <- data_numerik %>% 
          select(all_of(selected_vars)) %>% 
          cor(method = "pearson", use = "complete.obs")
        
        # Convert the correlation matrix to long format for ggplot2
        corr_data_long <- reshape2::melt(corr_data, varnames = c("Var1", "Var2"))
        
        ggplot(corr_data_long, aes(x = Var1, y = Var2, fill = value)) +
          geom_tile() +
          scale_fill_gradient2(low = "#FADADD", high = "darkred", mid = "#FFB6C1", midpoint = 0) +
          theme_minimal() +
          labs(title = "Heat Map", x = "", y = "") +
          theme(axis.text.x = element_text(angle = 45, hjust = 1), 
                axis.text.y = element_text(angle = 45, hjust = 1)) +  # Rotate axis labels for readability
          geom_text(aes(label = round(value, 2)), color = "black", size = 3)  # Add correlation values on the heatmap
      }
    }
  })
  
  # Render UI untuk memilih variabel kategorik di tab "Kategorik"
  output$kategorik_var_select <- renderUI({
    selectInput("kategorik_var", "Pilih Variabel Kategorik:", choices = names(data_kategorik))
  })
  
  # Render plot untuk data kategorik
  output$kategorik_plot_output <- renderPlot({
    # Cek apakah input plot adalah Pie-Chart
    if (input$kategorik_plot == "Pie-Chart") {
      # Pastikan kolom yang dipilih adalah faktor
      data_kategorik[[input$kategorik_var]] <- factor(data_kategorik[[input$kategorik_var]])
      
      # Hitung frekuensi masing-masing kategori
      freq_table <- table(data_kategorik[[input$kategorik_var]])
      
      # Membuat Pie Chart dengan warna satu tone seperti maroon, merah, putih hampir pink
      p <- ggplot(as.data.frame(freq_table), aes(x = "", y = Freq, fill = Var1)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Pie Chart", x = "", y = "") +
        theme_minimal() +
        theme(axis.text.x = element_blank(), axis.ticks = element_blank()) +
        scale_fill_manual(values = c("#800000", "#DC143C", "#FFB6C1", "#FF6347", "#C71585")) # Warna yang diinginkan
      
      # Menambahkan label persentase di pie chart
      p + geom_label_repel(
        aes(
          label = paste0(round(Freq/sum(Freq)*100, 1), "%"),
          y = cumsum(Freq) - Freq / 2
        ),
        size = 5,
        color = "white",
        fill = "black",
        box.padding = 0.3,
        point.padding = 0.5,
        show.legend = FALSE
      ) +
        theme(
          plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
          legend.position = "right",
          legend.title = element_text(size = 12, face = "bold"),
          legend.text = element_text(size = 10)
        )
    } else if (input$kategorik_plot == "Count Plot") {
      # Jika memilih Count Plot, buat plot bar biasa
      ggplot(data_kategorik, aes_string(x = input$kategorik_var, fill = input$kategorik_var)) +
      geom_bar() +
      scale_fill_manual(values = c("#800000", "#DC143D", "#FFB6C1", "#FF6347", "#C71585")) + # Warna yang diinginkan
      theme_minimal() +
      labs(title = "Count Plot", x = input$kategorik_var, y = "Count") +
      theme(
        plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
        legend.position = "none",  # Menyembunyikan legenda
        axis.text.x = element_text(angle = 45, hjust = 1)  # Memiringkan teks pada sumbu x agar lebih rapi
      )
    }
  })
    # Observe the prediction button
    observeEvent(input$submit_kondisi, {
      # Validate inputs
      if (is.null(input$GSR) || is.null(input$EEG_Delta) || 
          is.null(input$EEG_Beta) || is.null(input$Cognitive_Load)) {
        output$prediksi_kondisi <- renderText("Harap masukkan semua nilai variabel.")
        output$saran_kondisi <- renderText("")
        return()
      }
      model <- readRDS("psychological_model.rds")
      # Create a new data frame for prediction
      user_data <- data.frame(
        GSR..μS. = input$GSR,
        EEG.Delta = input$EEG_Delta,
        EEG.Beta = input$EEG_Beta,
        Cognitive.Load_Numeric = as.numeric(input$Cognitive_Load)
      )
      
      # Predict psychological state
      prediction <- predict(model, user_data)
      
      # Map prediction to descriptive text
      deskripsi <- as.character(prediction)
      
      # Map prediction to suggestions
      saran <- switch(as.character(prediction),
                      "Anxious" = "Lakukan meditasi atau latihan pernapasan untuk meredakan kecemasan.",
                      "Focused" = "Pertahankan pola kerja yang teratur dan istirahat yang cukup.",
                      "Relaxed" = "Lanjutkan aktivitas positif Anda untuk menjaga keseimbangan.",
                      "Stressed" = "Luangkan waktu untuk diri sendiri dan hindari beban berlebih.")
      
      # Display results in UI
      output$prediksi_kondisi <- renderText(deskripsi)
      output$saran_kondisi <- renderText(saran)
    })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)