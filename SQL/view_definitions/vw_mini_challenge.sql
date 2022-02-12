-- !preview conn=DBI::dbConnect(RSQLite::SQLite(), dbname = "drag_race_dev.sqlite")
CREATE VIEW vw_mini_challenge AS
  with base_table AS
  (
    SELECT 
        rpdr.season
      , rpdr.episode
      , rpdr.airdate
      , rpdr.minic as mini_challenge
      , rpdr.minicw1 as mini_challenge_winner_1
      , rpdr.minicw1 as mini_challenge_winner_2
      , rpdr.minicw3 as mini_challenge_winner_3
    
      
    FROM rpdr_episodes rpdr 
  ),
  union_table AS
  ( -- Using UNION because the original columns have duplicates if there was only one winner 
    SELECT season, episode, airdate, mini_challenge, mini_challenge_winner_1 AS winner FROM base_table 
    
      WHERE mini_challenge_winner_1 is not null
    
      UNION
  
    SELECT season, episode, airdate, mini_challenge, mini_challenge_winner_2 AS winner FROM base_table 
    
      WHERE mini_challenge_winner_2 is not null
    
      UNION 
      
    SELECT season, episode, airdate, mini_challenge, mini_challenge_winner_3 AS winner FROM base_table 
    
      WHERE mini_challenge_winner_3 is not null
  
  
  )
  
  SELECT  
      season as season_number
    , episode as episode_number
    , airdate as air_date
    , mini_challenge
    , winner
    , count(winner)OVER(PARTITION BY season, episode) AS "nbr_winners"
    , CASE 
        WHEN "nbr_winners">1 THEN 1
        ELSE 0 
      END AS flg_mltpl_winners
  FROM union_table
