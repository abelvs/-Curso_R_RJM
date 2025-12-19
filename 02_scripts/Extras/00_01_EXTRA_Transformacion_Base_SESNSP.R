pacman::p_load("dplyr", "data.table", "janitor",
               "readxl", "tidyr","writexl")


df <- read_excel("01_input/Municipal-Delitos-2015-2025_oct2025/2024.xlsx") %>% 
  clean_names()

df_total <- df %>% 
  filter(subtipo_de_delito == "Homicidio doloso") %>% 
  rowwise() %>% 
  mutate(total_anual = sum(c_across(enero:diciembre), na.rm = TRUE)) %>% 
  ungroup() %>% 
  select(-c(clave_ent, ano, ano, entidad, municipio))


write_xlsx(df_total, "01_input/Homicidios_2025.xlsx")
