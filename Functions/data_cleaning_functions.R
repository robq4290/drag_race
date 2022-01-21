get_dfp_frames <- function(frame_list, save_path){
  googlesheets4::gs4_deauth() 
  data_for_prog_url <- "https://docs.google.com/spreadsheets/d/1Sotvl3o7J_ckKUg5sRiZTqNQn3hPqhepBSeOpMTK15Q/"
  
  # RSLite() is weird with dates and we need to store them as characters. Will use a simple mutate
  
  all_episodes <-  read_sheet(data_for_prog_url, sheet="all_episodes", col_names=TRUE
                              , col_types='ccDccc', trim_ws=TRUE) %>% 
    mutate_at(c("episode_airdate"), as.character)
  
  all_contestants <-read_sheet(data_for_prog_url, sheet="all_contestants", col_names=TRUE
                               , col_types='cccciccicc',  trim_ws=TRUE)
  
  all_rankings <- read_sheet(data_for_prog_url, sheet="all_rankings", col_names=TRUE
                             , col_types='cccc', trim_ws=TRUE)
  
  # Skipping the headers, it is easier to ordinarily rename
  # applying the same mutate for the date column
  all_social_media <- read_sheet(data_for_prog_url, sheet="all_social_media", col_names=FALSE
                                 , col_types='cDii',trim_ws=TRUE, skip=2)%>% 
    rename(  contestant_id=1
             , date_pulled=2
             , twitter_followers=3
             , instagram_followers=4
    )%>% 
    mutate_at(c("date_pulled"), as.character)
  
  
  
  for(df in frame_list){
    # gets the df in the frame list from the environment 
    df_to_save <- get(df)
    file_name <- glue("{df}.RDS")
    print(file_name)
    saveRDS(df_to_save, file=here(save_path,file_name))
    rm(df_to_save)
  }
  
  
}