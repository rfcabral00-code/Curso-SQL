WITH tb_cliente AS (

        SELECT IdCliente,
        datetime(substr(dtCriacao,1,19)) AS dtCriacao,
        julianday('now') - julianday(substr(dtCriacao,1,10)) AS idadeBase

        FROM clientes
),

tb_cliente_produto_rn AS (

        SELECT *,
                row_number () OVER (PARTITION BY idCliente ORDER BY qtdeVida DESC) AS rnVida,
                row_number () OVER (PARTITION BY idCliente ORDER BY qtde56 DESC) AS rn56,
                row_number () OVER (PARTITION BY idCliente ORDER BY qtde28 DESC) AS rn28,
                row_number () OVER (PARTITION BY idCliente ORDER BY qtde14 DESC) AS rn14,
                row_number () OVER (PARTITION BY idCliente ORDER BY qtde7 DESC)  AS rn7


        FROM tb_cliente_produto
),


tb_sumario_transacoes AS (

        SELECT idCliente,
                count(IdTransacao) AS qtdeTransacoesVida,
                count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtdeTransacao56,
                count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtdeTransacao28,
                count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtdeTransacao14,
                count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtdeTransacao7,
                min(diffDate) AS diasUltimaInteracao,
                
                sum(qtdePontos) AS saldoPontos,

                sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS qtdePontosPosVida,
                sum(CASE WHEN qtdepontos > 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS qtdePontosPos56,
                sum(CASE WHEN qtdepontos > 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS qtdePontosPos28,
                sum(CASE WHEN qtdepontos > 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS qtdePontosPos14,
                sum(CASE WHEN qtdepontos > 0 AND diffDate <=  7 THEN qtdePontos ELSE 0 END) AS qtdePontosPos7,

                sum(CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS qtdePontosNegVida,
                sum(CASE WHEN qtdepontos < 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS qtdePontosNeg56,
                sum(CASE WHEN qtdepontos < 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS qtdePontosNeg28,
                sum(CASE WHEN qtdepontos < 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS qtdePontosNeg14,
                sum(CASE WHEN qtdepontos < 0 AND diffDate <=  7 THEN qtdePontos ELSE 0 END) AS qtdePontosNeg7

        FROM tb_transacoes
        GROUP BY idCliente
),
tb_cliente_dia_rn AS (

        SELECT *, 
                row_number() OVER(PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rnDia 

        FROM tb_cliente_dia
),

tb_join AS (

        SELECT t1.*,
                t2.idadeBase,
                t3.DescNomeProduto AS produtoVida,
                t4.DescNomeProduto AS produto56,
                t5.DescNomeProduto AS produto28,
                t6.DescNomeProduto AS produto14,
                t7.DescNomeProduto AS produto7,
                COALESCE(t8.dtDia, -1) AS dtDia

        FROM tb_sumario_transacoes AS t1

        LEFT JOIN tb_cliente AS t2
        ON t1.idCliente = t2.idCliente

        LEFT JOIN tb_cliente_produto_rn as t3
        ON t1.idCliente = t3.idCliente
        AND t3.rnvida = 1

        LEFT JOIN tb_cliente_produto_rn as t4
        ON t1.idCliente = t3.idCliente
        AND t4.rn56 = 1

        LEFT JOIN tb_cliente_produto_rn as t5
        ON t1.idCliente = t3.idCliente
        AND t5.rn28 = 1

        LEFT JOIN tb_cliente_produto_rn as t6
        ON t1.idCliente = t3.idCliente
        AND t6.rn14 = 1

        LEFT JOIN tb_cliente_produto_rn as t7
        ON t1.idCliente = t3.idCliente
        AND t7.rn7 = 1

        LEFT JOIN tb_cliente_dia_rn as t8
        ON t1.idCliente = t8.idCliente
        AND t8.rnDia = 1

)

SELECT * FROM tb_join