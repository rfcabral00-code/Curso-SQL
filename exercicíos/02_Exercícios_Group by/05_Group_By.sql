-- qual o valor médio de pontos positivos por dia?

SELECT sum(qtdePontos) AS total_pontos,

       count(DISTINCT substr(DtCriacao,1,10)) AS qt_deDiasUnicos,

       sum(qtdePontos) / count(DISTINCT substr(DtCriacao,1,10)) AS avgPorDia

FROM transacoes

WHERE qtdePontos > 0