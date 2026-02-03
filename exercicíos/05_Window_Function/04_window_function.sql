-- Saldo de pontos acumulado de cada usuário

SELECT DISTINCT idCliente,
    substr(DtCriacao,1,10) AS dtDia,
    qtdePontos,
    sum(qtdePontos) OVER (PARTITION BY idCliente ORDER BY substr(DtCriacao,1,10)) AS saldo_acumulado

FROM transacoes

ORDER BY idCliente, dtDia
