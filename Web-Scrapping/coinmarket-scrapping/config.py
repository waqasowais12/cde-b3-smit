# config.py

BASE_URL = "https://coinmarketcap.com/?page={}"
TOTAL_PAGES = 90

# SQL Server Configuration
DB_CONFIG = {
    'driver': '{ODBC Driver 17 for SQL Server}',  
    'server': 'DESKTOP-H96K80L',           
    'database': 'crypto_db',
    'trusted_connection': 'yes'                
}

HEADLESS_MODE = False