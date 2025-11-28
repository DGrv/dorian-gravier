# importing the scrapy module
import scrapy
from scrapy.http import HtmlResponse
import json
import time
import requests
import os
from PIL import Image
import io
import hashlib
import re

from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings
from scrapy.settings import Settings

# # scrapy-selenium
# from shutil import which
# from scrapy_selenium import SeleniumRequest
# from selenium.webdriver.common.by import By
# from selenium.webdriver.support import expected_conditions as EC

# # Splash
from scrapy_splash import SplashRequest 
from shutil import which

# RUN CMD               docker run -p 8050:8050 scrapinghub/splash
# check if running      http://localhost:8050/    

# scrapy shell http://localhost:8050/render.html?url=https://www.th3cr4g.com/de/klettern/spain/area/4679626191
# fetch('http://localhost:8050/render.html?url=https://www.dynafit.com/de-de/expedition-30-rucksack-08-0000048953?c=318560')
# fetch("https://www.th3cr4g.com/de/klettern/spain", meta = {'dont_redirect': True, 'handle_httpstatus_list': [302], 'handle_httpstatus_list': [301]})


# # seleniumoptions = Options()
# import selenium
# from selenium import webdriver
# from selenium.webdriver.common.keys import Keys
# from selenium.webdriver.chrome.service import Service
# from selenium.webdriver.common.by import By
# from selenium.webdriver.chrome.options import Options
# from selenium.webdriver.support.ui import WebDriverWait
# DRIVER_PATH = 'L:/Diverses/Software/chromedriver_win32/chromedriver.exe'
# options.add_argument("--headless")
# driver = webdriver.Chrome(executable_path=DRIVER_PATH, options=options)

nsuccess = 0
def printsuccess():
    nsuccess = nsuccess + 1 
    print("\x1b[1;0;32m-----------------------------------------------------------------------------------------------------------------------------------------")
    print("\x1b[1;0;32m-----------------------------------------------------------------------------------------------------------------------------------------")
    print("\x1b[1;0;32m------------------------------------------------------------- Found link ----------------------------------------------------------------")
    print("\x1b[1;0;32m------------------------------------------------------------- Found link ----------------------------------------------------------------")
    print("\x1b[1;0;32m------------------------------------------------------------- " + nsuccess + " ----------------------------------------------------------------")
    print("\x1b[1;0;32m------------------------------------------------------------- Found link ----------------------------------------------------------------")
    print("\x1b[1;0;32m------------------------------------------------------------- Found link ----------------------------------------------------------------")
    print("\x1b[1;0;32m-----------------------------------------------------------------------------------------------------------------------------------------")
    print("\x1b[1;0;32m-----------------------------------------------------------------------------------------------------------------------------------------")
    print("\x1b[1;0;32m-----------------------------------------------------------------------------------------------------------------------------------------")




