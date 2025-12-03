# 🏦 Análise de Risco de Crédito - Super Caja Bank

Este projeto visa automatizar e otimizar o processo de análise de crédito do banco **Super Caja**, substituindo a análise manual por um modelo de **Credit Scoring** baseado em dados. O objetivo é classificar os clientes por risco de inadimplência (default), aumentando a eficiência operacional e mitigando prejuízos financeiros.

## 📋 Índice
- [Contexto do Problema](#-contexto-do-problema)
- [Objetivos](#-objetivos)
- [Ferramentas e Tecnologias](#-ferramentas-e-tecnologias)
- [Estrutura dos Dados](#-estrutura-dos-dados)
- [Metodologia e Pipeline](#-metodologia-e-pipeline)
    - [1. Tratamento de Dados (SQL)](#1-tratamento-de-dados-sql)
    - [2. Engenharia de Atributos e Risco Relativo](#2-engenharia-de-atributos-e-risco-relativo)
    - [3. Criação do Score e Segmentação](#3-criação-do-score-e-segmentação)
- [Validação do Modelo (Python/ML)](#-validação-do-modelo-pythonml)
- [Resultados e Dashboard](#-resultados-e-dashboard)
- [Como Executar](#-como-executar)

---

## 🚩 Contexto do Problema
Com a diminuição das taxas de juros, houve um aumento significativo na demanda por empréstimos. A equipe de análise de crédito do banco **Super Caja** está sobrecarregada com processos manuais, o que gera ineficiência e demora. Além disso, há uma preocupação crescente com a taxa de inadimplência.

A solução proposta é um sistema automatizado que utiliza dados históricos para calcular a probabilidade de um cliente não pagar o empréstimo (`default`).

---

## 🎯 Objetivos
* Processar e unificar dados dispersos de clientes e histórico de pagamentos.
* Calcular o **Risco Relativo** de cada perfil de cliente.
* Desenvolver um **Score de Crédito** ponderado.
* Segmentar clientes em faixas de risco (Do "Muito Baixo" ao "Extremamente Alto").
* Validar a eficácia das regras de negócio utilizando algoritmos de Machine Learning (Random Forest).

---

## 🛠 Ferramentas e Tecnologias
* **Google BigQuery (SQL):** Armazenamento, limpeza, tratamento de outliers, engenharia de features e cálculo do score.
* **Google Colab (Python):** Análise exploratória avançada, validação do modelo com Machine Learning (Scikit-learn, Imblearn).
* **Google Looker Studio:** Visualização de dados e construção do Dashboard interativo.
* **Bibliotecas Python:** `pandas`, `numpy`, `matplotlib`, `seaborn`, `sklearn`, `imblearn` (SMOTE).

---

## 🗂 Estrutura dos Dados
O dataset contém **36.000 registros** divididos em 4 tabelas principais:

1.  **`user_info`**: Dados demográficos (Idade, Sexo, Salário, Dependentes).
2.  **`loans_outstanding`**: Tipo de empréstimo (Imobiliário ou Outros).
3.  **`loans_detail`**: Histórico de comportamento (Atrasos de 30-59 dias, 60-89 dias, >90 dias, Taxa de Endividamento).
4.  **`default`**: Variável alvo (`default_flag`), indicando se o cliente é inadimplente (1) ou não (0).

---

## ⚙️ Metodologia e Pipeline

### 1. Tratamento de Dados (SQL)
Realizado inteiramente no BigQuery:
* **Correção de Tipagem:** Conversão de colunas (ex: `last_month_salary` de float para int).
* **Tratamento de Nulos:**
    * `last_month_salary`: Imputação pela mediana baseada em idade e sexo.
    * `number_dependents`: Imputação pela moda.
    * `loans_outstanding`: Valores nulos assumidos como 0 (sem empréstimo ativo).
* **Padronização:** Correção de inconsistências na coluna `loan_type`.
* **Tratamento de Outliers:** Aplicação do método **IQR (Interquartile Range)** para limitar valores extremos em variáveis como Salário e Taxa de Endividamento.

### 2. Engenharia de Atributos e Risco Relativo
* **Criação de Variáveis:** `total_emprestimos`, `faixa_etaria`.
* **Cálculo de Quartis:** As variáveis numéricas foram divididas em 4 partes (`NTILE(4)`) para análise categórica.
* **Cálculo do Risco Relativo:**
    $$\text{Risco Relativo} = \frac{\text{Taxa de Inadimplência do Grupo}}{\text{Taxa de Inadimplência Geral}}$$
    * *Insight:* Variáveis de atraso (ex: `more_90_days_overdue`) apresentaram Risco Relativo > 3.0 nos piores quartis.

### 3. Criação do Score e Segmentação
Foi criado um sistema de pontuação ponderada baseado no Risco Relativo:
* **Pesos Altos:** Atribuídos a histórico de atrasos e uso excessivo de limite.
* **Pesos Moderados/Baixos:** Atribuídos a idade, salário e número de dependentes.
* **Segmentação Final:**
    * 🔴 Risco Extremamente Alto
    * 🟠 Risco Alto
    * 🟡 Risco Moderado
    * 🟢 Risco Baixo

---

## 🤖 Validação do Modelo (Python/ML)
Para garantir que as regras criadas no SQL eram robustas, os dados tratados foram exportados para o Python e submetidos a um modelo de **Random Forest Classifier**.

* **Técnica de Balanceamento:** SMOTE (devido ao desbalanceamento da classe de inadimplentes ~1.75%).
* **Métricas Finais (Dados de Teste):**
    * **Acurácia:** 98.69%
    * **Precisão:** 67.60%
    * **Recall:** 59.88%
    * **F1-Score:** 63.51%
    * **Matriz de Confusão:** O modelo ajustado conseguiu reduzir significativamente os Falsos Negativos (clientes de risco classificados como bons pagadores), protegendo o capital do banco.

---

## 📊 Resultados e Dashboard
Os resultados foram compilados em um painel no **Looker Studio**, permitindo ao time de RH filtrar por perfil de cliente e visualizar a distribuição de risco.

**Principais Insights:**
1.  **Atrasos são cruciais:** O histórico de atrasos (>90 dias) é o maior preditor de default.
2.  **Jovens e Baixa Renda:** Clientes mais jovens e com menor renda tendem a ter maior risco relativo.
3.  **Endividamento:** O uso excessivo de linhas de crédito sem garantia é um forte sinal de alerta.

🔗 **[Acesse o Dashboard no Looker Studio](https://lookerstudio.google.com/reporting/c2e30e3f-7fba-4406-9fc4-782cf9e99720)**

---

## 🚀 Como Executar

1.  **Banco de Dados:**
    * Carregue os arquivos `.csv` (extraídos do zip) no Google Cloud Storage ou diretamente no BigQuery.
    * Execute as queries contidas na pasta `/sql` na ordem numérica para limpar, tratar e criar as tabelas consolidadas.

2.  **Análise e Validação:**
    * Abra o notebook `Rota03_JulianaXavier.ipynb` no Google Colab.
    * Conecte-se ao seu projeto do BigQuery.
    * Execute as células para gerar as análises estatísticas e rodar o modelo de Machine Learning.

---
*Projeto desenvolvido como parte da Rota 03 - Laboratória.*
