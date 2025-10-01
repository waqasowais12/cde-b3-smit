import pandas as pd
from logging_func import log_tracking

def transform(df, csv_path):
    """ This function accesses the CSV file for exchange rate
    information, and adds three columns to the data frame, each
    containing the transformed version of Market Cap column to
    respective currencies"""

    exchange_rate = pd.read_csv(csv_path, index_col=0).to_dict()['Rate']

    df['MC_GBP_Billion'] = round(df['Market cap (US$ billion)'] * exchange_rate['GBP'], 2)
    df['MC_EUR_Billion'] = round(df['Market cap (US$ billion)'] * exchange_rate['EUR'], 2)
    df['MC_INR_Billion'] = round(df['Market cap (US$ billion)'] * exchange_rate['INR'], 2)

    print(df)

    log_tracking('Data transformation complete. Initiating Loading process')

    return df