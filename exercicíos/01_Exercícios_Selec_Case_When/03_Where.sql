-- Lista de clientes com zero pontos

select IdCliente,
        QtdePontos
        
 from clientes

WHERE QtdePontos = 0