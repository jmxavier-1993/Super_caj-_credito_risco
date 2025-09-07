SELECT
    -- Correlação da idade com as outras variáveis
    CORR(age_tratado, salary_tratado) AS age_salary_corr,
    CORR(age_tratado, dependents_tratado) AS age_dependents_corr,
    CORR(age_tratado, debt_ratio_tratado) AS age_debt_ratio_corr,
    CORR(age_tratado, using_lines_tratado) AS age_using_lines_corr,
    CORR(age_tratado, default_flag) AS age_default_flag_corr,
    CORR(age_tratado, more_90_days_overdue) AS age_more_90_days_corr,
    CORR(age_tratado, total_emprestimos) AS age_total_emprestimos_corr,
    CORR(age_tratado, number_times_delayed_payment_loan_30_59_days) AS age_delay_30_59_corr,
    CORR(age_tratado, number_times_delayed_payment_loan_60_89_days) AS age_delay_60_89_corr,

    -- Correlação do salário com as outras variáveis
    CORR(salary_tratado, dependents_tratado) AS salary_dependents_corr,
    CORR(salary_tratado, debt_ratio_tratado) AS salary_debt_ratio_corr,
    CORR(salary_tratado, using_lines_tratado) AS salary_using_lines_corr,
    CORR(salary_tratado, default_flag) AS salary_default_flag_corr,
    CORR(salary_tratado, more_90_days_overdue) AS salary_more_90_days_corr,
    CORR(salary_tratado, total_emprestimos) AS salary_total_emprestimos_corr,
    CORR(salary_tratado, number_times_delayed_payment_loan_30_59_days) AS salary_delay_30_59_corr,
    CORR(salary_tratado, number_times_delayed_payment_loan_60_89_days) AS salary_delay_60_89_corr,
    
    -- Correlação dos dependentes com as outras variáveis
    CORR(dependents_tratado, debt_ratio_tratado) AS dependents_debt_ratio_corr,
    CORR(dependents_tratado, using_lines_tratado) AS dependents_using_lines_corr,
    CORR(dependents_tratado, default_flag) AS dependents_default_flag_corr,
    CORR(dependents_tratado, more_90_days_overdue) AS dependents_more_90_days_corr,
    CORR(dependents_tratado, total_emprestimos) AS dependents_total_emprestimos_corr,
    CORR(dependents_tratado, number_times_delayed_payment_loan_30_59_days) AS dependents_delay_30_59_corr,
    CORR(dependents_tratado, number_times_delayed_payment_loan_60_89_days) AS dependents_delay_60_89_corr,

    -- Correlação da taxa de dívida com as outras variáveis
    CORR(debt_ratio_tratado, using_lines_tratado) AS debt_ratio_using_lines_corr,
    CORR(debt_ratio_tratado, default_flag) AS debt_ratio_default_flag_corr,
    CORR(debt_ratio_tratado, more_90_days_overdue) AS debt_ratio_more_90_days_corr,
    CORR(debt_ratio_tratado, total_emprestimos) AS debt_ratio_total_emprestimos_corr,
    CORR(debt_ratio_tratado, number_times_delayed_payment_loan_30_59_days) AS debt_ratio_delay_30_59_corr,
    CORR(debt_ratio_tratado, number_times_delayed_payment_loan_60_89_days) AS debt_ratio_delay_60_89_corr,

    -- Correlação das linhas de crédito com as outras variáveis
    CORR(using_lines_tratado, default_flag) AS using_lines_default_flag_corr,
    CORR(using_lines_tratado, more_90_days_overdue) AS using_lines_more_90_days_corr,
    CORR(using_lines_tratado, total_emprestimos) AS using_lines_total_emprestimos_corr,
    CORR(using_lines_tratado, number_times_delayed_payment_loan_30_59_days) AS using_lines_delay_30_59_corr,
    CORR(using_lines_tratado, number_times_delayed_payment_loan_60_89_days) AS using_lines_delay_60_89_corr,

    -- Correlação do default_flag com as variáveis de atraso
    CORR(default_flag, more_90_days_overdue) AS default_flag_more_90_days_corr,
    CORR(default_flag, number_times_delayed_payment_loan_30_59_days) AS default_flag_delay_30_59_corr,
    CORR(default_flag, number_times_delayed_payment_loan_60_89_days) AS default_flag_delay_60_89_corr,
    CORR(default_flag, total_emprestimos) AS default_flag_total_emprestimos_corr
FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
LIMIT 1;