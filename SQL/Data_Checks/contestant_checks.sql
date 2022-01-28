-- !preview conn=DBI::dbConnect(RSQLite::SQLite(), dbname = "drag_race_dev.sqlite")


 -- EXCEPT 

/*
SELECT rpdr_contestants.contestant from rpdr_contestants

EXCEPT 

select  contestant_name AS contestant from dp_contestants
*/

select distinct season_number from dp_contestants