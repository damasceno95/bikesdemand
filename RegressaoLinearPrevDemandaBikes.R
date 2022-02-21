# Projeto Preditivo: Prevendo a demanda de aluguel de bicicletas.


# Definição do problema de negócio :

# Modelo de regressão para previsão da demanda de aluguel de bicletas.
# Conjunto de dados: Bike Rental UCI - Dados reais da empresa Capital Bikeshare
# da cidade de Washington DC, EUA

# Estrutura dos dados:
# 17.379 observações e 17 variáveis nos anos de 2011 e 2012
# Fonte: https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset

# Objetivo :
# Prever a variável cnt (count) que representa a quantidade de bicicletas aluga-
# das dentro de uma hora específica cujo o range é de 1 a 977.

# Definindo o diretório.

setwd(choose.dir())
getwd()

# Código para permutação de duas ferramentas utilizadas: RStudio e Azure Machine
# Learning

#
Azure <- FALSE

# Execução de acordo com a var Azure

if(Azure){
  source("src/Tools.R")
  dados <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(dados)
}else{
  source("src/Tools.R")
  dados <- read.csv('bikes.csv',sep = ',',header = T, stringsAsFactors = F)
  
  # Seleção de colunas que serão usadas
  
  cols <- c('dteday','mnth','hr','holiday','workingday','weathersit','temp',
            'hum','windspeed','cnt')
  
  # Criando o subset dos dados
  dados[,cols]
  
  # Transformar as datas
  dados$dteday <- char.toPOSIXct(dados)
  
  # Correção dos dados NA
  dados <- na.omit(dados)
  
  # Normalização das var. preditoras
  colspred <- c('temp','hum','windspeed')
  dados[,colspred] <- scale(dados[,colspred])
}

# Análise exploratória dos dados.

head(dados)
View(dados)
str(dados)
summary(dados)

barplot(table(dados$season))

# Criando uma nova variável com junção de duas outras variáveis

dados$isWorking <- ifelse(dados$workingday & !dados$holiday,1,0)
View(dados)

# Adicionar coluna com a quantidade de meses para ajudar o modelo
dados <- month.count(dados)

# Criando o fator para mapeio dos dias da semana, começando por segunda-feira

dados$dweek <- as.factor(weekdays(dados$dteday))
dados$dweek <- as.numeric(ordered(dados$dweek, 
                                  levels = c('segunda-feira',
                                             'terça-feira',
                                             'quarta-feira',
                                             'quinta-feira',
                                             'sexta-feira',
                                             'sábado',
                                             'domingo')))


# Adicionando uma var para diferenciar as horas dos dias da semana das horas do
# fim de semana

dados$worktime <- ifelse(dados$isWorking, dados$hr, dados$hr + 24)

# Transformação da valores hora na madrugada quando a demanda por bicletas é nula

dados$xformHr <- ifelse(dados$hr > 4, dados$hr - 5, dados$hr + 19)

# Horas considerando as horas da madrugada

dados$xformWorkHr <- ifelse(dados$isWorking, dados$xformHr, dados$xformHr + 24)

# verificando dados NA (Missing)

any(is.na(dados))

if (Azure) {maml.mapOutputPort('dados')
  
}
