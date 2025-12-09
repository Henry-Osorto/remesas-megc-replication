# ==========================================================
# 07_figures_remesas_use.R
# Gráfico descriptivo del uso de remesas
# Descriptive plot of remittances usage
# ==========================================================

library(tidyverse)

# -----------------------------
# 1. Data: you can hard-code
#    or read from data/processed
# -----------------------------
# Opción A: datos "quemados" en el script
rem_use <- tribble(
  ~category_es,                 ~category_en,              ~share,
  "Alimentación",               "Food",                    0.35,
  "Servicios básicos",          "Basic services",          0.18,
  "Educación",                  "Education",               0.12,
  "Salud",                      "Health",                  0.10,
  "Vivienda / alquiler",        "Housing / rent",          0.09,
  "Ahorro / inversión",         "Savings / investment",    0.08,
  "Otros gastos",               "Other expenses",          0.08
)

rem_use <- rem_use |>
  mutate(
    share_pct = share * 100,
    label = paste0(round(share_pct, 1), "%")
  )

# -----------------------------
# 2. Plot
# -----------------------------
if (!dir.exists("figures")) dir.create("figures")

g <- rem_use |>
  ggplot(aes(x = reorder(category_es, share), y = share_pct)) +
  geom_col() +
  geom_text(aes(label = label), vjust = -0.3, size = 3) +
  labs(
    title = "Uso de las remesas (porcentaje del total)",
    x     = "Categoría de gasto",
    y     = "Porcentaje (%)"
  ) +
  theme_minimal()

ggsave("figures/uso_remesas_es.pdf", plot = g, width = 8, height = 5)

# Versión en inglés (opcional)
g_en <- rem_use |>
  ggplot(aes(x = reorder(category_en, share), y = share_pct)) +
  geom_col() +
  geom_text(aes(label = label), vjust = -0.3, size = 3) +
  labs(
    title = "Use of Remittances (percentage of total)",
    x     = "Spending category",
    y     = "Percentage (%)"
  ) +
  theme_minimal()

ggsave("figures/remittances_use_en.pdf", plot = g_en, width = 8, height = 5)

message("Remittances usage figures saved in figures/.")
