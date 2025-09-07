CREATE OR REPLACE table `my-project-laboratoria.dadoslaboratorioproject03.default_user_info_loans_details` AS
WITH base_data AS (
  SELECT
    d.user_id,
    d.default_flag,
    ui.age,
    ui.last_month_salary,
    ui.number_dependents,
    ld.more_90_days_overdue, 
    ld.using_lines_not_secured_personal_assets,
    ld.number_times_delayed_payment_loan_30_59_days,
    ld.number_times_delayed_payment_loan_60_89_days, 
    ld.debt_ratio,
    
        
    -- Faixa etária
    CASE
      WHEN ui.age BETWEEN 21 AND 29 THEN '21-29'
      WHEN ui.age BETWEEN 30 AND 39 THEN '30-39'
      WHEN ui.age BETWEEN 40 AND 49 THEN '40-49'
      WHEN ui.age BETWEEN 50 AND 59 THEN '50-59'
      WHEN ui.age BETWEEN 60 AND 69 THEN '60-69'
      WHEN ui.age >= 70 THEN '70+'
      WHEN ui.age IS NULL THEN 'Idade não informada'
      ELSE 'Fora da faixa padrão'
    END AS faixa_etaria
  FROM
    `my-project-laboratoria.dadoslaboratorioproject03.default` AS d
  LEFT JOIN 
    `my-project-laboratoria.dadoslaboratorioproject03.user_info_corrigida` AS ui
    ON d.user_id = ui.user_id
  LEFT JOIN
    `my-project-laboratoria.dadoslaboratorioproject03.loans_details_teste` AS ld
    ON d.user_id = ld.user_id
)
SELECT * FROM base_data;