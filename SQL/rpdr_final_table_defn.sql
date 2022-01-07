select 
    cntstnt_ep.season
  , cntstnt_ep.episode
  , strftime("%m-%d-%Y",episds.airdate, 'unixepoch')--strftime("%m-%d-%Y", date_col, 'unixepoch')
  , episds.nickname
  , episds.special
  , cntstnt_ep.penultimate
  , cntstnt_ep.finale
  , episds.minic
  , episds.runwaytheme
  , episds.lipsyncartist
  , episds.lipsyncsong
  , cntstnt_ep.contestant
  , cntstnt_ep.rank
  , cntstnt_ep.missc
  , cntstnt.age
  , cntstnt.dob
  , cntstnt.hometown
  , cntstnt_ep.outcome
  , cntstnt_ep.minichalw
  , episds.minicw1
  , episds.minicw2
  , episds.minicw3
  , episds.bottom1
  , episds.bottom2
  , episds.bottom3
  , episds.bottom4
  , episds.bottom5
  , episds.bottom6
  , episds.eliminated1
  , episds.eliminated2
  , cntstnt_ep.eliminated
  , cntstnt_ep.participant
  , episds.numqueens
FROM cntstnt_ep

LEFT JOIN cntstnt

  ON cntstnt_ep.season=cntstnt.season
  
  AND cntstnt_ep.contestant=cntstnt.contestant
  
LEFT JOIN episds

  ON cntstnt_ep.season=episds.season
  
  AND cntstnt_ep.episode=episds.episode
