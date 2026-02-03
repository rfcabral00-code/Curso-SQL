-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH tb_sumario_dia AS (
    
    SELECT
        substr(DtCriacao,1,10) AS dtDia,
        count(DISTINCT idCliente) AS qtUsuarios


    FROM clientes

    GROUP BY dtDia
)

SELECT 
        dtDia,
        qtUsuarios,
    sum(qtUsuarios) OVER (ORDER BY dtDia) AS qtUsuario_Acumulado

FROM tb_sumario_dia

ORDER BY dtDia