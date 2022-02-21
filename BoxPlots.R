
# BoxPlot para análise exploratória

# conversão da variável dayweek para fator ordenado em ordem de tempo

dados$dweek <- fact.conv(dados$dweek)

# Criando os títulos dos gráficos

titulos <- c('Demanda por hora','Demanda por estação','Demanda por dia útil',
             'Demanda por dia da semana')

# Variáveis preditoras para estudo de demanda

varpred <- c('hr','weathersit','isWorking','dweek')

# Função para plotagem dos boxplots

plbox <- function(X, titulos){
  ggplot(dados, aes_string(x = X, y = 'cnt', group = X)) +
    geom_boxplot() +
    ggtitle(titulos) +
    theme(text = element_text(size = 18))
}

Map(plbox,varpred,titulos)

