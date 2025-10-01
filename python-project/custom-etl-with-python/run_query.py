from logging_func import log_tracking

def run_query(query_statement, sql_connection):
    """ This function runs the query on the database table and
    prints the output on the terminal. Function returns nothing. """

    cursor = sql_connection.cursor()
    cursor.execute(query_statement)
    result = cursor.fetchall()

    log_tracking('Process Complete')

    return result