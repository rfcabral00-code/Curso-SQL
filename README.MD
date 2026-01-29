# 📊 Curso de SQL

Este repositório reúne os materiais, exemplos práticos e exercícios desenvolvidos ao longo do curso de **SQL**, partindo dos conceitos fundamentais até consultas analíticas mais avançadas, com foco em **análise de dados, métricas e lógica de negócio**.

---

## 🎯 Objetivo do curso

Desenvolver a capacidade de **consultar, organizar, cruzar e analisar dados** em bancos relacionais utilizando SQL, preparando o aluno para desafios reais em:

* Análise de dados
* Business Intelligence
* Engenharia / Analytics
* Projetos baseados em dados

---

## 🗓️ Dia 1 – Fundamentos de SQL

Introdução aos conceitos básicos e à estrutura das consultas SQL.

### Conteúdos abordados

* Introdução ao SQL e bancos de dados relacionais
* Preparação do ambiente (VS Code)
* Estrutura básica de um script SQL
* Primeiro comando: *Olá, mundo em SQL*
* Comandos fundamentais:

  * `SELECT`
  * `FROM`
  * `WHERE`
* Introdução às cláusulas SQL
* Criação de colunas calculadas
* Exercícios de fixação

---

## 🗓️ Dia 2 – ORDER BY e CASE WHEN

Aula focada em **organização de resultados** e **lógica condicional**.

### 🔹 ORDER BY

Utilizado para ordenar os resultados de uma consulta.

```sql
SELECT *
FROM clientes
WHERE flTwitch = 1
ORDER BY DtCriacao ASC, QtdePontos DESC;
```

---

### 🔹 CASE WHEN

Permite criar regras condicionais e novas colunas derivadas.

```sql
SELECT idCliente,
       QtdePontos,
       CASE
            WHEN QtdePontos <= 500 THEN 'Ponei'
            WHEN QtdePontos <= 1000 THEN 'Ponei Premium'
            WHEN QtdePontos <= 5000 THEN 'Mago Aprendiz'
            WHEN QtdePontos <= 10000 THEN 'Mago Mestre'
            ELSE 'Mago Supremo'
       END AS NomeGrupo
FROM clientes;
```

### Exercício – CASE WHEN

```sql
SELECT *,
       CASE
            WHEN QtdePontos < 10 THEN 'baixo'
            WHEN QtdePontos < 500 THEN 'médio'
            ELSE 'alto'
       END AS Nivel
FROM transacoes;
```

---

## 🗓️ Dia 3 – Agregações, DISTINCT e COUNT

Introdução às **funções de agregação** e deduplicação de dados.

### 🔹 COUNT e COUNT DISTINCT

```sql
SELECT
    COUNT(*) AS totalRegistros,
    COUNT(DISTINCT IdTransacao) AS transacoesDistintas,
    COUNT(DISTINCT idCliente) AS clientesDistintos
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao <  '2025-08-01';
```

---

### 🔹 SUM com CASE WHEN

```sql
SELECT
    SUM(qtdePontos) AS qtdePontosTotal,
    SUM(CASE WHEN qtdePontos > 0 THEN qtdePontos END) AS qtdePontosPositivos,
    SUM(CASE WHEN qtdePontos < 0 THEN qtdePontos END) AS qtdePontosNegativos,
    COUNT(CASE WHEN qtdePontos < 0 THEN 1 END) AS qtdeTransacoesNegativas
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao <  '2025-08-01';
```

---

### 🔹 AVG, MIN, MAX e ROUND

```sql
SELECT
    ROUND(AVG(qtdePontos), 2) AS mediaCarteira,
    ROUND(1.0 * SUM(qtdePontos) / COUNT(idCliente), 2) AS mediaCarteiraRoots,
    MIN(qtdePontos) AS minCarteira,
    MAX(qtdePontos) AS maxCarteira,
    SUM(flTwitch) AS totalTwitch,
    SUM(flEmail) AS totalEmail
FROM clientes;
```

---

## 🗓️ Dias 4, 5 e 6 – GROUP BY, HAVING, JOIN, Subqueries e CTEs

Parte central do curso, focada em **SQL analítico e cruzamento de dados**.

---

## 🔹 GROUP BY

Agrupa dados para aplicação de métricas por entidade.

```sql
SELECT idCliente,
       SUM(qtdePontos) AS totalPontos,
       COUNT(IdTransacao) AS totalTransacoes
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao <  '2025-08-01'
GROUP BY idCliente
ORDER BY totalPontos DESC
LIMIT 10;
```

---

## 🔹 HAVING

Filtra resultados **após a agregação**.

```sql
HAVING SUM(qtdePontos) >= 4000
```

---

## 🔹 JOIN

Cruzamento de dados entre tabelas relacionadas.

```sql
SELECT t1.*, t2.DescCategoriaProduto
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto;
```

---

## 🔹 Subqueries

Utilização de consultas dentro de outras consultas.

```sql
SELECT COUNT(DISTINCT idCliente)
FROM transacoes AS t1
WHERE t1.idCliente IN (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
)
AND substr(t1.DtCriacao,1,10) = '2025-08-29';
```

---

## 🔹 CTEs (Common Table Expressions)

Forma organizada e legível de estruturar consultas complexas.

```sql
WITH tb_cliente_primeiro_dia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),
tb_cliente_ultimo_dia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-29'
),
tb_join AS (
    SELECT t1.idCliente AS primCliente,
           t2.idCliente AS ultCliente
    FROM tb_cliente_primeiro_dia AS t1
    LEFT JOIN tb_cliente_ultimo_dia AS t2
    ON t1.idCliente = t2.idCliente
)
SELECT
    COUNT(primCliente) AS clientesInicio,
    COUNT(ultCliente) AS clientesFim,
    1.0 * COUNT(ultCliente) / COUNT(primCliente) AS taxaRetencao
FROM tb_join;
```

---

## 🚀 Próximos temas

* Window Functions (`ROW_NUMBER`, `RANK`, `OVER`)
* Enumeração e rankings
* Análise temporal
* DDL e DML
* Projeto final prático

---

## ✅ Status

Conteúdo até SQL **nível intermediário**, com base sólida para avançar em análises complexas e projetos reais.
