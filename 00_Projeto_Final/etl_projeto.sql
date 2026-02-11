-- Vamos construir uma tabela com o perfil comportamental dos nossos usuários.
-- Features que serão construidas -> Criar caracteriscas a respeito do usuário
-- Quantidade de transações históricas (vida, D7, D14, D28, D56); ok
-- Dias desde a última transação; ok
-- Idade na base;ok 
-- Produto mais usado (vida, D7, D14, D28, D56);
-- Saldo de pontos atual; ok
-- Pontos acumulados positivos (vida, D7, D14, D28, D56); ok
-- Pontos acumulados negativos (vida, D7, D14, D28, D56); ok
-- Dias da semana mais ativos (D28)
-- Período do dia mais ativo (D28)
-- Engajamento em D28 versus Vida


WITH tb_transacoes AS (

        SELECT idTransacao,
                idCliente,
                qtdePontos,
                datetime(substr(dtCriacao,1,19)) AS dtCriacao,
                julianday('now') - julianday(substr(dtCriacao,1,10)) AS diffDate
        
        FROM transacoes
),

tb_cliente AS (

        SELECT IdCliente,
        datetime(substr(dtCriacao,1,19)) AS dtCriacao,
        julianday('now') - julianday(substr(dtCriacao,1,10)) AS idadeBase

        FROM clientes
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

tb_transacao_Produto AS (

        SELECT T1.*,
                t3.DescNomeProduto,
                t3.DescCategoriaProduto

        FROM tb_transacoes AS t1

        LEFT JOIN transacao_produto AS T2
        ON t1.IdTransacao = t2.IdTransacao

        LEFT JOIN produtos AS t3
        ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (

        SELECT idCliente,
                DescNomeProduto,
                count(*) AS qtdeVida,
                count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtde56,
                count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtde28,
                count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtde14,
                count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtde7

        FROM tb_transacao_Produto

        GROUP BY idCliente, DescNomeProduto
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

tb_join AS  (

        SELECT t1.*,
                t2.idadeBase,
                t3.DescNomeProduto AS produtoVida,
                t4.DescNomeProduto AS produto56,
                t5.DescNomeProduto AS produto28,
                t6.DescNomeProduto AS produto14,
                t7.DescNomeProduto AS produto7

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

)

SELECT *

FROM tb_join
ORDER BY idCliente