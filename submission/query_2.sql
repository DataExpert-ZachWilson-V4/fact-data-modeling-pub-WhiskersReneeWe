-- create a table : each day has a unique useid and ARRAY[ACTIVE DATES]
-- This table will be the result of joining the devices table onto the web_events table, 
-- so that you can get both the user_id and the browser_type.
-- web_events: user_id, device_id, referrer, host, url, event_time
-- devices: device_id, browser_type, os_type, device_type
CREATE TABLE user_devices_cumulated (
    user_id BIGINT,
    browser_type VARCHAR,
    dates_active ARRAY(DATE),
    date DATE
) WITH (
    format = 'PARQUET',
    partitioning = ARRAY['date']
)