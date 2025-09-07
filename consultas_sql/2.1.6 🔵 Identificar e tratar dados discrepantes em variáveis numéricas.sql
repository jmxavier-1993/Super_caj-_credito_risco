CREATE OR REPLACE TABLE
  `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados` AS
WITH
  base_outliers_tratados AS (
  SELECT
    user_id,
    default_flag,
    age,
    faixa_etaria,
    last_month_salary,
    number_dependents,
    total_emprestimos,
    qtd_imoveis_emprestimos,
    qtd_outros_emprestimos,
    more_90_days_overdue,
    using_lines_not_secured_personal_assets,
    number_times_delayed_payment_loan_30_59_days,
    number_times_delayed_payment_loan_60_89_days,
    debt_ratio,
    -- Cálculo dos quartis para o tratamento de outliers 
    PERCENTILE_CONT(age, 0.25) OVER() AS age_q1,
    PERCENTILE_CONT(age, 0.75) OVER() AS age_q3,
    PERCENTILE_CONT(last_month_salary, 0.25) OVER() AS salary_q1,
    PERCENTILE_CONT(last_month_salary, 0.75) OVER() AS salary_q3,
    PERCENTILE_CONT(number_dependents, 0.25) OVER() AS dependents_q1,
    PERCENTILE_CONT(number_dependents, 0.75) OVER() AS dependents_q3,
    PERCENTILE_CONT(using_lines_not_secured_personal_assets, 0.25) OVER() AS using_lines_q1,
    PERCENTILE_CONT(using_lines_not_secured_personal_assets, 0.75) OVER() AS using_lines_q3,
    PERCENTILE_CONT(debt_ratio, 0.25) OVER() AS debt_ratio_q1,
    PERCENTILE_CONT(debt_ratio, 0.75) OVER() AS debt_ratio_q3
  FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_consolida_final` ),
  base_com_valores_tratados AS (
  SELECT
    user_id,
    default_flag,
    age,
    faixa_etaria,
    last_month_salary,
    number_dependents,
    total_emprestimos,
    qtd_imoveis_emprestimos,
    qtd_outros_emprestimos,
    more_90_days_overdue,
    using_lines_not_secured_personal_assets,
    number_times_delayed_payment_loan_30_59_days,
    number_times_delayed_payment_loan_60_89_days,
    debt_ratio,
    -- Tratar outliers de idade
    CASE
      WHEN age < (age_q1 - 1.5 * (age_q3 - age_q1)) THEN (age_q1 - 1.5 * (age_q3 - age_q1))
      WHEN age > (age_q3 + 1.5 * (age_q3 - age_q1)) THEN (age_q3 + 1.5 * (age_q3 - age_q1))
      ELSE age
  END
    AS age_tratado,
    -- Tratar outliers de salário
    CASE
      WHEN last_month_salary < (salary_q1 - 1.5 * (salary_q3 - salary_q1)) THEN (salary_q1 - 1.5 * (salary_q3 - salary_q1))
      WHEN last_month_salary > (salary_q3 + 1.5 * (salary_q3 - salary_q1)) THEN (salary_q3 + 1.5 * (salary_q3 - salary_q1))
      ELSE last_month_salary
  END
    AS salary_tratado,
    -- Tratar outliers de number_dependents
    CASE
      WHEN number_dependents < (dependents_q1 - 1.5 * (dependents_q3 - dependents_q1)) THEN (dependents_q1 - 1.5 * (dependents_q3 - dependents_q1))
      WHEN number_dependents > (dependents_q3 + 1.5 * (dependents_q3 - dependents_q1)) THEN (dependents_q3 + 1.5 * (dependents_q3 - dependents_q1))
      ELSE number_dependents
  END
    AS dependents_tratado,
    -- Tratar outliers de using_lines_not_secured_personal_assets
    CASE
      WHEN using_lines_not_secured_personal_assets < (using_lines_q1 - 1.5 * (using_lines_q3 - using_lines_q1)) THEN (using_lines_q1 - 1.5 * (using_lines_q3 - using_lines_q1))
      WHEN using_lines_not_secured_personal_assets > (using_lines_q3 + 1.5 * (using_lines_q3 - using_lines_q1)) THEN (using_lines_q3 + 1.5 * (using_lines_q3 - using_lines_q1))
      ELSE using_lines_not_secured_personal_assets
  END
    AS using_lines_tratado,
     -- Tratar outliers de debt_ratio
    CASE
      WHEN debt_ratio < (debt_ratio_q1 - 1.5 * (debt_ratio_q3 - debt_ratio_q1)) THEN (debt_ratio_q1 - 1.5 * (debt_ratio_q3 - debt_ratio_q1))
      WHEN debt_ratio > (debt_ratio_q3 + 1.5 * (debt_ratio_q3 - debt_ratio_q1)) THEN (debt_ratio_q3 + 1.5 * (debt_ratio_q3 - debt_ratio_q1))
      ELSE debt_ratio
  END
    AS debt_ratio_tratado
  FROM
    base_outliers_tratados )
SELECT
  user_id,
  default_flag,
  faixa_etaria,
  total_emprestimos,
  qtd_imoveis_emprestimos,
  qtd_outros_emprestimos,
  more_90_days_overdue,
  number_times_delayed_payment_loan_30_59_days,
  number_times_delayed_payment_loan_60_89_days,
  age_tratado,
  salary_tratado,
  debt_ratio_tratado,
  using_lines_tratado,
  dependents_tratado,
  
  -- Calcular os NTILEs com base nas variáveis numéricas
  NTILE(4) OVER (ORDER BY age_tratado) AS age_quartil,
  NTILE(4) OVER (ORDER BY salary_tratado) AS salary_quartil,
  NTILE(4) OVER (ORDER BY dependents_tratado) AS dependent_quartil,
  NTILE(4) OVER (ORDER BY more_90_days_overdue) AS more_90_days_quartil,
  NTILE(4) OVER (ORDER BY using_lines_tratado) AS using_lines_quartil,
  NTILE(4) OVER (ORDER BY number_times_delayed_payment_loan_30_59_days) AS delayed_payment_30_59_quartil,
  NTILE(4) OVER (ORDER BY number_times_delayed_payment_loan_60_89_days) AS delayed_payment_60_89_quartil,
  NTILE(4) OVER (ORDER BY debt_ratio_tratado) AS debt_ratio_quartil,
  NTILE(4) OVER (ORDER BY total_emprestimos) AS qtd_emprestimos_total_quartil,
  NTILE(4) OVER (ORDER BY qtd_imoveis_emprestimos) AS qtd_imoveis_emprestimos_quartil,
  NTILE(4) OVER (ORDER BY qtd_outros_emprestimos) AS qtd_outros_emprestimos_quartil
FROM
  base_com_valores_tratados;