class ExtractUrls(scrapy.Spider):
    name = "extract"
    max_retries = 2
    custom_settings = {
        'ROBOTSTXT_OBEY' : False,
        'LOG_FORMAT' : '\x1b[0;0;34m%(asctime)s\x1b[0;0m \x1b[0;0;36m[%(name)s]\x1b[0;0m \x1b[0;0;31m%(levelname)s\x1b[0;0m: %(message)s',

        # # test th3cr4g
        # 'HTTPCACHE_IGNORE_HTTP_CODES': [301,302],
        # 'HTTPCACHE_ENABLED': False,
        # 'REDIRECT_ENABLED': False,
        
        
        # # Splash
        'SPLASH_URL' : 'http://localhost:8050/',
        'DOWNLOADER_MIDDLEWARES' : { 
        'scrapy_splash.SplashCookiesMiddleware': 723, 
        'scrapy_splash.SplashMiddleware': 725, 
        'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware': 810, 
        },
        'SPIDER_MIDDLEWARES' : { 
        'scrapy_splash.SplashDeduplicateArgsMiddleware': 100, 
        },
        'DUPEFILTER_CLASS' : 'scrapy_splash.SplashAwareDupeFilter' ,
        'HTTPCACHE_STORAGE' : 'scrapy_splash.SplashAwareFSCacheStorage',


        # # scrapy-selenium
        # 'SELENIUM_DRIVER_NAME' : 'chrome',
        # 'SELENIUM_DRIVER_EXECUTABLE_PATH' : which('chromedriver'),
        # 'SELENIUM_DRIVER_ARGUMENTS' : ['-headless'],  # '--headless' if using chrome instead of firefox
        # 'SELENIUM_BROWSER_EXECUTABLE_PATH' : 'L:/Diverses/Software/chromedriver_win32/chromedriver.exe',
        # 'DOWNLOADER_MIDDLEWARES' : {
            # 'scrapy_selenium.SeleniumMiddleware': 800
        # }
    }
    idloop = 0
    
    # from https://stackoverflow.com/questions/22795416/how-to-handle-302-redirect-in-scrapy
    # def __init__(self, *args, **kwargs):
        # super().__init__(*args, **kwargs)
        # self.retries = {}
    
    # request function
    def start_requests(self):
        urls = [ 'https://www.th3cr4g.com/de/klettern/' + self.country]
        for url in urls:
            # yield scrapy.Request(url = url, callback = self.parse)
            # yield scrapy.Request(url = url, meta = {'dont_redirect': True, 'handle_httpstatus_list': [302]}, callback = self.parse)
            # yield SeleniumRequest(url = url, callback = self.parse)
            yield SplashRequest(url, self.parse, 
                endpoint='render.html',
                args={'wait': 0.5}, 
            ) 
            
            
    # Parse function
    def parse(self, response):
        
        # from https://stackoverflow.com/questions/22795416/how-to-handle-302-redirect-in-scrapy
        if response.status == 302:
            retries = self.retries.setdefault(response.url, 0)
            if retries < self.max_retries:
                self.retries[response.url] += 1
                yield response.request.replace(dont_filter=True)
            else:
                self.logger.error('%s still returns 302 responses after %s retries',
                                  response.url, retries)
            return
        
        
        current_url = response.request.url
        
        # options = Options()
        # DRIVER_PATH = 'L:/Diverses/Software/chromedriver_win32/chromedriver.exe'
        # options.add_argument("--headless")
        # driver = webdriver.Chrome(executable_path=DRIVER_PATH, options=options)
        # driver.get(current_url)
        # time.sleep(2)
        # # driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        # # time.sleep(3)
        # response = HtmlResponse(url="my HTML string", body=driver.page_source.encode('utf-8'), encoding='utf-8')
        # driver.quit()
        
        
        # Extra feature to get title
        title = response.css('title::text').extract_first() 
        
        # Get anchor tags
        links = response.css('a::attr(href)').extract()     
        # the links list is local links so I have to add the domain for each element in the list
        links[:] = ['https://www.th3cr4g.com' + e for e in links if 'http' not in e]
        
        # use scrapy crawl extract -o youroutput.csv -a country=spain
        notok = ['route', 'ascent', 'forum', 'guide', 'weather', 'accommodation', 'publication', 'contributors', 'discussions', 'nodes', 'climbers', 'photos', 'list', 'search', 'topos', 'favorites', 'map', 'webcover', 'sandpit', 'article', 'kml']
        ok = [self.country]
        
            
        for link in links:
            # print("link: " + link)
            if all(x in link for x in ok):    
                if 'gpx' in link:
                    print("\x1b[1;0;32m-------- found gpx ----------")
                    where = response.css('span[class="crumb__long"]::text').extract()
                    where = '|'.join(where[2:len(where)])
                    printsuccess()
                    yield {
                        'title': title,
                        'links': link,
                        'where': where
                    }
                if all(x not in link for x in notok):
                    # yield scrapy.Request(url = link, callback = self.parse)
                    # # If you have redirect 302:
                    # # 2023-03-21 18:10:55 [scrapy.downloadermiddlewares.redirect] DEBUG: Redirecting (302) to <GET https://sandpit.th3cr4g.com/e8a/redirect.py?redir=processmap/login?return=%2Fde%2Fklettern%2Fspain%2Farea%2F4679626191> from <GET https://www.th3cr4g.com/de/klettern/spain/area/4679626191>
                    # # use this (from https://stackoverflow.com/questions/22795416/how-to-handle-302-redirect-in-scrapy)
                    # yield scrapy.Request(url = link, meta = {'dont_redirect': True, 'handle_httpstatus_list': [302]}, callback=self.parse)
                    # yield SeleniumRequest(url = link, callback = self.parse)
                    yield SplashRequest(link, self.parse, 
                        endpoint='render.html',
                        args={'wait': 0.5}, 
                    ) 



# fetch("https://www.th3cr4g.com/de/klettern/spain", meta = {'dont_redirect': True, 'handle_httpstatus_list': [302], 'handle_httpstatus_list': [301]})


# test = ["spain"]
# for link in links:
    # if all(x in link for x in test):    
        # if 'gpx' in link:
            # print("gpx -----" + link)
        # if all(x not in link for x in notok):
            # print("continue -----" + link)


