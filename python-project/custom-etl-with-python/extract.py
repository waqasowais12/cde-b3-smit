from io import StringIO
import requests
from bs4 import BeautifulSoup
import pandas as pd
from logging_func import log_tracking

def extract(url, table_attribs):
    """ This function aims to extract the required
    information from the website and save it to a data frame. The
    function returns the data frame for further processing. """

    soup = BeautifulSoup(requests.get(url).text, 'html.parser')
    table = soup.find('span', string=table_attribs).find_next('table')
    df = pd.read_html(StringIO(str(table)))[0]

    log_tracking('Data extraction complete. Initiating Transformation process')

    return df