📊 Curso de SQL

Este repositório contém os materiais, exemplos práticos e exercícios desenvolvidos ao longo do curso de SQL, partindo dos conceitos básicos até tópicos avançados, com foco em análise e manipulação de dados em bancos relacionais.

🗓️ Dia 1 – Fundamentos de SQL

No primeiro dia de curso, foram apresentados os conceitos iniciais e a base necessária para escrita de consultas SQL.

📌 Conteúdos abordados

Introdução ao SQL e bancos de dados relacionais

Preparação do ambiente de desenvolvimento:

Configuração do VS Code

Estrutura básica de um script SQL

Primeiro comando: “Olá, mundo” em SQL

Comandos fundamentais:

SELECT

FROM

WHERE

Introdução às cláusulas SQL

Criação de novas colunas (colunas calculadas)

Exercícios de fixação para prática dos conceitos iniciais

🗓️ Dia 2 – Ordenação, Condicionais e Agregações

No segundo dia, o foco foi organizar resultados, criar lógicas condicionais e realizar contagens, habilidades essenciais para análise de dados.

🔹 ORDER BY

O comando ORDER BY é utilizado para ordenar os resultados de uma consulta.

Exemplo – Ordenação com filtro e múltiplos critérios
SELECT *
FROM clientes
WHERE flTwitch = 1
ORDER BY DtCriacao ASC, QtdePontos DESC;


Lógica aplicada:

Filtra clientes com flTwitch = 1

Ordena pela data de criação (crescente)

Em seguida, pela quantidade de pontos (decrescente)

🔹 CASE WHEN

O CASE WHEN permite criar regras condicionais dentro das consultas SQL.

📌 Observações importantes:

Cada CASE cria uma nova coluna

Muito utilizado para classificação, segmentação e criação de flags

Classificação de clientes por faixa de pontos
SELECT idCliente,
       QtdePontos,
       CASE
            WHEN QtdePontos <= 500 THEN 'Ponei'
            WHEN QtdePontos <= 1000 THEN 'Ponei Premium'
            WHEN QtdePontos <= 5000 THEN 'Mago Aprendiz'
            WHEN QtdePontos <= 10000 THEN 'Mago Mestre'
            ELSE 'Mago Supremo'
       END AS NomeGrupo,

       CASE
            WHEN QtdePontos <= 1000 THEN 1
            ELSE 0
       END AS flPonei,

       CASE
            WHEN QtdePontos > 1000 THEN 1
            ELSE 0
       END AS flMago
FROM clientes
WHERE flMago = 1
ORDER BY QtdePontos DESC;

🧠 Exercício – CASE WHEN

Classificação das transações por nível de pontos:

SELECT *,
       CASE
            WHEN QtdePontos < 10 THEN 'baixo'
            WHEN QtdePontos < 500 THEN 'médio'
            ELSE 'alto'
       END AS Nivel
FROM transacoes;

🔹 COUNT

O COUNT é uma função de agregação utilizada para contar registros em uma tabela ou resultado de consulta.

Exemplo visto em aula
SELECT 
    COUNT(*),
    COUNT(1),
    COUNT(idCliente)
FROM clientes;

Diferença entre os tipos de COUNT

COUNT(*)

Conta todas as linhas

Inclui registros com valores NULL

Forma mais comum e recomendada

COUNT(1)

Também conta todas as linhas

Equivalente ao COUNT(*) em bancos modernos

COUNT(idCliente)

Conta apenas registros onde idCliente não é NULL

Útil quando a coluna pode conter valores nulos

📌 Se idCliente for chave primária, todos os COUNT retornam o mesmo valor.

🗓️ Dia 3 – Agregações, DISTINCT e COUNT DISTINCT

Nesta aula foram apresentados conceitos fundamentais para resumir, deduplicar e analisar dados, utilizando funções de agregação e o operador DISTINCT.

🔹 DISTINCT e COUNT DISTINCT

O DISTINCT é utilizado para eliminar duplicidades, considerando a combinação das colunas selecionadas.

Contagem de registros distintos em um período
SELECT 
    COUNT(*) AS totalRegistros,
    COUNT(DISTINCT IdTransacao) AS transacoesDistintas,
    COUNT(DISTINCT idCliente) AS clientesDistintos
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao <  '2025-08-01';


O que está sendo analisado:

Total de registros no período

Total de transações únicas

Total de clientes únicos

📌 Observação importante:
DISTINCT atua sobre a coluna informada ou sobre a combinação de colunas da query, eliminando duplicidades com base nisso.

DISTINCT aplicado diretamente na contagem de clientes
SELECT 
    COUNT(DISTINCT idCliente) AS clientesDistintos
FROM clientes;


👉 Retorna o número de clientes únicos existentes na tabela.

🔹 Agregações com SUM e CASE WHEN

As funções de agregação permitem “espremer” uma tabela, resumindo grandes volumes de dados em métricas relevantes.

Exemplo – Análise de pontos no período
SELECT
    SUM(qtdePontos) AS qtdePontosTotal,

    SUM(CASE
            WHEN qtdePontos > 0 THEN qtdePontos
        END) AS qtdePontosPositivos,

    SUM(CASE
            WHEN qtdePontos < 0 THEN qtdePontos
        END) AS qtdePontosNegativos,

    COUNT(CASE
              WHEN qtdePontos < 0 THEN 1
          END) AS qtdeTransacoesNegativas
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao <  '2025-08-01';


O que foi feito:

Soma total de pontos

Soma apenas de pontos positivos

Soma apenas de pontos negativos

Contagem de transações negativas

📌 Uso combinado de CASE WHEN + agregações, padrão muito comum em análises reais.

🔹 AVG, MIN, MAX e ROUND

Além de somar e contar, também foram utilizadas funções para análise estatística básica.

SELECT
    ROUND(AVG(qtdePontos), 2) AS mediaCarteira,
    ROUND(1.0 * SUM(qtdePontos) / COUNT(idCliente), 2) AS mediaCarteiraRoots,
    MIN(qtdePontos) AS minCarteira,
    MAX(qtdePontos) AS maxCarteira,
    SUM(flTwitch) AS totalTwitch,
    SUM(flEmail) AS totalEmail
FROM clientes;

Pontos importantes da aula

ROUND(valor, 2) → define quantidade de casas decimais

Multiplicar por 1.0 força o cálculo para float, evitando divisão inteira

MIN e MAX retornam extremos do conjunto

SUM(flTwitch) funciona como contagem quando a coluna é 0/1

🧠 Conexão com próximos temas

Aula 4 - Group By e Having

Esses conceitos são a base direta para:

Métricas por cliente, produto ou período

Dashboards e relatórios analíticos

Projetos de dados reais

Conteúdo das próximas aulas:

GROUP BY → HAVING → JOIN → CTE → WINDOW FUNCTIONS