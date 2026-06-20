# conftest.py — Browser Setup for Selenium Tests
# MCA Result Management System
 
import pytest
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
 
@pytest.fixture
def driver():
    service = Service(ChromeDriverManager().install())
 
    options = Options()
    options.add_argument("--start-maximized")
 
    driver = webdriver.Chrome(service=service, options=options)
    driver.implicitly_wait(5)
 
    yield driver
 
    driver.quit()