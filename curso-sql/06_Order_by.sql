--SELECT *
--FROM CLIENTES
--ORDER BY QtdePontos DESC
--LIMIT 10;

-- Selecione todos as colunas da planilha clientes onde temos os 10
-- clientes com mais pontos

SELECT *

FROM clientes

WHERE flTwitch = 1

ORDER BY DtCriacao ASC, qtdePontos DESC