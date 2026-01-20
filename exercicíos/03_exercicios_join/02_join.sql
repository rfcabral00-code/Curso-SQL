--2. Quais clientes assinaram a lista de presença no dia 2025-08-25?

SELECT DISTINCT t1.idCliente
        
FROM transacoes as t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN clientes AS t3
ON t1.idCliente = t3.idCliente

WHERE substr(t1.DtCriacao, 1, 10) = '2025-08-25'
AND IdProduto = 11