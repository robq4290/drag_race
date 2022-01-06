db_create_table <- function(db_conn, file_location, file_name, df_in, tbl_name,pk_val){
  
  col_names <- DBI::SQL(colnames(df_in))
  
  col_names_sql <- glue::glue_sql("{col_names*}",.con=db_conn)
  
  sql_file <- readr::read_file(file=here::here(file_location,file_name))
  
  if(length(pk_val)==1){
    pk_val_sql
    
    sql_param_statement <- DBI::sqlInterpolate(  conn=db_conn
                                                 , sql=sql_file
                                                 , table_name=DBI::SQL(tbl_name)
                                                 , column_names=col_names_sql
                                                 , primary_key_cols=DBI::SQL(pk_val)
    )
    sql_param_statement
  }else{
    
    pk_vals <- DBI::SQL(pk_val) 
    
    pk_vals_sql <- glue::glue_sql("{pk_vals*}",.con=db_conn)
    sql_param_statement <- DBI::sqlInterpolate(  conn=db_conn
                                                 , sql=sql_file
                                                 , table_name=DBI::SQL(tbl_name)
                                                 , column_names=col_names_sql
                                                 , primary_key_cols=pk_vals_sql
    )
    sql_param_statement
  }
  

}