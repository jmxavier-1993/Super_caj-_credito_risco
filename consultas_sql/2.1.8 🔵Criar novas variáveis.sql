CREATE OR REPLACE Table `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding_corrigida_maisvariaveis` AS
SELECT
  user_id,
  COALESCE(SUM(CASE WHEN loan_type = "REAL ESTATE" THEN 1 ELSE 0 END), 0) AS qtd_imoveis_emprestimos,
  COALESCE(SUM(CASE WHEN loan_type = "OTHER" THEN 1 ELSE 0 END), 0) AS qtd_outros_emprestimos,
 
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding_corrigida`
GROUP BY user_id;
