-- 12. Dentros os clientes de janeiro/2025
-- quants assistiram o curso ?

WITH tb_clientes_janeiro AS (
    SELECT DISTINCT idcliente
    FROM TRANSACOES
    WHERE dtCriacao >= '2025-01-01'
    AND dtcriacao < '2025-02-01'
),

tb_clientes_curso AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'
)

SELECT count(t1.idCliente) AS clienteJaneiro,
        count(t2.idCliente) AS clienteCurso
FROM tb_clientes_janeiro AS t1
LEFT JOIN tb_clientes_curso AS t2
ON t1.idCliente = t2.idCliente

