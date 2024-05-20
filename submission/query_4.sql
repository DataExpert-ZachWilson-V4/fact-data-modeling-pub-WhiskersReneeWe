WITH datelist_int AS (
SELECT 
  user_id,
  browser_type,
  CAST(SUM(
  CASE 
   WHEN CONTAINS(dates_active, sequence_date) THEN POW(2, 31 - DATE_DIFF('DAY', sequence_date, date)) ELSE 0
  END ) AS BIGINT) AS history_int
FROM whiskersreneewe.user_devices_cumulated
CROSS JOIN UNNEST (SEQUENCE(DATE('2023-01-01'), DATE('2023-01-09'))) AS t(sequence_date)
WHERE date = DATE('2023-01-09')
GROUP BY user_id, browser_type
)

SELECT 
  user_id, browser_type,
  history_int,
  to_base(history_int, 2) AS history_in_binary
FROM datelist_int