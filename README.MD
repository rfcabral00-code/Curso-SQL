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

📚 Próximos conteúdos do curso

DISTINCT

Estatística aplicada

GROUP BY

HAVING

Cruzamento de dados

JOINS

Subqueries

CTEs (Common Table Expressions)

Enumeração de linhas

Window Functions

DDL e DML

Projeto final prático