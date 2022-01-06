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
, episode.season
, episode.episode
, episode.airdate
, episode.special
, episode.finale
, episode.nickname
, episode.runwaytheme
, episode.numqueens
, episode.minic
, episode.minicw1
, episode.minicw2
, episode.minicw3
, episode.bottom1
, episode.bottom2
, episode.bottom3
, episode.bottom4
, episode.bottom5
, episode.bottom6
, episode.lipsyncartist
, episode.lipsyncsong
, episode.eliminated1
, episode.eliminated2

FROM cntstnt_ep

LEFT JOIN cntstnt

  ON cntstnt_ep.season=cntstnt.season
  
  AND cntstnt_ep.contestant=cntstnt.contestant
  
LEFT JOIN episds

  ON cntstnt_ep.season=episds.season
  
  AND cntstnt_ep.episode=episds.episode