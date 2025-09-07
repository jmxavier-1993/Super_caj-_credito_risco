-- Matriz de confusão para validar a segmentação por score
SELECT
  score_risco_total,
  default_flag,
  COUNT(*) AS total_clientes,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY score_risco_total), 2) AS percentual_grupo,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentual_total
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.tb_score_dummy`
GROUP BY
  score_risco_total, default_flag
ORDER BY
  score_risco_total, default_flag;


-- Calcular acurácia da classificação
SELECT
  CASE
    WHEN flag_alto_risco_binaria = 1 AND default_flag = 1 THEN 'Verdadeiro Positivo'
    WHEN flag_alto_risco_binaria = 1 AND default_flag = 0 THEN 'Falso Positivo'
    WHEN flag_alto_risco_binaria = 0 AND default_flag = 1 THEN 'Falso Negativo'
    WHEN flag_alto_risco_binaria = 0 AND default_flag = 0 THEN 'Verdadeiro Negativo'
  END AS tipo_classificacao,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentual
FROM
  `my-project-laboratoria.dadoslaboratorioproject03.tb_score_dummy`
GROUP BY
  flag_alto_risco_binaria, default_flag;  