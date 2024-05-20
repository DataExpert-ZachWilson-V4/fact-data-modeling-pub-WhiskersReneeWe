INSERT INTO whiskersreneewe.hosts_cumulated
With yesterday_hosts AS (
    SELECT * FROM whiskersreneewe.hosts_cumulated
    WHERE date = DATE('2023-01-01')
),
today_hosts AS (
  SELECT 
    host,
    CAST(date_trunc('day', event_time) AS DATE) AS event_date
  FROM bootcamp.web_events
  WHERE date_trunc('day', event_time) = DATE('2023-01-02')
)

SELECT 
  COALESCE(yh.host, th.host) AS host,
  CASE
    WHEN yh.host_activity_datelist IS NOT NULL THEN ARRAY[th.event_date] || yh.host_activity_datelist ELSE ARRAY[th.event_date]
  END host_activity_datelist,
  DATE('2023-01-02') as date
FROM yesterday_hosts yh 
FULL OUTER JOIN today_hosts th 
ON yh.host = th.host