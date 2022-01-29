CREATE VIEW vw_contestants AS

  SELECT 
      dp.contestant_id 
    , rpdr.contestant
    , rpdr.dob AS birthday
    , strftime('%Y',rpdr.dob) AS year_born
    , dp.instagram
    , dp.twitter
    , rpdr.state AS home_state
    , dp.city AS current_city
    , dp.state AS current_state
    , rpdr.city AS home_city 
    , rpdr.season 
    , dp.entrance 
    , dp.place
    , max(dp.place) OVER(PARTITION BY rpdr.season) as season_nbr_queeens
  FROM rpdr_contestants rpdr 
  
  INNER JOIN dp_contestants dp
  
    ON rpdr.contestant = dp.contestant 
    
    and rpdr.season=dp.season
