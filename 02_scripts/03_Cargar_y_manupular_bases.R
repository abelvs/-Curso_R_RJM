############################################
# Tidyverse: Cargar y manipular bases
############################################

library(tidyverse)
library(readxl)

############################################
# 1. Cargar base de datos
############################################

df <- read_xlsx("01_input/Ejemplo_1_calificaciones.xlsx")


############################################
# 2. filter(): seleccionar filas
############################################

df %>% 
  filter(ciudad == "CDMX")

df %>% 
  filter(nombre == "Rich")

# Guardar un objeto filtrado
df_cdmx <- df %>% 
  filter(ciudad == "CDMX")

df_cdmx_o_mty <- df %>% 
  filter(ciudad %in% c("CDMX", "MTY"))


############################################
# 3. mutate(): crear nuevas columnas
############################################

# Filtrar por condiciones combinadas
df %>% 
  filter(nombre == "Jorge")

df %>% 
  filter(nombre == "Jorge" & apellido == "Silva")

# Crear nombre completo
df_nombres <- df %>% 
  mutate(nombre_completo = paste(nombre, apellido, sep = " "))

df_nombres %>% 
  filter(nombre_completo == "Jorge Silva")

# Columna condicional simple
df_aprobado <- df_nombres %>% 
  mutate(aprobado_si_no = ifelse(calificacion >= 6, "si", "no")) %>% 
  select(nombre_completo, calificacion, aprobado_si_no)

df_aprobado %>% 
  count(aprobado_si_no)

# Columna condicional múltiple (case_when)
df_rangos <- df %>% 
  mutate(
    rango = case_when(
      calificacion < 6           ~ "Reprobado",
      calificacion < 7.5         ~ "Deficiente",
      calificacion < 9           ~ "Satisfactorio",
      calificacion >= 9          ~ "Sobresaliente"
    )
  )

df_rangos %>% 
  count(rango)


############################################
# 4. group_by() + summarise()
############################################

df %>% 
  group_by(ciudad)

df_ciudades <- df %>% 
  group_by(ciudad) %>% 
  summarise(calificacion_promedio = mean(calificacion))

df_ciudades

df_modalidades <- df %>% 
  group_by(modalidad_de_aprendizaje) %>% 
  summarise(calificacion_promedio = mean(calificacion))

df_modalidades
