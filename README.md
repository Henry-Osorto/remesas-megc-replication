# Replication Package

Remittances, Real Exchange Rate Dynamics, and Macroeconomic Vulnerability: Evidence for Honduras

This repository contains the data, code, and documentation required to reproduce all empirical results of the paper:

Osorto, H. (2025). Remittances, Real Exchange Rate Dynamics, and Macroeconomic Vulnerability: Evidence for Honduras.
(Journal name and DOI will be added once available.)

The replication package follows the standards of major academic publishers (Elsevier, Springer Nature, AEA Data Editor Guidelines), ensuring transparency, reproducibility, and open scientific practices.


# Repository Structure

remesas-megc-replication/
│
├─ README.md                 # Project overview (this file)
├─ LICENSE                   # License for code and data
├─ .gitignore                # Ignore system and temporary files
│
├─ data/
│   ├─ raw/                  # Original source files (not included)
│   │    └─ README_raw.md    # Instructions for obtaining raw data
│   └─ processed/            # Cleaned and replicated datasets
│        ├─ Data_modelo_VAR.xlsx
│        ├─ ITCER.xlsx
│        ├─ Metaanalisis_educacion.xlsx
│        └─ Metaanalisis_ocupados.xlsx
│
├─ R/                        # Scripts in recommended execution order
│   ├─ 01_download_data.R
│   ├─ 02_unit_root_tests.R
│   ├─ 03_var_model.R
│   ├─ 04_extract_meta_tables.R
│   ├─ 05_meta_education.R
│   ├─ 06_meta_employment.R
│   └─ 07_figures_remesas_use.R
│
└─ paper/
    └─ reference.md          # Citation and metadata of the article

# Data Availability
## Raw Data (Not Included)

Raw input files cannot be redistributed due to copyright and licensing restrictions.
However, all sources are publicly accessible:

- **ITCER historical PDFs** – Banco Central de Honduras  
- **BCH WebAPI data** – Remittances and macro indicators  
- **World Development Indicators (World Bank)**  — GDP and supplementary variables
- **Remittances in Latin America (IDB/CEPAL)**  — Used for metanalysis extraction


Detailed instructions for downloading each file are provided in:

`data/raw/README_raw.md`

# Processed Data (Included)

The repository includes complete processed datasets used in the empirical analysis:

- Data_modelo_VAR.xlsx — Final quarterly series (log-remittances, log-ITCER, log-GDP)

- ITCER.xlsx — Processed real exchange rate index

- Metaanalisis_educacion.xlsx and Metaanalisis_ocupados.xlsx

- Additional descriptive datasets used for figures

These datasets were generated exclusively through the R scripts provided in this repository.

# Code Availability

All R scripts required to replicate the analysis are provided.
Each script is fully documented and follows bilingual (English/Spanish) annotation.

# Execution Order

1. 01_download_data.R

- Downloads and constructs macroeconomic datasets

- Requires user API key for BCH WebAPI

2. 02_unit_root_tests.R

- Augmented Dickey–Fuller (ADF) tests for stationarity

3. 03_var_model.R

- Estimation of the VECM/VAR model

- Johansen cointegration tests

- Impulse Response Functions (IRFs)

- Exports results (CSV & Excel)

4. 04_extract_meta_tables.R

5. 05_meta_education.R

6. 06_meta_employment.R

- Meta-analysis of remittance household-use studies

- Forest and funnel plots

- Effect-size estimation with the metafor package

7. 07_figures_remesas_use.R

- Generates descriptive figures on remittance usage

Each script explicitly documents which table/figure of the article it reproduces.

#API Key Configuration

To download data from the BCH WebAPI, the API key must be stored securely in .Renviron.

Add the following line:

BCH_API_KEY=your_api_key_here


# Software Requirements

This project requires:

- R ≥ 4.2

- The following R packages:

install.packages(c(
  "tidyverse", "jsonlite", "wbstats", "readxl", "XLConnect",
  "lubridate", "vars", "urca", "tsibble",
  "fabletools", "metafor", "gridExtra", "scales"
))

Some packages (e.g., tabulapdf) may require system-level dependencies;
instructions are provided in the corresponding scripts.


# Reproducibility Workflow

Run the commands below to fully reconstruct the results:
source("R/01_download_data.R")
source("R/02_unit_root_tests.R")
source("R/03_var_model.R")
source("R/04_extract_meta_tables.R")
source("R/05_meta_education.R")
source("R/06_meta_employment.R")
source("R/07_figures_remesas_use.R")

Alternatively, execute each script interactively following the numbering.


Licenses

- Code: MIT License (permitting open use, modification, and distribution)

- Processed Data: CC BY 4.0 (attribution required)

The full license text is provided in the LICENSE file.



# Citation

If you use this material, please cite:

Osorto, H. (2025). Remittances, Real Exchange Rate Dynamics, and Macroeconomic Vulnerability in Honduras.
Replication package available at: https://github.com/henryosorto/remesas-megc-replication

.
(Update with DOI once archived in Zenodo.)


# Contact

For questions, collaborations, or methodological inquiries:

Henry Osorto
Department of Economics
UNAH - Universidad Nacional Autónoma de Honduras
Email: henry.osorto@unah.edu.hn
GitHub: https://github.com/Henry-Osorto
