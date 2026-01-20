SELECT round(avg(qtdePontos),2) AS mediaCarteira, -- pq colocar o 2 dentro do round?
       round(1. * sum(qtdePontos) / count(idCliente),2) AS mediaCarteiraRoots, -- multiplicar 1 * zero transforma em float
       min(qtdePontos) AS minCarteira, -- esses aqui são exemplos de funções de agreagação
       max(qtdePontos) AS maxCarteira,
       sum(flTwitch),
       sum(flEmail)

FROM clientes

