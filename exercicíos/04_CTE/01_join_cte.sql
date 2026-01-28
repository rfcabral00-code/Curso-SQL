-- 11. Quem inicou o curso no primeiro dia, em média assistiu quantas aulas?


-- tb_primeiro_dia quem particiou da primeira aula
-- tb_dias_curso quem participou do curso inteiro
-- tb_cliente_dias contando quantas vezes quem participou do primeiro dia voltou
-- depois calculo da média 

with tb_primeiro_dia AS (

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_dias_curso AS (

    SELECT DISTINCT 
        idCliente, 
        substr(DtCriacao,1,10) AS presenteDia
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    ORDER BY idCliente, presenteDia
),

tb_cliente_dias AS (

SELECT  t1.idCliente,
        count(DISTINCT t2.presenteDia) AS qtdedias
    FROM tb_primeiro_dia AS t1
    LEFT JOIN tb_dias_curso AS T2
    ON t1.idCliente = t2.idCliente

    GROUP BY t1.idCliente

)

SELECT avg(qtdedias),
        max(qtdedias),
        min(qtdedias)
FROM tb_cliente_dias