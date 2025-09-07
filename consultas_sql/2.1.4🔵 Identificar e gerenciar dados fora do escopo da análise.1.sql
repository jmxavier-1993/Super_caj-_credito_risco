SELECT 
CORR(default_flag, last_month_salary) AS correlacao,

CORR(default_flag, number_dependents) AS correlacao,

CORR (default_flag,age) AS correlacao

FROM
  `my-project-laboratoria.dadoslaboratorioproject03.default_user_info_loans_details`
