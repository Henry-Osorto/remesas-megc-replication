# ==========================================================
# 05_meta_education.R
# Meta-análisis: efectos de remesas sobre educación
# Meta-analysis: remittances and education outcomes
# ==========================================================

# -----------------------------
# 0. Libraries / Librerías
# -----------------------------
library(tidyverse)
library(readxl)
library(metafor)

# -----------------------------
# 1. Load processed dataset
#    Cargar base procesada
# -----------------------------
path_processed <- "data/processed"

meta_edu <- readxl::read_excel(
  file.path(path_processed, "Metaanalisis_educacion.xlsx")
)

# -----------------------------
# 2. Prepare effect sizes
#    Preparar tamaños de efecto
# -----------------------------
# Aquí debes adaptar las columnas a tu base real.
# Supongamos que tienes:
#   - log_OR  : log odds ratio
#   - SE      : standard error
#
# Adjust the column names to match your data.

meta_edu <- meta_edu |>
  mutate(
    yi = log_OR,        # tamaño de efecto
    vi = SE^2           # varianza del efecto
  )

# -----------------------------
# 3. Run meta-analysis model
#    Estimar modelo de meta-análisis
# -----------------------------
res_edu <- rma(
  yi = yi,
  vi = vi,
  data = meta_edu,
  method = "REML"
)

print(res_edu)

# -----------------------------
# 4. Forest and funnel plots
#    Crear gráficos forest y funnel
# -----------------------------
# Forest plot
pdf("figures/forest_education.pdf", width = 8, height = 6)
forest(res_edu,
       slab = meta_edu$study_label,  # adapta el nombre de columna
       xlab = "Effect Size (log OR)")
dev.off()

# Funnel plot
pdf("figures/funnel_education.pdf", width = 8, height = 6)
funnel(res_edu, xlab = "Effect Size (log OR)")
dev.off()

message("Meta-analysis for education completed. Figures saved in figures/.")
