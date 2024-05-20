with dups as (
SELECT 
 *,
 ROW_NUMBER() OVER (PARTITION BY game_id, team_id, player_id) AS repetition_tag
FROM bootcamp.nba_game_details)

SELECT 
game_id,
team_id,
team_abbreviation,
team_city,
player_id,
player_name,
nickname,
start_position,
"comment", -- use double quotes for reserved keyword
min
FROM dups
WHERE repetition_tag = 1