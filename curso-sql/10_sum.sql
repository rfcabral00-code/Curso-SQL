-- existe diversas formas de expremer uma planilha

SELECT
       sum(qtdePontos),
       
       sum(CASE
           WHEN qtdePontos > 0 THEN qtdePontos
       END) AS qtdePontosPositivos,

       sum(CASE
            WHEN qtdePontos < 0 THEN qtdePontos
        END) AS qtdePontosNegativos,

        count( CASE
               WHEN qtdePontos < 0 THEN qtdePontos
               END) AS qtdetransacoesNegativas

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

ORDER BY QtdePontos
