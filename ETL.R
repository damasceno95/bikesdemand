
# Escolhendo o Diretório de Arquivos
setwd(choose.dir())
getwd()

# Instação do pacote hflights (Dados de Voos de Houston)

install.packages("hflights")

# Pacotes para Utilização do ETL

library(hflights)
library(dplyr)

# Para Saber Mais Sobre o Pacote hflights

?hflights

# Criação de objetivo tbl

flights <- tbl_df(hflights)
flights

# Resumindo e Visualizando os Dados (Quais são os tipos de variáveis?)

glimpse(flights)
head(flights)
View(flights)

# Opção de filtragem por slice ou por filter

flights[flights$Month == 1 & flights$DayofMonth == 1,]

filter(flights, Month == 1, DayofMonth == 1)

# Realizando algumas filtragens

filCar <- filter(flights, UniqueCarrier == "AA" | UniqueCarrier == "UA")
head(filCar)
View(filCar)

# Realizando seleções

select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))

# Organização

flights %>% 
  select(UniqueCarrier,DepDelay) %>%
  arrange(DepDelay)

flights %>%
  select(Distance,AirTime) %>%
  mutate( Speed = Distance / AirTime * 60)

flights %>%
  group_by(Month,DayofMonth)%>%
  tally(sort = T)

# Checando dados NA

any(is.na(flights))

nor <- na.exclude(flights)
View(nor)