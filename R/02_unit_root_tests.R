# ======================================================
# 02_unit_root_tests.R
# Pruebas ADF para lrem, litcer, lpib
# ======================================================

library(tidyverse)
library(readxl)
library(urca)

df <- readxl::read_excel("data/processed/Data_modelo_VAR.xlsx", sheet = "Data")

ts_var <- ts(
  cbind(
    lrem   = log(df$remesas),
    litcer = log(df$ITCER),
    lpib   = log(df$pib_real)
  ),
  start = c(min(df$Año), min(df$Trimestre)),
  frequency = 4
)

summary(ur.df(ts_var[, "lrem"],   type = "trend", lags = 4))
summary(ur.df(ts_var[, "litcer"], type = "trend", lags = 4))
summary(ur.df(ts_var[, "lpib"],   type = "trend", lags = 4))
