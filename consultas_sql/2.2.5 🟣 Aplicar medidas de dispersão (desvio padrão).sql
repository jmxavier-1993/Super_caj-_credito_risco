#verificando desvio padrão
SELECT 
STDDEV_SAMP(number_times_delayed_payment_loan_30_59_days) AS more_59 ,
       STDDEV_SAMP(more_90_days_overdue) AS more_90,
       STDDEV_SAMP(number_times_delayed_payment_loan_60_89_days) AS dias_89,
       STDDEV_SAMP(age_tratado) AS age,
       STDDEV_SAMP(debt_ratio_tratado) AS debt_ratio_tratado,
       STDDEV_SAMP(dependents_tratado) AS dependents_tratado,
       STDDEV_SAMP(salary_tratado) AS salary_tratado,
       STDDEV_SAMP(using_lines_tratado) AS using_lines_tratado
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
