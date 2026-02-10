DELETE FROM relatorio_diario;

WITH tb_diario AS (

    SELECT substr(DtCriacao,1,10) as dtDia,
            count(DISTINCT IdTransacao) as qtdeTransacao

    FROM transacoes

    GROUP BY dtDia

),
tb_acum AS (
        SELECT *,
                sum(qtdeTransacao) OVER (ORDER BY dtDia) AS qtTransacaoAcum
        
        FROM tb_diario

        ORDER BY dtDia
)

INSERT INTO relatorio_diario

SELECT *
FROM tb_acum;

SELECT * FROM relatorio_diario;