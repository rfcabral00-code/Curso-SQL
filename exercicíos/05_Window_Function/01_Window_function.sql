--Quantidade de transações Acumuladas ao longo do tempo?

WITH tb_sumario_dia AS (

    SELECT substr(DtCriacao,1,10) as dtDia,
            count(DISTINCT IdTransacao) as qtdeTransacao

    FROM transacoes

    GROUP BY dtDia

)

SELECT *,
        sum(qtdeTransacao) OVER (ORDER BY dtDia) AS qtTransacaoAcum
    
    

FROM tb_sumario_dia

ORDER BY dtDia

