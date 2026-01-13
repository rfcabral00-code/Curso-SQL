-- INTERVALOS

-- DE 0 A 500   ->ponei
-- DE 501 A 1000  ->ponei premium
-- DE 1001 A 5000 ->mago aprendiz
-- DE 5001 A 10000 -> mago mestre
-- +DE 10001 -> mago supremo

-- um case cria uma coluna (apenas uma)
-- ou seja, cada case aqui dentro desse cod criou uma coluna

SELECT idCliente,
       qtdePontos,
       CASE
            WHEN QtdePontos <= 500 THEN 'Ponei'
            WHEN QtdePontos <= 1000 THEN 'Ponei Premium'
            WHEN QtdePontos <= 5000 THEN 'Mago Aprendiz'
            WHEN QtdePontos <= 10000 THEN 'Mago Mestre'
            ELSE 'Mago supremo'           
       END AS NomeGrupo,

       CASE
            WHEN QtdePontos <= 1000 THEN 1
            ELSE 0
        END AS flponei,

        CASE WHEN qtdePontos > 1000 THEN 1
             ELSE 0
        END AS flMago

FROM clientes

WHERE flMago = 1

ORDER BY QtdePontos DESC