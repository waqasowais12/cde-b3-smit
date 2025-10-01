from logging_func import log_tracking

def load_to_csv(df, output_path):
    """ This function saves the final data frame as a CSV file in
    the provided path. Function returns nothing."""

    df.to_csv(output_path)

    log_tracking('Data saved to CSV file')