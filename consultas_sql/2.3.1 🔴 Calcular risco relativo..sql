-- Primeiro: Criar tabela com cálculo de risco relativo
CREATE OR REPLACE TABLE
  `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS
WITH
  -- 1. Definir a base de dados principal
  base_data AS (
  SELECT
    user_id,
    default_flag,
    age_quartil,
    salary_quartil,
    dependent_quartil,
    more_90_days_quartil,
    using_lines_quartil,
    delayed_payment_30_59_quartil,
    delayed_payment_60_89_quartil,
    debt_ratio_quartil,
    qtd_emprestimos_total_quartil,
    qtd_imoveis_emprestimos_quartil,
    qtd_outros_emprestimos_quartil
  FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados` ),

  -- 2. Calcular a taxa de inadimplência total da base
  total_default_rate AS (
  SELECT
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_total
  FROM
    base_data ),

  -- 3. Calcular a taxa de inadimplência para cada quartil de cada variável
  quartil_default_rates AS (
  -- age_quartil
  SELECT
    'age_quartil' AS tipo_variavel,
    CAST(age_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    age_quartil
  UNION ALL
  -- salary_quartil
  SELECT
    'salary_quartil' AS tipo_variavel,
    CAST(salary_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    salary_quartil
  UNION ALL
  -- dependent_quartil
  SELECT
    'dependent_quartil' AS tipo_variavel,
    CAST(dependent_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    dependent_quartil
  UNION ALL
  -- more_90_days_quartil
  SELECT
    'more_90_days_quartil' AS tipo_variavel,
    CAST(more_90_days_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    more_90_days_quartil
  UNION ALL
  -- using_lines_quartil
  SELECT
    'using_lines_quartil' AS tipo_variavel,
    CAST(using_lines_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    using_lines_quartil
  UNION ALL
  -- delayed_payment_30_59_quartil
  SELECT
    'delayed_payment_30_59_quartil' AS tipo_variavel,
    CAST(delayed_payment_30_59_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    delayed_payment_30_59_quartil
  UNION ALL
  -- delayed_payment_60_89_quartil
  SELECT
    'delayed_payment_60_89_quartil' AS tipo_variavel,
    CAST(delayed_payment_60_89_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    delayed_payment_60_89_quartil
  UNION ALL
  -- debt_ratio_quartil
  SELECT
    'debt_ratio_quartil' AS tipo_variavel,
    CAST(debt_ratio_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    debt_ratio_quartil
  UNION ALL
  -- qtd_emprestimos_total_quartil
  SELECT
    'qtd_emprestimos_total_quartil' AS tipo_variavel,
    CAST(qtd_emprestimos_total_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    qtd_emprestimos_total_quartil

  UNION ALL
   -- qtd_outros_emprestimos_quartil
  SELECT
    'qtd_outros_emprestimos_quartil' AS tipo_variavel,
    CAST(qtd_outros_emprestimos_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    qtd_outros_emprestimos_quartil

  UNION ALL
   -- qtd_imoveis_emprestimos_quartil
  SELECT
    'qtd_imoveis_emprestimos_quartil' AS tipo_variavel,
    CAST(qtd_imoveis_emprestimos_quartil AS STRING) AS categoria,
    SAFE_DIVIDE(COUNTIF(default_flag = 1), COUNT(*)) AS taxa_inadimplencia_quartil,
    COUNT(*) AS total_clientes,
    COUNTIF(default_flag = 1) AS total_inadimplentes
  FROM
    base_data
  GROUP BY
    qtd_imoveis_emprestimos_quartil    
  )
  
  
-- 4. Unir os resultados e calcular o risco relativo final
SELECT
  t1.tipo_variavel,
  t1.categoria,
  -- A taxa de inadimplência da categoria é o "risco_exposto"
  t1.taxa_inadimplencia_quartil AS risco_exposto,
  -- A taxa de inadimplência total é o "risco_nao_exposto"
  t2.taxa_inadimplencia_total AS risco_nao_exposto,
  SAFE_DIVIDE(t1.taxa_inadimplencia_quartil, t2.taxa_inadimplencia_total) AS risco_relativo,
  t1.total_clientes,
  t1.total_inadimplentes
FROM
  quartil_default_rates AS t1
CROSS JOIN
  total_default_rate AS t2
ORDER BY
  tipo_variavel,
  risco_relativo DESC;
