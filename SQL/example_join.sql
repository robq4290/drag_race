select 
    cntstnt_ep.season 
  , cntstnt_ep.episode
  , cntstnt_ep.outcome
  , cntstnt.age
  , cntstnt.dob
  , episds.airdate
  , episds.lipsyncartist as lip_sync_artist
FROM cntstnt_ep

LEFT JOIN cntstnt

  ON cntstnt_ep.season=cntstnt.season
  
  AND cntstnt_ep.contestant=cntstnt.contestant
  
LEFT JOIN episds

  ON cntstnt_ep.season=episds.season
  
  AND cntstnt_ep.episode=episds.episode