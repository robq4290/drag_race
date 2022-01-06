select 
  cntstnt_ep.season
, cntstnt_ep.rank
, cntstnt_ep.missc
, cntstnt_ep.contestant
, cntstnt_ep.episode
, cntstnt_ep.outcome
, cntstnt_ep.eliminated
, cntstnt_ep.participant
, cntstnt_ep.minichalw
, cntstnt_ep.finale
, cntstnt_ep.penultimate
, cntstnt.season
, cntstnt.contestant
, cntstnt.age
, cntstnt.dob
, cntstnt.hometown
, episds.season
, episds.episode
, episds.airdate
, episds.special
, episds.finale
, episds.nickname
, episds.runwaytheme
, episds.numqueens
, episds.minic
, episds.minicw1
, episds.minicw2
, episds.minicw3
, episds.bottom1
, episds.bottom2
, episds.bottom3
, episds.bottom4
, episds.bottom5
, episds.bottom6
, episds.lipsyncartist
, episds.lipsyncsong
, episds.eliminated1
, episds.eliminated2

FROM cntstnt_ep

LEFT JOIN cntstnt

  ON cntstnt_ep.season=cntstnt.season
  
  AND cntstnt_ep.contestant=cntstnt.contestant
  
LEFT JOIN episds

  ON cntstnt_ep.season=episds.season
  
  AND cntstnt_ep.episode=episds.episode
  
limit 1