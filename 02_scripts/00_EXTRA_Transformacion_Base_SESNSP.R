pacman::p_load("dplyr", "data.table", "janitor",
               "readxl", "tidyr","writexl")


df <- fread("01_input/Estatal-Delitos-2015-2025_oct2025.csv",
            encoding = "Latin-1") %>% 
  clean_names()

df_total <- df %>% 
  rowwise() %>% 
  mutate(total_anual = sum(c_across(enero:diciembre), na.rm = TRUE)) %>% 
  ungroup() 

df_limpia <- df_total %>% 
  group_by(ano, entidad, subtipo_de_delito) %>% 
  summarise(total = sum(total_anual))

write_xlsx(df_limpia, "01_input/Ejemplo_2_incidencia_estatal_delitos_2015_2025_oct.xlsx")
