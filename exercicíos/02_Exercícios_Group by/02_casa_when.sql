-- qual cliente juntou mais pontos positivos em 2025-05

SELECT idCliente,

       sum(CASE
            WHEN qtdePontos > 0 THEN qtdePontos
        END) qtdepontosmaxima


FROM clientes

WHERE DtCriacao >= '2025-05-01'
AND DtCriacao < '2025-06-01'