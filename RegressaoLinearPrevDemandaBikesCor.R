


# Verificando Correlações

# Váriavel de controle Azure/R

Azure <- FALSE

if(Azure) {
  source("src/Tools.R")
  dados <- maml.mapinputPort(1)
  dados$dteday <- set.asPOSIXct(dados)
}else {
  dados <- dados
}

# Definição as colunas para análise de correlação

cols <- c('mnth','hr','holiday','workingday','weathersit','temp',
          'hum','windspeed','cnt','isWorking',
          'dweek','worktime','xformHr','monthCount')

# Metódos de Correlação

# Pearson - coeficiente para medição do grau de relacionamento entre duas
# variáveis com relação linear.

# Spearman - teste não-paramétrico para medição grau de relação entre 2 var.

# kendall - teste não-paramétrico para medir a  força de dependênciae entre 2 var.

# Vetor com métodos de correlação

metodos <- c('pearson','spearman')

# Aplicando os métodos com a função cor()
corrl <- lapply(metodos, function(method)
  (cor(dados[,cols], method = method)))
  
head(corrl)

# Verificação através do plot.

require(lattice)
plot.cor <- function(x,labs){
  diag(x) <- 0.0
  plot(levelplot(x,
                 main = paste('Plot de Correlação do método',labs),
                 scales = list(x = list(rot = 90), cex = 1.0)))
}

Map(plot.cor,corrl,metodos)

if (Azure) {maml.mapOutputPort('dados')
  
}