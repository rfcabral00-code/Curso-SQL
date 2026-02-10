DELETE FROM relatorio_diario
WHERE strftime('%W', substr(dtDia,1,10)) = '0';

SELECT * FROM relatorio_diario;