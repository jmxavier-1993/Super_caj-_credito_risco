SELECT
  COUNT(*) AS total_linhas,
  COUNTIF(user_id IS NULL) AS user_id_nulos,
  COUNTIF(age IS NULL) AS age_nulos,
  COUNTIF(sex IS NULL) AS sex_nulos,
  COUNTIF(SAFE_CAST(last_month_salary AS FLOAT64) IS NULL) AS last_month_salary_nulos,
  COUNTIF(number_dependents IS NULL) AS number_dependents_nulos
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.user_info`

#tratamento dos nulos na tabela user_info e criando a view já corrigida
CREATE OR REPLACE VIEW `my-project-laboratoria.dadoslaboratorioproject03.user_info_corrigida` as
SELECT 
user_id,
age,
IFNULL(last_month_salary, (SELECT APPROX_QUANTILES(last_month_salary, 2)[OFFSET(1)] FROM `my-project-laboratoria.dadoslaboratorioproject03.user_info`)) AS last_month_salary,
IFNULL(number_dependents, (SELECT APPROX_QUANTILES(number_dependents, 2)[OFFSET(1)] FROM `my-project-laboratoria.dadoslaboratorioproject03.user_info`)) AS number_dependents  
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.user_info`

  # Verificando se há valores nulos em todas as variáveis na tabela loans_detail:
SELECT 
  COUNT(*) AS total_linhas,
  COUNTIF(user_id IS NULL) AS user_id_nulos,
  COUNTIF(more_90_days_overdue IS NULL) AS more_90_days_overdue_nulos,
  COUNTIF(using_lines_not_secured_personal_assets IS NULL) AS using_lines_not_secured_personal_assets_nulos,
  COUNTIF(number_times_delayed_payment_loan_30_59_days IS NULL) AS number_times_delayed_payment_loan_30_59_days_nulos,
  COUNTIF(debt_ratio IS NULL) AS debt_ratio_nulos,
  COUNTIF(number_times_delayed_payment_loan_60_89_days IS NULL) AS number_times_delayed_payment_loan_60_89_days_nulos
FROM 
  `my-project-laboratoria.dadoslaboratorioproject03.loans_detail`;

 # Verificando se há valores nulos em todas as variáveis na tabela loans_outstanding
SELECT 
  COUNT(*) AS total_linhas,
  COUNTIF(loan_id IS NULL) AS loan_id_nulos,
  COUNTIF(user_id IS NULL) AS user_id_nulos,
  COUNTIF(loan_type IS NULL) AS loan_type_nulos
FROM `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding`;








