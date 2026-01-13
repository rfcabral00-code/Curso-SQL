-- Listar todas as transações adicionando uma coluna nova sinalizando
-- "alto", "médio" e "baixo" para o valor dos pontos
-- [<10;<500;>=500]

SELECT *,

        CASE
            WHEN QtdePontos < 10 THEN 'baixo'
            WHEN QtdePontos < 500 THEN 'médio'
            ELSE 'alto'
        END AS Nível

FROM transacoes