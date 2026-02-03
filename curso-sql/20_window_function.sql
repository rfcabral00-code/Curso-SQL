WITH cliente_dia AS (

SELECT 
        DISTINCT
        idcliente,
        substr(DtCriacao,1,10) AS dtDia

FROM transacoes

WHERE substr(DtCriacao,1,4) = '2025'

ORDER BY idCliente, dtDia

),

tb_lag AS (

    SELECT *,
            lag(dtDia) OVER (PARTITION BY idCliente ORDER by dtDia) AS lagDia

    FROM cliente_dia
),

tb_diff_dt AS (

    SELECT *,
            julianday(dtDia) - julianday(lagDia) AS dtDiaDiff

    FROM tb_lag
),

avg_cliente AS (

    SELECT idCliente, avg(dtDiaDiff) AS avgDia
        

    FROM tb_diff_dt
    GROUP BY idCliente
)

SELECT avg(avgDia) FROM avg_cliente