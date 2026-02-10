# Curso de SQL — README Geral (Até DDL/DML + Projeto)

## 📌 Visão Geral

Este repositório documenta minha evolução prática no curso de SQL, cobrindo desde fundamentos de consulta (DQL) até manipulação e definição de dados (DDL e DML), com foco em **análise de dados**, **boas práticas**, **clareza de lógica** e **aplicação real de negócio**.

O objetivo não é apenas aprender comandos SQL isolados, mas **pensar em SQL como ferramenta de análise**, construção de métricas e preparação de dados para BI, Analytics e Data Science.

---

## 🧱 Fundamentos de SQL (DQL)

### SELECT e filtros

* Seleção de colunas específicas
* Uso de `WHERE` com filtros por data, valores e condições
* Comparações temporais utilizando strings e funções de data

```sql
SELECT *
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01';
```

---

## 🔢 Funções de Agregação

### COUNT

* `count(*)`: conta todas as linhas
* `count(1)`: equivalente ao count(*)
* `count(coluna)`: ignora valores nulos

```sql
SELECT
    count(*),
    count(DISTINCT IdTransacao),
    count(DISTINCT idCliente)
FROM transacoes;
```

### SUM, AVG, MIN, MAX

* Uso de agregações para análise de volume, saldo e extremos
* Uso de `CASE WHEN` para segmentar métricas

```sql
SELECT
    sum(qtdePontos) AS totalPontos,
    sum(CASE WHEN qtdePontos > 0 THEN qtdePontos END) AS pontosPositivos,
    sum(CASE WHEN qtdePontos < 0 THEN qtdePontos END) AS pontosNegativos
FROM transacoes;
```

---

## 🧩 DISTINCT

* Remove duplicidades com base na combinação de colunas do SELECT
* Muito usado para contagem de entidades únicas (clientes, transações)

```sql
SELECT count(DISTINCT idCliente)
FROM clientes;
```

---

## 📊 GROUP BY e HAVING

### GROUP BY

* Agrega dados por entidade (cliente, produto, data)

```sql
SELECT
    idCliente,
    sum(qtdePontos) AS totalPontos,
    count(IdTransacao) AS qtdeTransacoes
FROM transacoes
GROUP BY idCliente;
```

### HAVING

* Filtra resultados após agregação

```sql
HAVING sum(qtdePontos) >= 4000;
```

---

## 🔗 JOINs

* Uso de `LEFT JOIN` para enriquecer tabelas fato com dimensões

```sql
SELECT
    t1.*, 
    t2.DescCategoriaProduto
FROM transacao_produto t1
LEFT JOIN produtos t2
ON t1.IdProduto = t2.IdProduto;
```

---

## 🔄 Subqueries

* Utilizadas para filtros dependentes de outras consultas

```sql
SELECT *
FROM transacao_produto
WHERE IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto = 'Resgatar Ponei'
);
```

---

## 🧠 CTE — Common Table Expressions

* Melhoram legibilidade, reutilização e organização do SQL
* Muito úteis para análises em múltiplas etapas

```sql
WITH clientes_dia1 AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE date(DtCriacao) = '2025-08-25'
),
clientes_dia5 AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE date(DtCriacao) = '2025-08-29'
)
SELECT count(*)
FROM clientes_dia1 c1
JOIN clientes_dia5 c5
ON c1.idCliente = c5.idCliente;
```

---

## 📈 Window Functions

* Permitem cálculos analíticos sem colapsar linhas
* Exemplo clássico: acumulados ao longo do tempo

```sql
sum(qtdeTransacao) OVER (ORDER BY dtDia) AS qtTransacaoAcumulada
```

---

## 🏗️ DDL — Data Definition Language

### CREATE TABLE

* Criação explícita de tabelas
* Definição de tipos e chaves

```sql
CREATE TABLE relatorio_diario (
    dtDia DATE PRIMARY KEY,
    qtdeTransacao INTEGER,
    qtTransacaoAcum INTEGER
);
```

---

## ✏️ DML — Data Manipulation Language

### INSERT

* Inserção de dados transformados via CTE

### DELETE

* Limpeza total ou baseada em regra de negócio

```sql
DELETE FROM relatorio_diario
WHERE date(dtDia) >= '2025-01-01';
```

### UPDATE

* Atualizações condicionais
* Atenção à comparação correta de datas

```sql
UPDATE relatorio_diario
SET qtdeTransacao = 1000
WHERE date(dtDia) >= '2025-08-25';
```

---

## 📁 Tabelas Derivadas

### Exemplo: clientes_d28

Tabela criada para análise de atividade recente dos clientes (últimos 28 dias)

```sql
CREATE TABLE clientes_d28 (
    idCliente VARCHAR(250) PRIMARY KEY,
    qtdeTransacao INTEGER
);
```

---

## 🚀 Projeto Final — Perfil Comportamental de Usuários

### 🎯 Objetivo

Construir uma tabela analítica com **features comportamentais dos usuários**, permitindo análises de engajamento, perfil e uso da plataforma.

### 🧩 Features previstas

* Quantidade de transações:

  * Vida
  * D7, D14, D28, D56

* Dias desde a última transação

* Tempo de permanência na base

* Produto mais utilizado (Vida e janelas temporais)

* Saldo atual de pontos

* Pontos positivos acumulados

* Pontos negativos acumulados

* Dia da semana mais ativo (D28)

* Período do dia mais ativo (D28)

* Comparação de engajamento D28 vs Vida


## 📌 Conclusão

Até este ponto do curso, o foco deixou de ser apenas aprender comandos SQL e passou a ser:

> **estruturar dados, gerar métricas e resolver problemas reais de negócio com SQL**.

Este repositório servirá como base para evolução contínua em Analytics, BI e projetos de dados.
