#Verificando a correlação entre todas as variáveis 
SELECT
  CORR(
    SAFE_CAST(more_90_days_overdue AS FLOAT64),
    SAFE_CAST(number_times_delayed_payment_loan_60_89_days AS FLOAT64)
  ) AS corr_60_89,
  
  CORR(
    SAFE_CAST(more_90_days_overdue AS FLOAT64),
    SAFE_CAST(number_times_delayed_payment_loan_30_59_days AS FLOAT64)
  ) AS corr_30_59,

  CORR(number_times_delayed_payment_loan_30_59_days,number_times_delayed_payment_loan_60_89_days) AS correlacao,

  CORR(
  SAFE_CAST(using_lines_not_secured_personal_assets AS FLOAT64),
  SAFE_CAST(debt_ratio AS FLOAT64)) AS correlacao

FROM `my-project-laboratoria.dadoslaboratorioproject03.loans_details_teste`