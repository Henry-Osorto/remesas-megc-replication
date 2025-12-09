# ==========================================================
# 04_extract_meta_tables.R
# Extrae tablas del PDF "Remesas en América Latina" y
# construye las bases para los metaanálisis:
#   - Metaanalisis_educacion.xlsx
#   - Metaanalisis_ocupados.xlsx
#
# Extracts tables from the PDF "Remittances in Latin America"
# and builds the datasets used for meta-analysis.
# ==========================================================

# -----------------------------
# 0. Libraries / Librerías
# -----------------------------
library(tidyverse)
library(readxl)
library(writexl)
# Si usas tabulapdf u otro paquete para extraer tablas:
# library(tabulapdf)  # o el paquete que realmente utilices

# -----------------------------
# 1. Paths / Rutas
# -----------------------------
path_raw       <- "data/raw"
path_processed <- "data/processed"

pdf_path <- file.path(path_raw, "Remesas_en_America_Latina.pdf")

# -----------------------------
# 2. Extract tables from PDF
#    (adaptar según el paquete que uses)
# -----------------------------
# NOTE:
# - Aquí debes adaptar el código a la función real que uses
#   para extraer tablas del PDF (tabulapdf, tabulizer, etc.)
# - Esta parte es un esqueleto.

# Example (pseudo-code):
# tables_list <- tabulapdf::extract_tables(pdf_path)

# # Convert each table to tibble
# tables_tbl <- lapply(tables_list, as_tibble)

# -----------------------------
# 3. Clean and select relevant tables
#    Limpieza y selección de tablas relevantes
# -----------------------------
# Supongamos que:
# - Una tabla contiene proporciones/efectos relacionados
#   con educación -> base_educacion
# - Otra tabla contiene ocupados -> base_ocupados
#
# Aquí es donde debes replicar tu lógica original de limpieza,
# pero con nombres de variables claros y en inglés/español.

# Ejemplo ilustrativo (modificar por tus nombres reales):
# base_educacion <- tables_tbl[[1]] |>
#   clean_names() |>
#   mutate(
#     # E.g. effect size, standard error
#     yi = log(OR_educacion),
#     vi = SE_educacion^2
#   )

# base_ocupados <- tables_tbl[[2]] |>
#   clean_names() |>
#   mutate(
#     yi = log(OR_ocupados),
#     vi = SE_ocupados^2
#   )

# -----------------------------
# 4. Save processed datasets
#    Guardar bases procesadas
# -----------------------------

# Asegúrate de tener:
#   - data_processed_educacion (tibble)
#   - data_processed_ocupados (tibble)
# construidos a partir de tu código original.
# Aquí coloco nombres genéricos, tú los reemplazas.

# writexl::write_xlsx(
#   base_educacion,
#   path = file.path(path_processed, "Metaanalisis_educacion.xlsx")
# )

# writexl::write_xlsx(
#   base_ocupados,
#   path = file.path(path_processed, "Metaanalisis_ocupados.xlsx")
# )

# message("Meta-analysis input datasets saved in data/processed/")
