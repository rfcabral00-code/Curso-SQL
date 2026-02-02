-- Como foi a curva de Churn do Curso de SQL? (refazer)

-- definindo as transações 

WITH tb_listaPresença AS (
    SELECT IdTransacao
    FROM transacao_produto
    WHERE IdProduto = '11'
),

tb_listaPrimeiroDia AS (
    SELECT DISTINCT idCliente
    FROM transacoes AS t1
    LEFT JOIN tb_listaPresença AS t2
    ON t1.IdTransacao = t2.IdTransacao
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
    
),

tb_listaProxDias AS (
    SELECT DISTINCT t1.idCliente
    FROM transacoes AS T1
    INNER JOIN tb_listaPresença AS t2
        ON t1.IdTransacao = t2.IdTransacao
    WHERE substr(DtCriacao,1,10) >= '2025-08-26'
        AND substr(DtCriacao,1,10) <= '2025-08-29'
),

tb_churn AS (
    SELECT DISTINCT T1.IdCliente
    FROM tb_listaPrimeiroDia AS t1
    LEFT JOIN tb_listaProxDias AS t2
        ON t1.idCliente = t2.idCliente
    WHERE t2.idCliente IS NULL
)

SELECT *
FROM tb_churn






