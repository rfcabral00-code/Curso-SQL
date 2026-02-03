-- Qual o dia da semana mais ativo de cada usuário?

WITH qt_transacoes_acumuladas AS (

    SELECT  idCliente,
            strftime('%w', datetime(substr(DtCriacao,1,10))) as diasemana,
            count(*) AS qtTransacoes
            

    FROM transacoes

    GROUP BY idCliente, diaSemana

)


SELECT 
   idCliente,
   diaSemana,
   qtTransacoes,
    row_number() OVER (PARTITION BY idCliente ORDER BY qtTransacoes DESC) AS rn
    
FROM qt_transacoes_acumuladas