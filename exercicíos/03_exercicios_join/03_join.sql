-- 3. Do inicio ao fim do nsso curso (2025-08-25 a 2025-08-29), quantos clientes assinaram a lista de presença ?

SELECT count(DISTINCT idCliente) as qtClientes

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

WHERE t1.DtCriacao >= '2025-08-25'
AND t1.DtCriacao < '2025-08-30'
AND t2.IdProduto = 11