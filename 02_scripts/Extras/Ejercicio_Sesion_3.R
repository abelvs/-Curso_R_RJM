pacman::p_load("dplyr", "data.table", "janitor",
               "readxl", "tidyr","writexl", "stringr", "scales", "ggplot2")
options(scipen = 999)


#Cargar Base de datos----

df_2025 <- read_excel("01_input/Ejercicios/Incidencia_Municipal_2025.xlsx") %>% 
  clean_names %>% 
  filter(subtipo_de_delito == "Homicidio doloso") %>% 
  rowwise() %>% 
  mutate(total_anual = sum(c_across(enero:octubre), na.rm = TRUE)) %>% 
  group_by(cve_municipio) %>% 
  summarise(entidad = first(entidad),
            municipio = first(municipio),
            homicidios_2025 = sum(total_anual, na.rm = T))

df_2024 <- read_xlsx("01_input/Ejercicios/Homicidios_por_municipio_2024.xlsx")

url <- "https://www.datos.gob.mx/dataset/f2b9b220-3ef7-4e3a-bde6-87e1dac78c6a/resource/3c3092be-583e-4490-8c23-67ef9a64b198/download/pobproy_quinq1.csv"

df_pob <- fread(url) %>% 
  clean_names() %>% 
  filter(ano == 2025) %>% 
  rename(cve_municipio = clave) %>% 
  select(cve_municipio, pob_total, sexo) %>% 
  group_by(cve_municipio) %>% 
  summarise(pob_total = sum(pob_total))

df_2024 <-read_xlsx("01_input/Ejercicios/Homicidios_por_municipio_2024.xlsx") %>% 
  clean_names()

# ---------------------------------------------------------------------
# Ejercicio: Analisis
# ---------------------------------------------------------------------
# Unir el df de 2024, 2025 y los datos de población (2025) para sacar 
# la tasa por cada 1,000 habitantes, la variación nominal y porcentual
# entre 2023 y 2024.
# EXTRA: Obtén los 10 municipios con mayor variación y los 10 con mayor tasa
# Genera la versión LONG de la tabla

analisis <- df_2025 %>% 


