SELECT
    DISTINCT(age_tratado) AS contagem_idade,
    AVG(age_tratado) AS media_idade,
    STDDEV(age_tratado) AS desvio_padrao_idade,
    MIN(age_tratado) AS min_idade,
    PERCENTILE_CONT(age_tratado, 0.25) OVER() AS q1_idade,
    PERCENTILE_CONT(age_tratado, 0.5) OVER() AS mediana_idade,
    PERCENTILE_CONT(age_tratado, 0.75) OVER() AS q3_idade,
    MAX(age_tratado) AS max_idade,
   
FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
GROUP BY age_tratado
limit 1;


SELECT
    COUNT(salary_tratado) AS contagem_salario,
    AVG(salary_tratado) AS media_salario,
    STDDEV(salary_tratado) AS desvio_padrao_salario,
    MIN(salary_tratado) AS min_salario,
    PERCENTILE_CONT(salary_tratado, 0.25) OVER() AS q1_salario,
    PERCENTILE_CONT(salary_tratado, 0.5) OVER() AS mediana_salario,
    PERCENTILE_CONT(salary_tratado, 0.75) OVER() AS q3_salario,
    MAX(salary_tratado) AS max_salario
   
FROM
    `my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados`
GROUP BY salary_tratado    
LIMIT 1;
