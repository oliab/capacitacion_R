## Script
library(tidyverse)
library(readr)
library(lubridate)
library(ggplot2)
library(leaflet)
library(shiny)

installed.packages("readr")




flights <- read_csv("data/flights.csv")
View(flights)

variable_1 <- "Palabra"

variable2 <- 2
variable3 <- 2


vectores <- c(2,5,14,5,66)
vectores1 <- c(2,5,14,5,66,44)

length(vectores)

nombres <- c("Carlos", "Luis","María")


class(nombres)
class(vectores)
class(flights)

nombres[4]

vectores

sum(vectores)
mean(vectores)


dataframe <- data.frame(Titulacion = c("Economía", "ADE", "Sociología", "Magisterio"), Edad = c(25, 27, 25, 24))
dataframe

colnames(dataframe)
colnames(flights)

dataframe$Titulacion
dataframe$Edad

mean(dataframe$Edad)

mean(flights$hour, na.rm = TRUE)

head(flights)
tail(flights)

x <- c(1,2,NA,NA,5)

sum(x, na.rm = TRUE)

is.na(x)

malos <- is.na(x)  # identificamos los NA. La función is.na() es una función lógica.
malos

x[!malos]


data("airquality")
head(airquality)

datos <-airquality
datos

dim(datos)

completos <- datos[complete.cases(datos),]


a <- datos[datos$Month==5 & datos$Day>=6 ,] 

mean(a$Temp, na.rm = TRUE)
