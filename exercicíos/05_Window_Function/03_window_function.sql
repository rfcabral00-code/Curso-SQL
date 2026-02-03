-- Qual o dia da semana mais ativo de cada usuário?

WITH tb_cliente_semana AS (

    SELECT  idCliente,
            strftime('%w', datetime(substr(DtCriacao,1,10))) as diasemana,
            count(DISTINCT IdTransacao) AS qtTransacoes
            

    FROM transacoes

    GROUP BY idCliente, diaSemana

),

tb_rn AS (
    SELECT 
    *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtTransacoes DESC) AS rn
        
    FROM tb_cliente_semana
)

SELECT *
FROM tb_rn
WHERE RN = 1