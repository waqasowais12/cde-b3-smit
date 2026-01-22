# scraper.py
import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from config import BASE_URL, HEADLESS_MODE
from logger import get_logger

logger = get_logger()

def setup_driver():
    """Browser setup wesa hi jesa apne dia"""
    options = Options()
    options.add_argument("--start-maximized")
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")
    
    if HEADLESS_MODE:
        options.add_argument("--headless")

    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=options)
    return driver

def scrape_page(driver, page_number):
    url = BASE_URL.format(page_number)
    logger.info(f"Navigating to Page: {page_number}")
    
    try:
        driver.get(url)
        time.sleep(3)  
        logger.info("Scrolling start...")
        scroll_pause_time = 0.5 
        scroll_step = 300
        last_height = driver.execute_script("return document.body.scrollHeight")

        while True:
            for i in range(0, last_height, scroll_step):
                driver.execute_script(f"window.scrollTo(0, {i});")
                time.sleep(scroll_pause_time)
            
            new_height = driver.execute_script("return document.body.scrollHeight")
            if new_height == last_height:
                break 
            last_height = new_height
        
        logger.info("Scrolling finished.")
    
        soup = BeautifulSoup(driver.page_source, "html.parser")
        table = soup.find('table', {'class': 'cmc-table'})
        
        if not table:
            logger.error(f"Table not found on Page {page_number}")
            return []

        rows = table.find_all('tr')
        logger.info(f"Found {len(rows)-1} rows (excluding header)")
        
        page_data = []

        for row in rows[1:]: 
            cols = row.find_all('td')
            if len(cols) >= 10:
                try:
                    rank = cols[1].text.strip()
                    name = cols[2].text.strip()
                    price = cols[3].text.strip()
                    one_hour_change = cols[4].text.strip()
                    twenty_four_hour_change = cols[5].text.strip()
                    seven_day_change = cols[6].text.strip()
                    market_cap = cols[7].text.strip()
                    hr_volume = cols[8].text.strip()
                    circulating_supply = cols[9].text.strip()

            
                    page_data.append((
                        rank, name, price, one_hour_change,
                        twenty_four_hour_change, seven_day_change,
                        market_cap, hr_volume, circulating_supply
                    ))
                except Exception as e:
                    logger.warning(f"Error parsing row: {e}")
                    continue
                    
        return page_data

    except Exception as e:
        logger.critical(f"Error on Page {page_number}: {e}")
        return []