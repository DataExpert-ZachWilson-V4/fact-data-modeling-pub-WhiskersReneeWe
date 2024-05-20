INSERT INTO whiskersreneewe.user_devices_cumulated
WITH yesterday AS (
  SELECT * FROM whiskersreneewe.user_devices_cumulated
  WHERE date = DATE('2023-01-08')
),

today AS (
SELECT 
  user_id, 
  CAST(date_trunc('day', event_time) AS DATE) AS event_date,
  browser_type,
  count(1) FROM bootcamp.web_events we
JOIN bootcamp.devices d 
ON we.device_id = d.device_id
WHERE date_trunc('day', event_time) = DATE('2023-01-09')
GROUP BY user_id, date_trunc('day', event_time), browser_type
)

SELECT 
  COALESCE(y.user_id, t.user_id) AS user_id,
  t.browser_type AS browswer_type,
  CASE 
    WHEN y.dates_active IS NOT NULL THEN ARRAY[t.event_date] || y.dates_active
    ELSE ARRAY[t.event_date] 
  END AS dates_active,
  DATE('2023-01-09') as date
FROM yesterday y 
FULL OUTER JOIN today t
ON y.user_id = t.user_id