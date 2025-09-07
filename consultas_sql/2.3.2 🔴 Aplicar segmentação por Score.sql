CREATE OR REPLACE TABLE
  `my-project-laboratoria.dadoslaboratorioproject03.tb_score_dummy` AS
WITH
  -- Sua tabela intermediária para criar as variáveis dummy
  dados_com_risco_dummy AS (
  SELECT
    orig.*,
    -- Variáveis dummy existentes
    CASE WHEN rr_age.risco_relativo > 1.2 THEN 1 ELSE 0 END AS dummy_risco_age,
    CASE WHEN rr_salary.risco_relativo > 1.5 THEN 1 ELSE 0 END AS dummy_risco_salary,
    CASE WHEN rr_dependent.risco_relativo > 1.2 THEN 1 ELSE 0 END AS dummy_risco_dependent,
    CASE WHEN rr_90.risco_relativo > 2.5 THEN 1 ELSE 0 END AS dummy_risco_more_90,
    CASE WHEN rr_lines.risco_relativo > 2.5 THEN 1 ELSE 0 END AS dummy_risco_using_lines,
    CASE WHEN rr_30_59.risco_relativo > 2.5 THEN 1 ELSE 0 END AS dummy_risco_delayed_30_59,
    CASE WHEN rr_60_89.risco_relativo > 2.5 THEN 1 ELSE 0 END AS dummy_risco_delayed_60_89,
    CASE WHEN rr_debt.risco_relativo > 1.1 THEN 1 ELSE 0 END AS dummy_risco_debt_ratio,
    CASE WHEN rr_loans.risco_relativo > 1.2 THEN 1 ELSE 0 END AS dummy_risco_qtd_emprestimos,
    -- Novas variáveis dummy
    CASE WHEN rr_imoveis.risco_relativo > 1.5 THEN 1 ELSE 0 END AS dummy_risco_imoveis,
    CASE WHEN rr_outros.risco_relativo > 1.5 THEN 1 ELSE 0 END AS dummy_risco_outros
  FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados` AS orig
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_age
    ON CAST(orig.age_quartil AS STRING) = rr_age.categoria AND rr_age.tipo_variavel = 'age_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_salary
    ON CAST(orig.salary_quartil AS STRING) = rr_salary.categoria AND rr_salary.tipo_variavel = 'salary_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_dependent
    ON CAST(orig.dependent_quartil AS STRING) = rr_dependent.categoria AND rr_dependent.tipo_variavel = 'dependent_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_90
    ON CAST(orig.more_90_days_quartil AS STRING) = rr_90.categoria AND rr_90.tipo_variavel = 'more_90_days_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_lines
    ON CAST(orig.using_lines_quartil AS STRING) = rr_lines.categoria AND rr_lines.tipo_variavel = 'using_lines_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_30_59
    ON CAST(orig.delayed_payment_30_59_quartil AS STRING) = rr_30_59.categoria AND rr_30_59.tipo_variavel = 'delayed_payment_30_59_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_60_89
    ON CAST(orig.delayed_payment_60_89_quartil AS STRING) = rr_60_89.categoria AND rr_60_89.tipo_variavel = 'delayed_payment_60_89_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_debt
    ON CAST(orig.debt_ratio_quartil AS STRING) = rr_debt.categoria AND rr_debt.tipo_variavel = 'debt_ratio_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_loans
    ON CAST(orig.qtd_emprestimos_total_quartil AS STRING) = rr_loans.categoria AND rr_loans.tipo_variavel = 'qtd_emprestimos_total_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_imoveis
    ON CAST(orig.qtd_imoveis_emprestimos_quartil AS STRING) = rr_imoveis.categoria AND rr_imoveis.tipo_variavel = 'qtd_imoveis_emprestimos_quartil'
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.tb_risco_relativo_completo` AS rr_outros
    ON CAST(orig.qtd_outros_emprestimos_quartil AS STRING) = rr_outros.categoria AND rr_outros.tipo_variavel = 'qtd_outros_emprestimos_quartil'
  )
-- Calcular o score com os novos pesos e a nova classificação
SELECT
  *,
  -- Score com pesos simplificados
  CAST(
    (
      dummy_risco_age * 1 + dummy_risco_salary * 1 + dummy_risco_dependent * 1 +
      dummy_risco_more_90 * 3 + dummy_risco_using_lines * 3 + dummy_risco_delayed_30_59 * 2 +
      dummy_risco_delayed_60_89 * 2 + dummy_risco_debt_ratio * 1 + dummy_risco_qtd_emprestimos * 1 +
      dummy_risco_imoveis * 3 + dummy_risco_outros * 3
    ) AS INT64
  ) AS score_risco_total,
  -- Nova classificação com 4 faixas de risco
  CASE
    WHEN (
      dummy_risco_age * 1 + dummy_risco_salary * 1 + dummy_risco_dependent * 1 +
      dummy_risco_more_90 * 3 + dummy_risco_using_lines * 3 + dummy_risco_delayed_30_59 * 2 +
      dummy_risco_delayed_60_89 * 2 + dummy_risco_debt_ratio * 1 + dummy_risco_qtd_emprestimos * 1 +
      dummy_risco_imoveis * 3 + dummy_risco_outros * 3
    ) >= 6 THEN 'Risco Extremamente Alto'
    WHEN (
      dummy_risco_age * 1 + dummy_risco_salary * 1 + dummy_risco_dependent * 1 +
      dummy_risco_more_90 * 3 + dummy_risco_using_lines * 3 + dummy_risco_delayed_30_59 * 2 +
      dummy_risco_delayed_60_89 * 2 + dummy_risco_debt_ratio * 1 + dummy_risco_qtd_emprestimos * 1 +
      dummy_risco_imoveis * 3 + dummy_risco_outros * 3
    ) >= 3 THEN 'Risco Alto'
    WHEN (
      dummy_risco_age * 1 + dummy_risco_salary * 1 + dummy_risco_dependent * 1 +
      dummy_risco_more_90 * 3 + dummy_risco_using_lines * 3 + dummy_risco_delayed_30_59 * 2 +
      dummy_risco_delayed_60_89 * 2 + dummy_risco_debt_ratio * 1 + dummy_risco_qtd_emprestimos * 1 +
      dummy_risco_imoveis * 3 + dummy_risco_outros * 3
    ) >= 1 THEN 'Risco Moderado'
    ELSE 'Risco Baixo'
  END AS classificacao_risco,
  -- Flag binária para a matriz de confusão com novo limite
  CASE
    WHEN (
      dummy_risco_age * 1 + dummy_risco_salary * 1 + dummy_risco_dependent * 1 +
      dummy_risco_more_90 * 3 + dummy_risco_using_lines * 3 + dummy_risco_delayed_30_59 * 2 +
      dummy_risco_delayed_60_89 * 2 + dummy_risco_debt_ratio * 1 + dummy_risco_qtd_emprestimos * 1 +
      dummy_risco_imoveis * 3 + dummy_risco_outros * 3
    ) >= 2 THEN 1
    ELSE 0
  END AS flag_alto_risco_binaria
FROM
  dados_com_risco_dummy;