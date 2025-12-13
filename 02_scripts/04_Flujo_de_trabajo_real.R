
library(tidyverse)
library(readxl)
library(scales)



#Cargamos base ejemplo de incidencia delictiva

df_delitos <- read_xlsx("01_input/Ejemplo_2_incidencia_estatal_delitos_2015_2025_oct.xlsx")

unique(df_delitos$subtipo_de_delito)

tabla_regiones <- df_delitos %>% 
  filter(ano >= 2018 & ano <= 2024) %>% 
  filter(subtipo_de_delito == "Robo a transportista") %>% 
  mutate(region = case_when( 
    
    entidad %in% c("Baja California",
                   "Baja California Sur",
                   "Sonora") ~ "Noroeste",
    
    entidad %in% c("Chihuahua",
                   "Coahuila de Zaragoza",
                   "Nuevo León",
                   "Tamaulipas") ~ "Noreste",
    
    entidad %in% c("Sinaloa",
                   "Durango",
                   "Zacatecas") ~ "Norte-Centro",
    
    entidad %in% c("Jalisco",
                   "Nayarit",
                   "Colima",
                   "Michoacán de Ocampo") ~ "Occidente",
    
    entidad %in% c("Aguascalientes",
                   "Guanajuato",
                   "Querétaro",
                   "San Luis Potosí") ~ "Centro",
    
    entidad %in% c("Hidalgo",
                   "México",
                   "Ciudad de México",
                   "Morelos",
                   "Tlaxcala",
                   "Puebla") ~ "Centro-Sur",
    
    entidad %in% c("Veracruz de Ignacio de la Llave",
                   "Tabasco") ~ "Golfo",
    
    entidad %in% c("Guerrero",
                   "Oaxaca",
                   "Chiapas") ~ "Sur",
    
    entidad %in% c("Campeche",
                   "Yucatán",
                   "Quintana Roo") ~ "Sureste"
  )) %>% 
  group_by(region) %>% 
  summarise(total = sum(total)) %>% 
  ungroup() %>% 
  mutate(porc = total/sum(total)) %>% 
  arrange(-porc) %>% 
  mutate(porc = percent(porc))

#Exportamos

write_xlsx(tabla_regiones, "03_outputs/Robo_a_Transportista_por_Region_2018-2024.xlsx")


  

