## Clase 3:

# Ejercicios:

datos <-  read_csv(
  "data/estatal.csv",
  locale = readr::locale(encoding = "latin1"),
  show_col_types = FALSE
) 

datos <- datos %>% 
  gather("mes","total_delitos",Enero:Diciembre)

colnames(datos)<- c("anio","cve_entidad","entidad","bien_juridico_afectado","tipo_delito","subtipo_delito",
                    "modalidad","mes","total_delitos")

## Para cada año, ¿Cuál fue el mes con mayor número de delitos?¿Qué delito fue?

datos %>% 
  group_by(anio,tipo_delito) %>% 
  summarise(total_delitos=sum(total_delitos)) %>% 
  arrange(anio,desc(total_delitos))


## ¿Qué modalidad de homicidio fue la ? 


