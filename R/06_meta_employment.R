# ==========================================================
# 06_meta_employment.R
# Meta-análisis: efectos de remesas sobre empleo / ocupados
# Meta-analysis: remittances and employment outcomes
# ==========================================================

# -----------------------------
# 0. Libraries / Librerías
# -----------------------------
library(tidyverse)
library(readxl)
library(metafor)

# -----------------------------
# 1. Load processed dataset
# -----------------------------
path_processed <- "data/processed"

meta_emp <- readxl::read_excel(
  file.path(path_processed, "Metaanalisis_ocupados.xlsx")
)

# -----------------------------
# 2. Prepare effect sizes
# -----------------------------
# Adapta estas columnas a tu base real.

meta_emp <- meta_emp |>
  mutate(
    yi = log_OR,       # effect size
    vi = SE^2          # variance
  )

# -----------------------------
# 3. Run meta-analysis model
# -----------------------------
res_emp <- rma(
  yi = yi,
  vi = vi,
  data = meta_emp,
  method = "REML"
)

print(res_emp)

# -----------------------------
# 4. Forest and funnel plots
# -----------------------------
# Creamos carpeta de figuras si no existe
if (!dir.exists("figures")) dir.create("figures")

pdf("figures/forest_employment.pdf", width = 8, height = 6)
forest(res_emp,
       slab = meta_emp$study_label,  # adapta a tu columna
       xlab = "Effect Size (log OR)")
dev.off()

pdf("figures/funnel_employment.pdf", width = 8, height = 6)
funnel(res_emp, xlab = "Effect Size (log OR)")
dev.off()

message("Meta-analysis for employment completed. Figures saved in figures/.")
