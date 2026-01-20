-- 1. Quais clientes mais perderam pontos por Lover?

-- ID PRODUTOS SÃO OS 1 E O 13

SELECT  idCliente,
         SUM(QtdePontos) as Total_pontos
              
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

WHERE IdProduto IN (1,13)
AND qtdePontos < 0

GROUP BY idCliente

ORDER BY sum(qtdePontos) ASC

LIMIT 5
