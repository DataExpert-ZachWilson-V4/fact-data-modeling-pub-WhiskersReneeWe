INSERT INTO whiskersreneewe.host_activity_reduced
WITH yesterday AS (
  SELECT * FROM whiskersreneewe.host_activity_reduced
  WHERE month_start = DATE('2023-08-01')
),
today as (
  SELECT 
    *
  FROM whiskersreneewe.daily_web_metrics
  WHERE date = DATE('2023-08-03')
)
SELECT 
  COALESCE(y.host, t.host) AS host,
  COALESCE(y.metric_name, t.metric_name) AS metric_name,
  COALESCE(y.metric_array, REPEAT(null, CAST(DATE_DIFF('day', y.month_start, t.date ) AS INTEGER))) || t.metric_value AS metric_array,
  DATE('2023-08-01') AS month_start
FROM yesterday y
FULL OUTER JOIN today t
ON y.host = t.host AND y.metric_name = t.metric_name
