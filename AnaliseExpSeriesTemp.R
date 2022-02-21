

# Análise Exploratória - Séries Temporais

# Váriavel de controle Azure/R

Azure <- FALSE

if(Azure) {
  source("src/Tools.R")
  dados <- maml.mapinputPort(1)
  dados$dteday <- set.asPOSIXct(dados)
}else {
  dados <- dados
}

# Definindo horas específicas para análise

horas <- c(7,9,12,15,18,20,22)

# Criando uma função para mapear a demanda em cada horário de acordo com
# a variável horas e plotá-la nos gráficos

h.plot <- function(horas){
  ggplot(dados[dados$worktime == horas,], aes(x = dteday, y = cnt)) +
    geom_line() +
    ylab('Número de bicletas') +
    labs(tittle = paste('Demanda de bicicletas as', as.character(horas),':00', sep = '')) +
    theme(text = element_text(size = 20))
  
}

require(ggplot2)
lapply(horas, h.plot)

if (Azure) {maml.mapOutputPort('dados')
  
}