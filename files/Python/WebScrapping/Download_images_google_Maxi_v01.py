from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import time
import requests
import os
from PIL import Image
import io
import hashlib
 
from FUNCTION_Download_image_google_MAXI_v01 import downloadimages


# source 
# https://medium.com/@wwwanandsuresh/web-scraping-images-from-google-9084545808a2
# https://towardsdatascience.com/image-scraping-with-python-a96feda8af2d

# What you enter here will be searched for in
# Google Images
 
DRIVER_PATH = 'C:/Users/doria/Downloads/chromedriver_win32/chromedriver.exe'
service = Service(DRIVER_PATH)
service.start()
wd = webdriver.Remote(service.service_url)
# Maximize the screen
wd.maximize_window()
# Open Google Images in the browser
wd.get('https://images.google.com/')
# click on accept
wd.find_element(by=By.XPATH, value='//*[@id="L2AGLb"]/div').click()
# Finding the search box
box = wd.find_element(by=By.XPATH, value='//*[@id="sbtc"]/div/div[2]/input')
# Pressing enter
box.send_keys(Keys.ENTER)




downloadimages('DMM - Dragon Cam - Silver - 0', '5031290209960', 2, wd,  'c:/users/doria/downloads/maxi_bilder/DMM')
downloadimages('DMM - 8mm Dynatec Sling - Gold - 60cm', '5031290215510', 2, wd,  'c:/users/doria/downloads/maxi_bilder/DMM')





# Finally, we close the driver
wd.close()