SELECT
CORR(qtd_imoveis_emprestimos, qtd_outros_emprestimos) AS correlacao, 
CORR (debt_ratio, default_flag) as teste ,
CORR(more_90_days_overdue,total_emprestimos) AS teste,
CORR (more_90_days_overdue,age) AS teste,
CORR(more_90_days_overdue,number_dependents) AS teste,
CORR(more_90_days_overdue,last_month_salary) AS teste
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.tb_consolida_final`
