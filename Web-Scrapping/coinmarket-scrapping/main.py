# main.py
import time
from database import create_table, insert_data
from scraper import setup_driver, scrape_page
from config import TOTAL_PAGES
from logger import get_logger

logger = get_logger()

def main():
    logger.info("Project Started...")
    
    create_table()
    
    driver = setup_driver()
    
    try:
        # Loop through 90 pages
        for page in range(1, TOTAL_PAGES + 1):
            
            data = scrape_page(driver, page)
            
            if data:
                insert_data(data)
            else:
                logger.warning(f"No data extracted from Page {page}")
            
            time.sleep(2)
            
    except Exception as e:
        logger.critical(f"Main Process Error: {e}")
        
    finally:
        logger.info("Closing Browser...")
        driver.quit()
        logger.info("Project Completed Successfully.")

if __name__ == "__main__":
    main()