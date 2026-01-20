-- Quantos clientes tem e-mail cadastrado?

-- SELECT 
--       count(flEmail) 
-- FROM clientes 

-- fiz do jeito erro, o certo é assim

-- SELECT count(*)

-- FROM clientes

-- WHERE flEmail = 1;

-- ou assim

SELECT sum(flEmail)

FROM clientes;
