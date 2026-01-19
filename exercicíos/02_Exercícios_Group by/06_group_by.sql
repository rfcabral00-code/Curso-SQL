-- qual dia da semana tem mais pedidos em 2025?

SELECT 
      strftime('%w', substr(DtCriacao, 1, 10)) as diaSemana,
      count(DISTINCT IdTransacao) as qtdeTransacao,
      count(IdTransacao) as qtdeTransacao2

FROM transacoes

WHERE substr(DtCriacao,1,4) = '2025'

GROUP BY 1