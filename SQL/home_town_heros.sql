SELECT 
     hometown
   , count(distinct contestant) as num_queens
   , sum(CASE WHEN finale=1 AND rank=1 THEN 1 end) AS num_winners
   , sum(CASE WHEN episode=1 AND eliminated=1 THEN 1 END) AS num_home_first 
   
FROM rpdr_hist
WHERE special=0
GROUP BY hometown
ORDER BY num_winners desc