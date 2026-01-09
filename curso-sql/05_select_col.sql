SELECT IdCliente,
        --qtdePontos,
        --qtdePontos + 10 AS QtdePontosplus10,
        --qtdePontos * 2 AS QtedPontosDouble
        DtCriacao,
        substr(DtCriacao, 1, 19) as dtSubString,
        datetime(substr(DtCriacao, 1, 19)) as dtCriacaiNova,
        strftime('%w', datetime(substr(DtCriacao, 1, 19))) as diaSemana

        -- essa função "substr", pega do primeiro elemento da string até o décimo,
        -- no caso pq ela finaliza em "10" mas poderia ser até mais
        -- semelhante a função de "esquerda" do exel
        -- quando for ler a linha 8, primeiro, vc recorta o dado do 1 ao 19, depois aplica o datetime
        -- depois fala com o strftime para pesquisar o dia com o '%w",
        -- e finaliza criando a coluna com o "as dia semana"

FROM clientes
