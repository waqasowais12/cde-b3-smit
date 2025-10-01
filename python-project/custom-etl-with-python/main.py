import sqlite3
from extract import extract
from logging_func import log_tracking
from transform_data import transform
from Loading.load_to_csv import load_to_csv 
from Loading.load_to_sql import load_to_db
from run_query import run_query

def main():
    url = 'https://web.archive.org/web/20230908091635/https://en.wikipedia.org/wiki/List_of_largest_banks'
    output_csv_path = './output/Largest_banks_data.csv'
    database_name = './output/Banks.db'
    table_name = 'Largest_banks'
    log_tracking('Preliminaries complete. Initiating ETL process')

    df = extract(url, 'By market capitalization')

    transform(df, './input/exchange_rate.csv')

    load_to_csv(df, output_csv_path)

    with sqlite3.connect(database_name) as conn:
        load_to_db(df, conn, table_name)

        print(run_query('SELECT * FROM Largest_banks', conn))

        print(run_query('SELECT AVG(MC_GBP_Billion) FROM Largest_banks', conn))

        print(run_query('SELECT "Bank name" FROM Largest_banks LIMIT 5', conn))



if __name__ == '__main__':
    main()