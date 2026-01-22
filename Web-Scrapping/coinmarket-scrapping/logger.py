# logger.py
import logging
import os

if not os.path.exists('logs'):
    os.makedirs('logs')

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - [%(filename)s] - %(message)s',
    handlers=[
        logging.FileHandler("logs/scraping.log"),
        logging.StreamHandler()
    ]
)

def get_logger():
    return logging.getLogger()