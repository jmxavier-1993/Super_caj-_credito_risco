CREATE OR REPLACE TABLE `my-project-laboratoria.dadoslaboratorioproject03.tb_consolidada` AS
SELECT
  de.*,
  COALESCE(lo.qtd_imoveis_emprestimos, 0) AS qtd_imoveis_emprestimos,
  COALESCE(lo.qtd_outros_emprestimos, 0) AS qtd_outros_emprestimos,
  FROM
  `my-project-laboratoria.dadoslaboratorioproject03.default_user_info_loans_details` AS de
LEFT JOIN
  `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding_corrigida_maisvariaveis` AS lo
ON  
  de.user_id = lo.user_id;
