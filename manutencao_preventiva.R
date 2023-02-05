dados <- read.csv("desafio_manutencao_preditiva_treino.csv")
dados <- data.frame(dados[-9], failure_type = factor(dados$failure_type))

dados
table(dados$failure_type)

library(OneR)
library(rpart)
library(rpart.plot)
library(caTools)

arvore1 <- rpart(failure_type ~ type + air_temperature_k + process_temperature_K + rotational_speed_rpm + torque_Nm + tool_wear_min, data = dados)

rpart.plot(arvore1, type = 5, extra = 0)


set. Seed(12)
random <- sample(1:nrow(dados), 0.7 * nrow(dados))
treino <- dados[random, ]
teste <- dados[-random, ]

arvore1 <- rpart(failure_type ~ type + air_temperature_k + process_temperature_K + rotational_speed_rpm + torque_Nm + tool_wear_min, data = treino)
previsao <- predict(arvore1, teste, type = "class")
eval_model(previsao, teste)
