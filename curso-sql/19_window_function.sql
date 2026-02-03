WITH tb_cliente_dia AS (

SELECT idCliente,
        substr(DtCriacao,1,10) AS dtDia,
        count(DISTINCT IdTransacao) AS qtdeTransacao

FROM transacoes

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

GROUP BY idCliente, dtDia

),


tb_lag AS (

    SELECT *,
        sum(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) as acumulado_dia,
        lag(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) as lagTransacao

    FROM tb_cliente_dia
)

SELECT *,

        1.* qtdeTransacao / lagTransacao

FROM tb_lag