CREATE VIEW vw_episodes AS 

  SELECT 
      rpdr.season as season_number
    , rpdr.episode as episode_number
    , rpdr.airdate as air_date
    -- verified that the dates match, not needed in the final table
    --, case when rpdr.airdate=dp.airdate then 1 else 0 end as date_check
      -- titles were similar enough  keeping rpdr column 
    --, case when dp.title=rpdr.nickname then 1 else 0 end as title_check
    , rpdr.nickname as episode_title 
    , dp.episode_type 
    -- Will need to make a new table for minichallenge that can be joined with the dp_ranking table
    , rpdr.minic as mini_challenge
    , rpdr.minicw1 as mini_challenge_winner_1
    , rpdr.minicw1 as mini_challenge_winner_2
    , rpdr.minicw3 as mini_challenge_winner_3
    -- going to use the dp_ranking table for top and bottom tracking
    , dp.challenge_desc 
    -- This column has a lot of NULLs. Need to find a new source will not
    -- be able to extract much information from this
    -- , rpdr.runwaytheme as runway_theme
    , rpdr.lipsyncartist as lsfyl_artist 
    , rpdr.lipsyncsong as lsfyl_song
    , CASE 
        WHEN (rpdr.eliminated1 IS NOT NULL) AND  (rpdr.eliminated2 IS NOT NULL) THEN 1
        ELSE 0 
      END AS flg_mltpl_elim
    , CASE 
        WHEN UPPER(rpdr.nickname) LIKE '%SNATCH%' THEN 1
        ELSE 0 
      END AS flg_snatch_game
  
    
  FROM rpdr_episodes rpdr 
  
  INNER JOIN dp_episodes dp
  
    ON  rpdr.season=dp.season
    
    and rpdr.episode=dp.episode
