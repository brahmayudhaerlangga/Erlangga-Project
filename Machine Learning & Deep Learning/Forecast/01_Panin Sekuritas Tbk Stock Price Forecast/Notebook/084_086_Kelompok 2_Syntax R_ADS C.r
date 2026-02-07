# Load dan siapkan data
library(tseries)
library(fUnitRoots)
library(forecast)
library(keras3)
library(tensorflow)
library(dplyr)
library(ggplot2)
library(scales)
library(lubridate)

set.seed(42)
tensorflow::tf$random$set_seed(42L)

setwd("C:/Users/izzyr/OneDrive/Documents/Rangga/Kuliah S1 Statistika/Sem 6/ADS/FP")
data <- read.csv("Data Historis PANS Harian 2020-2025.csv", header = TRUE, sep = ",", colClasses = "character")

# Bersihkan data
kolom_target <- c("Terakhir", "Pembukaan", "Tertinggi", "Terendah")
data[kolom_target] <- lapply(data[kolom_target], function(x) as.numeric(gsub("\\.", "", x)))
data$Tanggal <- as.Date(data$Tanggal, format = "%d/%m/%Y")
data <- data[order(data$Tanggal), ]
rownames(data) <- as.character(data$Tanggal)

# Uji linearitas dengan Terasvirta
data_ts <- ts(data$Terakhir)
plot(data_ts, main="Harga Saham PANS Time Series", ylab="Price", xlab="Time")
terasvirta.test(data_ts)

# Uji stasioneritas & ARIMA
unitrootTest(data$Terakhir, lags=1, type="nc")
data_diff <- diff(data$Terakhir)
unitrootTest(data_diff, lags=1, type="nc")

# Splitting Data
proporsi_training <- 0.9
n_total <- length(data_ts)
n_training <- floor(n_total * proporsi_training)
n_testing <- n_total - n_training
cat(paste0("Total Observasi: ", n_total, "\n"))
cat(paste0("Observasi Training: ", n_training, "\n"))
cat(paste0("Observasi Testing: ", n_testing, "\n\n"))
data_training <- window(data_ts, end = time(data_ts)[n_training])
data_testing <- window(data_ts, start = time(data_ts)[n_training + 1])
cat("Panjang data_training:", length(data_training), "\n")
cat("Panjang data_testing:", length(data_testing), "\n")
cat("Periode data_training:", start(data_training), "sampai", end(data_training), "\n")
cat("Periode data_testing:", start(data_testing), "sampai", end(data_testing), "\n")

# Auto ARIMA
arimafit <- auto.arima(data_training)
forecast_arima <- forecast(arimafit, h=130)
plot(forecast_arima)
summary(arimafit)

