# database.py
import pyodbc
from config import DB_CONFIG
from logger import get_logger

logger = get_logger()

def get_connection(db_name=None):
    """
    Connection string banata hai.
    Agar db_name diya ho to specific DB se connect karega,
    warna 'master' se connect karega (Database create karne ke liye).
    """
    try:
        conn_str = (
            f"DRIVER={DB_CONFIG['driver']};"
            f"SERVER={DB_CONFIG['server']};"
            f"TRUSTED_CONNECTION={DB_CONFIG['trusted_connection']};"
        )
        
        if db_name:
            conn_str += f"DATABASE={db_name};"
            
        conn = pyodbc.connect(conn_str, autocommit=True) 
        return conn
    except pyodbc.Error as err:
        logger.error(f"SQL Server Connection Failed: {err}")
        return None

def create_table():
    
    conn = get_connection() 
    if conn:
        try:
            cursor = conn.cursor()
            
            
            check_db_query = f"SELECT name FROM master.dbo.sysdatabases WHERE name = '{DB_CONFIG['database']}'"
            cursor.execute(check_db_query)
            
            if not cursor.fetchone():
                logger.info(f"Database {DB_CONFIG['database']} nahi mila, naya bana rahe hen...")
                cursor.execute(f"CREATE DATABASE {DB_CONFIG['database']}")
                logger.info("Database created successfully.")
            
            cursor.close()
            conn.close()
        except Exception as e:
            logger.error(f"Database creation error: {e}")
            return

    conn = get_connection(DB_CONFIG['database'])
    if conn:
        try:
            cursor = conn.cursor()
            
    
            query = """
            IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='coins' AND xtype='U')
            CREATE TABLE coins (
                id INT IDENTITY(1,1) PRIMARY KEY,
                cmc_rank NVARCHAR(10),
                name NVARCHAR(255),
                price NVARCHAR(50),
                change_1h NVARCHAR(50),
                change_24h NVARCHAR(50),
                change_7d NVARCHAR(50),
                market_cap NVARCHAR(100),
                volume_24h NVARCHAR(100),
                circulating_supply NVARCHAR(100),
                scraping_date DATETIME DEFAULT GETDATE()
            )
            """
            cursor.execute(query)
            logger.info("Table structure checked/created successfully.")
            cursor.close()
            conn.close()
        except Exception as e:
            logger.error(f"Table creation error: {e}")

def insert_data(data_list):
    conn = get_connection(DB_CONFIG['database'])
    if conn:
        try:
            cursor = conn.cursor()
            
            query = """
            INSERT INTO coins 
            (cmc_rank, name, price, change_1h, change_24h, change_7d, market_cap, volume_24h, circulating_supply) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """
            
            cursor.executemany(query, data_list)
            
            logger.info(f"Saved {cursor.rowcount} records to SQL Server.")
            cursor.close()
            conn.close()
        except Exception as e:
            logger.error(f"Data insertion error: {e}")