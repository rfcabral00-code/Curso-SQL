-- CTE: COMMON TABLE EXPRESSION

-- SELECT count(DISTINCT idCliente) 
-- FROM transacoes AS t1
-- WHERE t1.idCliente IN (
--     SELECT DISTINCT idCliente
--     FROM transacoes
--     WHERE substr(DtCriacao,1,10) = '2025-08-25'
-- )
-- AND substr(t1.DtCriacao,1,10) = '2025-08-29'

WITH tb_cliente_primeiro_dia AS (

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_cliente_ultimo_dia AS (

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-29'
),

tb_join AS (

    SELECT t1.idCliente AS primCliente, --nome de coluna diferente
            t2.idCliente AS ultcliente

    FROM tb_cliente_primeiro_dia AS t1
    LEFT JOIN tb_cliente_ultimo_dia AS t2
    ON t1.idCliente = t2.idCliente
)

SELECT count(primcliente),
        count(ultcliente),
        1. * count(ultcliente) / count(primcliente)

FROM tb_join


