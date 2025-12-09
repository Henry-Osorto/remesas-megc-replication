# ======================================================
# 03_var_model.R
# Modelo VAR/VECM: Remesas, ITCER, PIB
# ======================================================

# Libraries / Librerías
library(tidyverse)
library(readxl)
library(lubridate)
library(vars)
library(urca)
library(tsibble)
library(fabletools)

# Paths / Rutas
path_processed <- "data/processed"
setwd(path_processed) # opcional: puedes evitarlo usando file.path()

# 1. Load data / Cargar datos
df <- readxl::read_excel("Data_modelo_VAR.xlsx", sheet = "Data")

# 2. Construct time series / Construir series de tiempo
ts_var <- df |>
  mutate(
    date = yearquarter(paste(anio, trimestre, sep = " Q")),
    lrem   = log(remesas),
    lpib   = log(pib_real),
    litcer = log(ITCER)
  ) |>
  as_tsibble(index = date) |>
  select(date, lrem, lpib, litcer)

# 3. Check integration / Verificar integración (puedes llamar Pruebas ADF)
#    See script 02_unit_root_tests.R / Ver script 02_unit_root_tests.R

# 4. Estimate VECM or VAR / Estimar VECM o VAR
# (Ejemplo: VECM con urca)
y_mat <- ts(cbind(ts_var$lrem, ts_var$litcer, ts_var$lpib),
            start = c(min(year(ts_var$date)), quarter(min(ts_var$date))),
            frequency = 4)

colnames(y_mat) <- c("lrem", "litcer", "lpib")

jo_test <- ca.jo(y_mat, type = "trace", ecdet = "const", K = 2)
summary(jo_test)

vecm <- cajorls(jo_test, r = 1)
# Para VAR en niveles, podrías usar vars::VAR directamente.

# 5. Impulse Response Functions / Funciones de Impulso Respuesta
var_model <- vars::vec2var(jo_test, r = 1)

irf_vecm <- irf(
  var_model,
  impulse  = "lrem",    # shock en remesas
  response = c("litcer", "lpib"),
  n.ahead  = 12,
  boot     = TRUE,
  runs     = 1000
)

irf_df <- tibble(
  horizon      = 0:12,
  irf_litcer   = irf_vecm$irf$lrem[, "litcer"],
  irf_lpib     = irf_vecm$irf$lrem[, "lpib"],
  lower_litcer = irf_vecm$Lower$lrem[, "litcer"],
  upper_litcer = irf_vecm$Upper$lrem[, "litcer"],
  lower_lpib   = irf_vecm$Lower$lrem[, "lpib"],
  upper_lpib   = irf_vecm$Upper$lrem[, "lpib"]
)

readr::write_csv(irf_df, "IRF_VECM_remesas_TCR_PIB.csv")

# Export to Excel / Exportar a Excel
wb <- XLConnect::loadWorkbook("IRF_VECM_remesas_TCR_PIB.xlsx", create = TRUE)
XLConnect::writeWorksheet(wb, irf_df, sheet = "Data")
XLConnect::saveWorkbook(wb)
