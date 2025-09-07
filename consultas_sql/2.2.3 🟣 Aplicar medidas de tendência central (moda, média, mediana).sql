SELECT
    -- Médias (AVG)
    AVG(age_tratado) AS media_idade,
    AVG(salary_tratado) AS media_salario,
    AVG(dependents_tratado) AS media_dependentes,
    AVG(more_90_days_overdue) AS media_atraso_90_dias,
    AVG(using_lines_tratado) AS media_linhas_nao_garantidas,
    AVG(number_times_delayed_payment_loan_30_59_days) AS media_atraso_30_59_dias,
    AVG(debt_ratio_tratado) AS media_taxa_divida,
    AVG(number_times_delayed_payment_loan_60_89_days) AS media_atraso_60_89_dias,
FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
LIMIT 1;
SELECT
    -- Medianas (PERCENTILE_CONT)
    PERCENTILE_CONT(age_tratado, 0.5) OVER() AS mediana_idade,
    PERCENTILE_CONT(salary_tratado, 0.5) OVER() AS mediana_salario,
    PERCENTILE_CONT(dependents_tratado, 0.5) OVER() AS mediana_dependentes,
    PERCENTILE_CONT(more_90_days_overdue, 0.5) OVER() AS mediana_atraso_90_dias,
    PERCENTILE_CONT(using_lines_tratado, 0.5) OVER() AS mediana_linhas_nao_garantidas,
    PERCENTILE_CONT(number_times_delayed_payment_loan_30_59_days, 0.5) OVER() AS mediana_atraso_30_59_dias,
    PERCENTILE_CONT(debt_ratio_tratado, 0.5) OVER() AS mediana_taxa_divida,
    PERCENTILE_CONT(number_times_delayed_payment_loan_60_89_days, 0.5) OVER() AS mediana_atraso_60_89_dias,
FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
LIMIT 1;

SELECT
    -- Modas (usando subconsultas)
    (SELECT APPROX_TOP_COUNT(age_tratado, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_idade,
    (SELECT APPROX_TOP_COUNT(salary_tratado, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_salario,
    (SELECT APPROX_TOP_COUNT(dependents_tratado, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_dependentes,
    (SELECT APPROX_TOP_COUNT(more_90_days_overdue, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_atraso_90_dias,
    (SELECT APPROX_TOP_COUNT(using_lines_tratado, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_linhas_nao_garantidas,
    (SELECT APPROX_TOP_COUNT(number_times_delayed_payment_loan_30_59_days, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_atraso_30_59_dias,
    (SELECT APPROX_TOP_COUNT(debt_ratio_tratado, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_taxa_divida,
    (SELECT APPROX_TOP_COUNT(number_times_delayed_payment_loan_60_89_days, 1)[OFFSET(0)].value FROM `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`) AS moda_atraso_60_89_dias

FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
LIMIT 1;