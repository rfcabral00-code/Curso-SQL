-- SELECT * FROM  relatorio_diario;

-- UPDATE relatorio_diario
-- SET qtdeTransacao = 1000
-- WHERE dtDia >= '2025-08-25'
-- ;

-- SELECT * FROM relatorio_diario;

SELECT dtDia
FROM relatorio_diario
WHERE substr(dtDia,1,10) >= '2025-08-25';

UPDATE relatorio_diario
SET qtdeTransacao = 1000
WHERE date(dtDia) >= '2025-08-25';

SELECT * FROM relatorio_diario;