# Visualisasi tren awal
ggplot(data, aes(x = Tanggal, y = Terakhir)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(title = "Tren Harga Mingguan BBCA 2020-2025", x = "Date", y = "Harga IDR (Rp)") +
  theme_minimal() +
  scale_y_continuous(labels = comma)

# Normalisasi data
min_val <- min(data$Terakhir)
max_val <- max(data$Terakhir)
normalized_data <- (data$Terakhir - min_val) / (max_val - min_val)

# Fungsi sequence
create_sequences <- function(data, seq_length) {
  X <- array(0, dim = c(length(data) - seq_length, seq_length, 1))
  y <- array(0, dim = c(length(data) - seq_length, 1))
  for (i in 1:(length(data) - seq_length)) {
    X[i, , 1] <- data[i:(i + seq_length - 1)]
    y[i, 1] <- data[i + seq_length]
  }
  return(list(X = X, y = y))
}

# Sequence dan split
depth <- 60
seqs <- create_sequences(normalized_data, depth)
X <- seqs$X; y <- seqs$y
train_size <- floor(0.8 * nrow(X))
X_train <- X[1:train_size,,,drop=FALSE]; y_train <- y[1:train_size,,drop=FALSE]
X_test <- X[(train_size+1):nrow(X),,,drop=FALSE]; y_test <- y[(train_size+1):nrow(y),,drop=FALSE]

# Bangun model LSTM
model <- keras_model_sequential() %>%
  layer_lstm(100, return_sequences = TRUE, input_shape = c(depth, 1)) %>%
  layer_dropout(0.2) %>%
  layer_lstm(100, return_sequences = FALSE) %>%
  layer_dropout(0.2) %>%
  layer_dense(32) %>%
  layer_dense(1)

model %>% compile(optimizer = optimizer_adam(0.001), loss = 'mse', metrics = 'mae')
model %>% fit(X_train, y_train, epochs = 100, batch_size = 32, validation_split = 0.2, verbose = 1)

# Evaluasi train
pred_train <- model %>% predict(X_train)
pred_train <- pred_train * (max_val - min_val) + min_val
y_train <- y_train * (max_val - min_val) + min_val

cat("Train Metrics:\nRMSE:", sqrt(mean((pred_train - y_train)^2)),
    "\nMAE:", mean(abs(pred_train - y_train)),
    "\nMAPE:", mean(abs((y_train - pred_train) / y_train)) * 100, "%\n")

# Evaluasi test
pred <- model %>% predict(X_test)
pred <- pred * (max_val - min_val) + min_val
y_test <- y_test * (max_val - min_val) + min_val

cat("Test Metrics:\nRMSE:", sqrt(mean((pred - y_test)^2)),
    "\nMAE:", mean(abs(pred - y_test)),
    "\nMAPE:", mean(abs((y_test - pred) / y_test)) * 100, "%\n")

# Plot prediksi
comparison_df <- data.frame(
  date = data$Tanggal[(train_size + depth + 1):nrow(data)],
  actual = as.numeric(y_test),
  predicted = as.numeric(pred)
)

ggplot(comparison_df, aes(x = date)) +
  geom_line(aes(y = actual, color = "Actual")) +
  geom_line(aes(y = predicted, color = "Predicted")) +
  scale_color_manual(values = c("Actual" = "blue", "Predicted" = "red")) +
  labs(title = "LSTM Forecast: Actual vs Predicted", x = "Date", y = "Price") +
  theme_minimal()

# Forecast masa depan
forecast_future <- function(model, last_seq, n, minv, maxv, hist) {
  forecasts <- numeric(n)
  diff_hist <- diff(hist)
  mean_diff <- mean(diff_hist, na.rm=TRUE)
  sd_diff <- sd(diff_hist, na.rm=TRUE)
  max_change <- max(abs(diff_hist), na.rm=TRUE)
  recent_vol <- sd(tail(diff_hist, 20), na.rm=TRUE)

  for (i in 1:n) {
    input <- array(last_seq, dim = c(1, length(last_seq), 1))
    pred <- model %>% predict(input, verbose = 0)
    volatility_factor <- recent_vol / (maxv - minv) * 3
    nonlin_adj <- rnorm(1, 0, volatility_factor) * (max_change / (maxv - minv)) * 2
    trend_adj <- mean_diff / (maxv - minv) * (1 + rnorm(1, 0, 0.3))
    adjusted_pred <- pred[1, 1] + nonlin_adj + trend_adj
    adjusted_pred <- max(min(adjusted_pred, 1), 0)
    forecasts[i] <- adjusted_pred
    last_seq <- c(last_seq[-1], adjusted_pred)
  }

  forecasts * (maxv - minv) + minv
}

n_future <- 72
last_seq <- normalized_data[(length(normalized_data) - depth + 1):length(normalized_data)]
future_vals <- forecast_future(model, last_seq, n_future, min_val, max_val, data$Terakhir)
future_dates <- seq(from = max(data$Tanggal) + weeks(1), by = "week", length.out = n_future)

# Plot data historis + forecast
data$type <- "Historical"
future_df <- data.frame(Tanggal = future_dates, Terakhir = future_vals, type = "Forecast")

full_plot <- ggplot() +
  geom_line(data = data, aes(x = Tanggal, y = Terakhir, color = type), size = 1) +
  geom_line(data = future_df, aes(x = Tanggal, y = Terakhir, color = type), size = 1) +
  geom_point(data = future_df, aes(x = Tanggal, y = Terakhir), color = "red", size = 2) +
  labs(title = "Harga Saham PANS: Historical vs Forecast", x = "Tanggal", y = "Harga IDR (Rp)") +
  theme_minimal() +
  scale_color_manual(values = c("Historical" = "blue", "Forecast" = "red")) +
  scale_y_continuous(labels = comma)

print(full_plot)

# Tabel hasil ramalan
result_tbl <- data.frame(Date = format(future_dates, "%Y-%m"), Forecast = round(future_vals, 0))
print(result_tbl)

cat("\nForecasting completed successfully!\n")
