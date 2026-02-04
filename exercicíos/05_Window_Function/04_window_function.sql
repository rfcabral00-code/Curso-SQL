-- Saldo de pontos acumulado de cada usuário

WITH tb_cliente_dia AS (

    SELECT 
        idCliente,
        substr(DtCriacao,1,10) AS dtDia,
        -- qtdePontos,
        sum(qtdePontos) AS totalPontos,
        sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS pontosPositivos

    FROM transacoes

    GROUP BY idCliente, dtDia
)

SELECT*,
    sum(totalPontos) OVER (PARTITION BY idCliente ORDER BY dtDia) AS saldoPontos,
    sum(pontosPositivos) OVER (PARTITION BY idCliente order BY dtDia) AS totalPontospos

FROM tb_cliente_dia
