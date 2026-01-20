--o distinct funciona para deixar apenas os clientes



SELECT count(*),
       count(DISTINCT IdTransacao),
       count(DISTINCT idCliente)

FROM TRANSACOES

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

ORDER BY DtCriacao desc 