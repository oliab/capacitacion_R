## Clase 2:

library(readr)
library(tidyverse)

## Ejemplos de datos que no son Tidy
datos <-  read_csv(
  "data/estatal.csv",
  locale = readr::locale(encoding = "latin1"),
  show_col_types = FALSE
) %>% filter(Año==2021)


print(head(datos))


View(datos %>% 
       gather("mes","total_delitos",Enero:Diciembre) %>% 
       head(20))

datos %>% 
  gather("mes","total_delitos",Enero:Diciembre) %>% 
  group_by(Entidad,`Tipo de delito`) %>% 
  slice(1) %>% 
  select(Entidad,`Tipo de delito`, total_delitos ) %>% 
  unique() %>% 
  spread(Entidad,total_delitos) %>% View()


# Filter

crimen_mexico <- read_csv("data/crimen_mexico.csv")

filter(crimen_mexico, entidad=="Chiapas" & total_Delitos>15 & mes!="Enero")

# Select

select(crimen_mexico, año)
select(crimen_mexico, -fecha)

# Arrange

arrange(crimen_mexico, total_Delitos)
arrange(crimen_mexico, desc(total_Delitos))

arrange(crimen_mexico, tipo_delito)

# Mutate

a <- mutate(crimen_mexico, multiplicacion=total_Delitos*1000)
mutate(a, division= multiplicacion*156/total_Delitos)
mutate(a, suma=sum(total_Delitos, na.rm = TRUE))

# Summarise

summarise(a, suma=sum(total_Delitos, na.rm = TRUE))

b <- filter(crimen_mexico, año==2021)

mutate(b, suma=sum(total_Delitos, na.rm = TRUE))

## group_by

### %>% 
library(tidyverse)

crimen_mexico %>% 
  filter(entidad=="Chiapas", mes=="Enero") %>% 
  filter(!is.na(total_Delitos)) %>% 
  mutate(suma=sum(total_Delitos)) %>% 
  arrange(desc(total_Delitos)) %>% 
  summarise(final=mean(total_Delitos))


##

crimen_mexico %>% 
  filter(!is.na(total_Delitos)) %>% 
  group_by(entidad) %>% 
  mutate(total_estatal=sum(total_Delitos)) %>% 
  View()

#
crimen_mexico %>% 
  filter(!is.na(total_Delitos)) %>% # quito los nas
  group_by(entidad,  mes) %>% # estoy agrupando
  summarise(total_estatal=sum(total_Delitos))  %>% 
  spread(mes, total_estatal) %>% View()

#download.file("https://www.dropbox.com/s/nq3sg9gnvis3ezy/crimen_mexico.csv?dl=0")
