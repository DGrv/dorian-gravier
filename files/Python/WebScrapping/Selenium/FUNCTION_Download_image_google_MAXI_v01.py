# def fetch_image_urls(query:str, max_links_to_fetch:int, wd:webdriver, sleep_between_interactions:int=1):
    # def scroll_to_end(wd):
        # wd.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        # time.sleep(sleep_between_interactions)    
    # # build the google query
    # search_url = "https://www.google.com/search?safe=off&site=&tbm=isch&source=hp&q={q}&oq={q}&gs_l=img"
    # # load the page
    # wd.get(search_url.format(q=query))
    # image_urls = set()
    # image_count = 0
    # results_start = 0
    # while image_count < max_links_to_fetch:
        # scroll_to_end(wd)
        # # get all image thumbnail results
        # thumbnail_results = wd.find_elements(by=By.CSS_SELECTOR, value="img.Q4LuWd")
        # number_results = len(thumbnail_results)
        # print(f"Found: {number_results} search results. Extracting links from {results_start}:{number_results}")
        # for img in thumbnail_results[results_start:number_results]:
            # # try to click every thumbnail such that we can get the real image behind it
            # try:
                # img.click()
                # time.sleep(sleep_between_interactions)
            # except Exception:
                # continue
            # # extract image urls    
            # actual_images = wd.find_elements(by=By.CSS_SELECTOR, value='img.n3VNCb')
            # for actual_image in actual_images:
                # if actual_image.get_attribute('src') and 'http' in actual_image.get_attribute('src'):
                    # image_urls.add(actual_image.get_attribute('src'))
            # image_count = len(image_urls)
            # if len(image_urls) >= max_links_to_fetch:
                # print(f"Found: {len(image_urls)} image links, done!")
                # break
        # else:
            # print("Found:", len(image_urls), "image links, looking for more ...")
            # time.sleep(30)
            # return
            # load_more_button = wd.find_element_by_css_selector(".mye4qd")
            # if load_more_button:
                # wd.execute_script("document.querySelector('.mye4qd').click();")
        # # move the result startpoint further down
        # results_start = len(thumbnail_results)
    # return image_urls


# fetch_image_urls("test", 5, wd)

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



 

def downloadimages(query:str, ean:str, max_links_to_fetch:int, wd:webdriver, folder_path:str, sleep_between_interactions:int=1):
    def scroll_to_end(wd):
        wd.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(sleep_between_interactions)    
    # build the google query
    search_url = "https://www.google.com/search?safe=off&site=&tbm=isch&source=hp&q={q}&oq={q}&gs_l=img"
    # load the page
    wd.get(search_url.format(q=query))
    image_urls = set()
    image_count = 0
    results_start = 0
    while image_count < max_links_to_fetch:
        scroll_to_end(wd)
        # get all image thumbnail results
        thumbnail_results = wd.find_elements(by=By.CSS_SELECTOR, value="img.Q4LuWd")
        number_results = len(thumbnail_results)
        print(f"Found: {number_results} search results. Extracting links from {results_start}:{number_results}")
        
        # folder_path = os.path.join(folder_path, query)
        if os.path.exists(folder_path):
            print(f"path exists")
        else:
            os.mkdir(folder_path)
        
        image_id = 0
        
        for img in thumbnail_results[results_start:number_results]:
            # try to click every thumbnail such that we can get the real image behind it
            try:
                img.click()
                time.sleep(sleep_between_interactions)
            except Exception:
                continue
            # extract image urls    
            actual_images = wd.find_elements(by=By.CSS_SELECTOR, value='img.n3VNCb')
            image_id += 1
            
            for actual_image in actual_images:
                if actual_image.get_attribute('src') and 'http' in actual_image.get_attribute('src'):
                    url = actual_image.get_attribute('src')
                    image_urls.add(url)
                    try:
                        image_content = requests.get(url).content
                    except Exception as e:
                        print(f"ERROR - Could not download {url} - {e}")
                    try:
                        image_file = io.BytesIO(image_content)
                        image = Image.open(image_file).convert('RGB')
                        file_path = os.path.join(folder_path, ean + '___' + str(image_id) + '.jpg')
                        print(f"file_path {file_path}")
                        # if os.path.exists(folder_path):
                            # file_path = os.path.join(folder_path,hashlib.sha1(image_content).hexdigest()[:10] + '.jpg')
                        # else:
                            # os.mkdir(folder_path)
                            # file_path = os.path.join(folder_path,hashlib.sha1(image_content).hexdigest()[:10] + '.jpg')
                        with open(file_path, 'wb') as f:
                            image.save(f, "JPEG", quality=85)
                        print(f"SUCCESS - saved {url} - as {file_path}")
                    except Exception as e:
                        print(f"ERROR - Could not save {url} - {e}")
            image_count = len(image_urls)
            if len(image_urls) >= max_links_to_fetch:
                print(f"Found: {len(image_urls)} image links, done!")
                break
        else:
            print("Found:", len(image_urls), "image links, looking for more ...")
            time.sleep(30)
            return
            load_more_button = wd.find_element_by_css_selector(".mye4qd")
            if load_more_button:
                wd.execute_script("document.querySelector('.mye4qd').click();")
        # move the result startpoint further down
        results_start = len(thumbnail_results)
    return image_urls
