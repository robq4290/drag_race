#' Title
#'
#' @param db_conn 
#' @param file_location 
#' @param file_name 
#' @param df_in 
#' @param tbl_name 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
db_create_table <- function(db_conn, file_location, file_name, df_in, tbl_name,...){
  
  sql_file <- readr::read_file(file=here::here(file_location,file_name))
  
  col_names <- DBI::SQL(colnames(df_in))
  
  col_names_sql <- glue::glue_sql("{col_names*}",.con=db_conn)
  
  addn_args <- list(...)

  pk_len <- length(addn_args)  
  if(pk_len==0){
    
    pk_vals_sql <- DBI::SQL("NULL")

  }else{
    
    pk_vals <- DBI::SQL(unlist(addn_args))
    
    pk_vals_sql <- glue::glue_sql("{pk_vals*}",.con=db_conn)
  }
  
  sql_param_statement <- DBI::sqlInterpolate(  conn=db_conn
                                               , sql=sql_file
                                               , table_name=DBI::SQL(tbl_name)
                                               , column_names=col_names_sql
                                               , primary_key_cols=pk_vals_sql
  )

  DBI::dbExecute(conn=db_conn, statement= sql_param_statement)
  
  DBI::dbWriteTable(conn=db_conn, name=tbl_name, value=df_in, append=TRUE, row.names=FALSE)
}


#' Title
#'
#' @param db_conn 
#' @param file_location 
#' @param file_name 
#'
#' @return
#' @export
#'
#' @examples
db_exec_query <- function(db_conn, file_location, file_name, print_query=FALSE){
  
  sql_file <- readr::read_file(file=here::here(file_location,file_name))
  
  sql_statement <- DBI::sqlInterpolate(  conn=db_conn, sql=sql_file)
  if(print_query){
    print(sql_statement)
  }
  
  
  results <- DBI::dbGetQuery(conn=db_conn, statement=sql_statement)
  
  results
}

get_df_col_names_selectable <- function(df_in, alias){
  
  df_cols <- colnames(df_in)
  
  alias_cols <- glue("{alias}.{df_cols}")
  
  select_out <- glue_collapse(alias_cols,sep = "\n, ")
  
  return(select_out)
}


rpdr_connection <- function(){
  DBI::dbConnect(RSQLite::SQLite(), dbname="drag_race_dev.sqlite")
}

db_exec_param_query <- function(db_conn, file_location, file_name, print_query=FALSE,...){
  
  sql_file <- readr::read_file(file=here::here(file_location,file_name))
  
  sql_statement <- DBI::sqlInterpolate(  conn=db_conn, sql=sql_file,...)
  if(print_query){
    print(sql_statement)
  }
  
  
  results <- DBI::dbGetQuery(conn=db_conn, statement=sql_statement)
  
  results
}

db_write_table <- function(db_conn, tbl_name, df_in){
  
 # df_to_write <- sym(df_in)
  
  DBI::dbWriteTable(conn=db_conn
                    , name=tbl_name
                    , value= df_in#!!df_to_write
                    )
  
}

db_update_column <- function(db_conn, tbl_name, column_name, column_value, condition){
  
  # using the DBI quoting functions to safely pass in the condition parameters
  
  tbl_name_sql <- DBI::SQL(tbl_name)
  column_name_sql <- DBI::SQL(column_name)
  column_value_sql <- DBI::dbQuoteLiteral(conn=db_conn,column_value)
  condition_quote <- DBI::dbQuoteLiteral(conn=db_conn, condition)
  
  update_statement <- glue::glue_sql("UPDATE {tbl_name_sql} SET {column_name_sql} = {column_value_sql} WHERE {column_name_sql}= {condition_quote}", .con=db_conn)
  
  rows_out <- DBI::dbExecute(conn=db_conn, update_statement)
  print(update_statement)
  
  if(rows_out==0){
    
    print(glue("Zero rows returned. {tbl_name} not updated. 
         Check the supplied condition {condition_quote}")
         )
  }else{
    print(glue("There were {rows_out} rows in {tbl_name} updated from {condition} to {column_value}."))
  }
  
  
}

db_create_view <- function(db_conn, sql_path, sql_file){
  vw_def <- readr::read_file(file=glue("{sql_path}/{sql_file}"))
  
  sql_statement <- DBI::sqlInterpolate(  conn=db_conn, sql=vw_def)
# need to make this a trycatch block
  print(sql_statement)
  
  rows_out <- DBI::dbExecute(conn=db_conn, sql_statement)
  
  if(rows_out!=0){
    print("Sucessful view update")
  }else{
    print("View not created, check definition and source tables")
    print(sql_statement)
  }
  
}

db_write_all_tables <- function(){
  db_conn <- DBI::dbConnect(RSQLite::SQLite(), dbname = "drag_race_dev.sqlite")
  
  db_write_table(db_conn = db_conn, tbl_name="dp_contestants", df_in=all_contestants)
  
  db_write_table(db_conn = db_conn, tbl_name="dp_episodes", df_in=all_episodes)
  
  db_write_table(db_conn = db_conn, tbl_name="dp_ranking", df_in=all_rankings)
  
  db_write_table(db_conn = db_conn, tbl_name="dp_social_media", df_in=all_social_media)
  
  db_write_table(db_conn = db_conn, tbl_name="rpdr_episodes", df_in=rpdr_ep)
  
  db_write_table(db_conn = db_conn, tbl_name="rpdr_contestants", df_in=rpdr_contestants)
  
  db_write_table(db_conn = db_conn, tbl_name="rpdr_contestant_season", df_in=rpdr_combined)
  
  db_write_table(db_conn = db_conn, tbl_name="drag_family", df_in=drag_family_data)
  
  dbDisconnect(db_conn)
  
}

