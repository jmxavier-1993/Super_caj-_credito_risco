WITH
proporcoes_gerais AS (
SELECT
COUNT(user_id) AS total_clientes,
SUM(default_flag) AS total_inadimplentes,
SUM(default_flag) / COUNT(user_id) AS proporcao_inadimplencia_geral
FROM
my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados
),
proporcoes_por_grupo AS (
SELECT
age_quartil,
COUNT(user_id) AS total_clientes_no_grupo,
SUM(default_flag) AS total_inadimplentes_no_grupo,
SUM(default_flag) / COUNT(user_id) AS proporcao_inadimplencia_no_grupo
FROM
my-project-laboratoria.dadoslaboratorioproject03.tb_quartis_compilada_com_outliers_tratados
GROUP BY
age_quartil
)
SELECT
p_grupo.age_quartil,
p_grupo.total_clientes_no_grupo,
p_grupo.total_inadimplentes_no_grupo,
p_grupo.proporcao_inadimplencia_no_grupo,
p_gerais.proporcao_inadimplencia_geral,
p_grupo.proporcao_inadimplencia_no_grupo / p_gerais.proporcao_inadimplencia_geral AS risco_relativo
FROM
proporcoes_por_grupo AS p_grupo
JOIN
proporcoes_gerais AS p_gerais
ON TRUE
ORDER BY
risco_relativo DESC;