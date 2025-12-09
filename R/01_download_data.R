# ======================================================
# 01_download_data.R
# Descarga y construcción de la base principal
# Download and construction of the main dataset
# ======================================================

# ------------------------------
# 0. Libraries / Librerías
# ------------------------------
library(jsonlite)   # API calls / Llamadas a la API
library(wbstats)    # World Bank data
library(tidyverse)
library(readxl)
library(XLConnect)  # Excel writing / Escritura de Excel

# ------------------------------
# 1. User paths / Rutas del usuario
#    Ajusta SOLO esta sección para tu entorno local.
#    Only edit this section for your local paths.
# ------------------------------
path_raw      <- "data/raw"
path_processed <- "data/processed"

if (!dir.exists(path_raw)) dir.create(path_raw, recursive = TRUE)
if (!dir.exists(path_processed)) dir.create(path_processed, recursive = TRUE)

# ------------------------------
# 2. BCH API: Remittances / Remesas
# ------------------------------

# IMPORTANT / IMPORTANTE:
# Do NOT hard-code your API key in the script.
# NO coloques tu clave de API en el script.
bch_api_key <- Sys.getenv("BCH_API_KEY")

if (identical(bch_api_key, "") || is.na(bch_api_key)) {
  stop("Please set BCH_API_KEY in your .Renviron file / Define BCH_API_KEY en tu .Renviron")
}

base_url <- "https://bchapi-am.azure-api.net/api/v1/indicadores"

query <- list(
  formato = "Json",
  clave   = bch_api_key
)

url_consulta <- paste0(
  base_url,
  "?formato=", query$formato,
  "&clave=", query$clave
)

remesas_raw <- jsonlite::fromJSON(url_consulta)

# Aquí insertas tu lógica original de limpieza
# Here you insert your original cleaning logic
remesas <- remesas_raw |>
  separate(Fecha, into = c("anio", "mes"), sep = "-") |>
  mutate(
    anio = as.integer(anio),
    mes  = as.integer(mes),
    trimestre = case_when(
      mes == 3  ~ 1L,
      mes == 6  ~ 2L,
      mes == 9  ~ 3L,
      mes == 12 ~ 4L,
      TRUE      ~ NA_integer_
    )
  ) |>
  select(anio, trimestre, remesas = Valor) |>
  arrange(anio, trimestre)

# ------------------------------
# 3. World Bank: GDP / PIB
# ------------------------------
# TODO: reemplaza "NY.GDP.MKTP.KD" por el indicador exacto que usas.
# TODO: replace with the exact series you use.

pib_raw <- wbstats::wb_data(
  indicator = "NY.GDP.MKTP.KD",
  country   = "HN",
  start_date = 2000,
  end_date   = 2024
)

# Agrega aquí el paso para convertir a PIB trimestral si corresponde.
# Add the step to convert to quarterly GDP if needed.

# ------------------------------
# 4. ITCER (from processed file) / ITCER (archivo procesado)
# ------------------------------
itcer <- readxl::read_excel(file.path(path_processed, "ITCER.xlsx"))

# ------------------------------
# 5. Merge into final dataset / Fusionar en la base final
# ------------------------------
data_var <- remesas |>
  left_join(pib, by = c("anio" = "date_stub", "trimestre" = "quarter_stub")) |>
  left_join(itcer, by = c("anio" = "Año", "trimestre" = "Trimestre"))

# ------------------------------
# 6. Save / Guardar
# ------------------------------
wb <- XLConnect::loadWorkbook(file.path(path_processed, "Data_modelo_VAR.xlsx"), create = TRUE)
XLConnect::writeWorksheet(wb, data_var, sheet = "Data")
XLConnect::saveWorkbook(wb)

# Fin / End
