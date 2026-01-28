SELECT * 

FROM(
    SELECT *
    FROM transacoes 
    WHERE dtcriacao >= '2025-01-01'
)
WHERE DtCriacao < '2025-07-01'