############################################
# Tidyverse: primeros pasos
############################################

# Instalar tidyverse (solo se hace una vez)
install.packages("tidyverse")

# Cargar tidyverse
library(tidyverse)

# Datos de ejemplo
df <- tibble(
  nombre = c("Abel", "Mariana", "Rich"),
  edad   = c(30, 27, 30),
  ciudad = c("CDMX", "GDL", "MTY")
)

# Ver los datos
df

# Filtrar filas
df %>% 
  filter(ciudad == "CDMX")

# Crear nuevas variables
df %>% 
  mutate(edad_2 = edad * 2)

# Resumir datos
df %>% 
  summarise(promedio_edad = mean(edad))

# Agrupar y resumir
df %>% 
  group_by(ciudad) %>% 
  summarise(promedio_edad = mean(edad))

