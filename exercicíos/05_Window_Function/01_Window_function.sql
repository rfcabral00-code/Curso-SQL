--Quantidade de transações Acumuladas ao longo do tempo?
--quando que a gente atingiu 100k transações (assim que vem a pergunta no trabalho) 
--para isso, foi adicionado na query o cte de tb_acum e a query abaixo dela
-- que pegamos o dia que aconteceu de atingir mais de 100k de transacoes acumuladas

WITH tb_sumario_dia AS (

    SELECT substr(DtCriacao,1,10) as dtDia,
            count(DISTINCT IdTransacao) as qtdeTransacao

    FROM transacoes

    GROUP BY dtDia

),
tb_acum AS (
        SELECT *,
                sum(qtdeTransacao) OVER (ORDER BY dtDia) AS qtTransacaoAcum
        
        FROM tb_sumario_dia

        ORDER BY dtDia
)

SELECT *
FROM tb_acum
WHERE qtTransacaoAcum > 100000
ORDER BY qtTransacaoAcum
LIMIT 1