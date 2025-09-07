CREATE OR REPLACE Table `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding_corrigida` AS
SELECT
  l.loan_id,
  l.user_id,
  UPPER(l.loan_type) AS loan_type,
 FROM
  `my-project-laboratoria.dadoslaboratorioproject03.loans_outstanding` AS l
