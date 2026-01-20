-- 4. Clientes mais antigos, tem mais frequência de transação ? 
-- Entendo que preciso fazer o numero de presença pelo número de aulas
-- Primeiro, descobrir o número de transações
-- depois descobrir os clintes mais antigos
-- depois ver se eles tem mais lista assinada que os mais novos

-- SELECT          idCliente,
--                 count(*),
--                 min(DtCriacao) AS  pirmeira_presenca

-- FROM transacoes AS t1

-- LEFT JOIN transacao_produto AS t2
-- ON t1.IdTransacao = t2.IdTransacao

-- WHERE IdProduto = 11

-- GROUP BY IdCliente

-- ORDER BY min(DtCriacao)

SELECT t1.idCliente,
        julianday('now') - julianday(substr(t1.DtCriacao,1,19)) AS idadeBase,
        count(t2.IdTransacao) as qtTransacoes

FROM clientes as t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente, idadeBase