#Consulta para identificar valores duplicados na tabela loans_outstanding
SELECT 
  loan_id, 
  user_id,
  loan_type,
  COUNT(*) AS num_duplicates
FROM 
  `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding`
GROUP BY 
  loan_id, user_id, loan_type
HAVING 
  COUNT(*) > 1

#Consulta para identificar valores duplicados na tabela user_info

SELECT
  user_id,
  age,
  sex,
  last_month_salary,
  number_dependents,
  COUNT(*) AS num_duplicatas
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.user_info`
GROUP BY
  user_id,
  age,
  sex,
  last_month_salary,
  number_dependents
HAVING
  COUNT(*) > 1;
