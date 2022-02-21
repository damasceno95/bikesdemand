

# Gráficos de desidade (Densit plots)

# Definido labels

labelz <- c('Demanda vs Temperatura',
            'Demanda vs Humidade',
            'Demanda vs Velocidade Vento',
            'Demanda vs Hora')

# Defindo variáveis

defvar <- c('temp','hum','windspeed','hr')

# Função para criar os gráficos

cr.plot <- function(X, labelz) {
  ggplot(dados, aes_string(x = X, y = 'cnt')) +
    geom_point(aes_string(colour = 'cnt'), alpha = 0.1) +
    scale_colour_gradient(low = 'green', high = 'blue') +
    geom_smooth(method = 'loess') +
    ggtitle(labelz) +
    theme(text = element_text(size = 20))
}


Map(cr.plot,defvar,labelz)