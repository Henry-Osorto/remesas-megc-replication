# Raw Data Instructions

This folder contains instructions for obtaining the **raw data files** required to fully reproduce the processed datasets used in the paper.

Raw files are **NOT included** in this repository due to copyright and licensing restrictions.  
However, all sources are publicly accessible through the links below.

---

## 1. ITCER (Real Exchange Rate Index)

Source: **Banco Central de Honduras (BCH)**  
URL: https://www.bch.hn/estadisticas-y-publicaciones-economicas/tipo-de-cambio-efectivo-real

Download the historical ITCER PDF files corresponding to the years used in the analysis.  
Place the PDF(s) inside this folder before running:


---

## 2. Remittances and Macroeconomic Data (BCH WebAPI)

These indicators (remittances, exchange rate index, etc.) are publicly available via the BCH WebAPI.

You must request an API key from BCH if you do not already have one.

Store your API key safely by adding the following line to your `.Renviron` file:


The script `R/01_download_data.R` will automatically download and process these data.

---

## 3. World Bank – GDP and Additional Indicators

Source: **World Development Indicators (WDI)**  
URL: https://data.worldbank.org/

The script `R/01_download_data.R` downloads these data directly using the `wbstats` package.

No manual download is required.

---

## 4. Remittances in Latin America (IDB/CEPAL Report)

A PDF report used to extract effect sizes for the meta-analysis.

Typical sources:
- https://www.cepal.org/
- https://www.iadb.org/

Save the PDF file in this folder with the original file name and run:


---

## Notes

- Processed datasets built from these raw sources are already included in `data/processed/`.  
- Raw files are only required if you wish to reconstruct the full workflow from scratch.  
- This structure complies with standard replication-package requirements from AEA, Elsevier, and Springer.


