CREATE OR REPLACE VIEW
  `my-project-laboratoria.dadoslaboratorioproject03.tb_consolida_final` AS
SELECT
  user_id,
  default_flag,
  age,
  last_month_salary,
  number_dependents,
  more_90_days_overdue,
  using_lines_not_secured_personal_assets,
  number_times_delayed_payment_loan_30_59_days,
  number_times_delayed_payment_loan_60_89_days,
  debt_ratio,
  faixa_etaria,
  qtd_imoveis_emprestimos,
  qtd_outros_emprestimos,
  (COALESCE(qtd_imoveis_emprestimos, 0) + COALESCE(qtd_outros_emprestimos, 0)) AS total_emprestimos
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.tb_consolidada`;