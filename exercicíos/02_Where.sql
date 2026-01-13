-- Lista de pedidos realizados no fim de semana;

SELECT IdTransacao,
       DtCriacao,
       strftime('%W', datetime(substr(DtCriacao,1,19))) as diasemana

FROM transacoes

WHERE diasemana IN ('6','0')