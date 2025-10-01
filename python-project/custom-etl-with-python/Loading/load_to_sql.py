from logging_func import log_tracking

def load_to_db(df, sql_connection, table_name):
    """ This function saves the final data frame to a database
    table with the provided name. Function returns nothing."""

    df.to_sql(table_name, sql_connection, if_exists='replace', index=False)

    log_tracking('Data loaded to Database as a table, Executing queries')