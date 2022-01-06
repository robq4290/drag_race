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
  sql_param_statement
}