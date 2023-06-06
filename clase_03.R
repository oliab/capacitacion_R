## Left Join

crimen_mexico <- read_csv("data/crimen_mexico.csv")

## Para 2020, Número de homicidios por estado

base <- crimen_mexico %>% 
  filter(!is.na(total_Delitos)) %>% 
  filter(año==2021) %>% 
  filter(tipo_delito=="Homicidio") %>% 
  group_by(entidad) %>% 
  summarise(total_delitos=sum(total_Delitos))

base

# ¿Cuál es el total per capita?

poblacion <- read_csv("datos_nuevos/datos_poblacion.csv")

poblacion

summary(poblacion)

poblacion <- poblacion %>% filter(anio==2020)

head(base)
head(poblacion)

base %>% 
  left_join(poblacion) %>% View()


## Qué pasa si hay un dato que no corresponde?

poblacion_falsa <- poblacion %>% filter(anio==2020) %>% 
  mutate(entidad=ifelse(entidad=="Ciudad de México", "Distrito Federal",entidad))

base %>% 
  left_join(poblacion_falsa) %>% View()

## que pasa si no tienen las mismas "llaves"

colnames(poblacion_falsa)[2]<-"estado"

base %>% 
  left_join(poblacion_falsa) %>% View()

# Entonces lo específico las llaves por las que lo quiero empatar

base %>% 
  left_join(poblacion_falsa, by=c("entidad"="estado"))

#Ejercicio 1 . Haz la tasa de delitos por 100 mil habitantes




# Spread y gather Ingrso y religion

pew <- read_delim("http://stat405.had.co.nz/data/pew.txt", "\t", 
                  escape_double = FALSE, trim_ws = TRUE)

pew_tidy <- gather(data = pew, income, frequency, -religion)
pew_tidy

ggplot(pew_tidy, aes(x = income, y = frequency, color = religion, group = religion)) +
  geom_line() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


by_religion <- group_by(pew_tidy, religion)
pew_tidy_2 <- pew_tidy %>%
  filter(income != "Don't know/refused") %>%
  group_by(religion) %>%
  mutate(percent = frequency / sum(frequency)) %>% 
  filter(sum(frequency) > 1000)
head(pew_tidy_2)

income_levels <- unique(pew_tidy$income)[1:9]

ggplot(pew_tidy_2, aes(x = income, y = percent, group = religion)) +
  facet_wrap(~ religion, nrow = 1) +
  geom_bar(stat = "identity", fill = "darkgray") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_x_discrete(limits = income_levels)

## Ejercicio Remesas

# Obten las remesas anuales por estado

datos <- read_excel("datos_nuevos/remesas.xlsx")
datos <- datos %>% 
  select(Título,10:ncol(datos)) %>% 
  gather("fecha","cantidad",-Título) %>% 
  mutate(anio=substr(fecha,9,nchar(fecha))) 

datos <- datos %>% 
  filter(anio %in% c(2010,2015,2020)) %>% 
  group_by(Título , anio) %>% 
  summarise(remesas_anuales=sum(cantidad))

datos$Título <- gsub("Ingresos por Remesas Familiares, ","",datos$Título)

colnames(datos)[1]<-"entidad"


# Ejercicio
# Baja las bases de datos y
# Obten el PIB PER CAPITA ESTATAL
# Encuentra las remesas anuales y el tipo de cambio
# Calcula las remesas en pesos
# Calcula las remesas per capita estatales
