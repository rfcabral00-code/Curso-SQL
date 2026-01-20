-- qual mês tivemos mais listas de presença assinada, 

SELECT 
        substr(t1.DtCriacao, 1, 7) as anoMes,
        count(DISTINCT t1.IdTransacao) as qtdeTransacao

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON T2.IdProduto = T3.IdProduto

WHERE DescNomeProduto = 'Lista de presença'

GROUP BY substr(t1.DtCriacao, 1, 7)

ORDER BY qtdeTransacao DESC