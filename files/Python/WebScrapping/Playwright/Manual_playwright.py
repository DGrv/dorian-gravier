import scrapy
from scrapy.selector import Selector
from playwright.sync_api import sync_playwright
pw = sync_playwright().start()
brower = pw.chromium. launch(headless=False)
context = brower.new_context()
page = context.new_page()
# page.goto( 'https://www.thecrag.com/CIDS/cgi-bin/cids.cgi?utm_source=thecrag&throttled=1&return=%2Fde%2Fklettern%2Fworld&utm_campaign=ServerLoad&utm_medium=popup&utm_id=anonsession&D%3AThrottled=1&C%3AHideNavigation=1&D%3ALoginTarget=%2Fde%2Fklettern%2Fworld&C%3AState=13216' )
page.goto( 'https://www.thecrag.com/en/climbing/switzerland/processmap/login?return=/en/climbing/switzerland/processmap/login?return=/en/climbing/switzerland/processmap/login?return=/en/climbing/switzerland/processmap/login?return=/en/climbing/switzerland/goscheneralptal/area/1400407503&throttled=1&utm_source=thecrag&utm_medium=popup&utm_campaign=ServerLoad&utm_id=anonsession&throttled=1&utm_source=thecrag&utm_medium=popup&utm_campaign=ServerLoad&utm_id=anonsession&throttled=1&utm_source=thecrag&utm_medium=popup&utm_campaign=ServerLoad&utm_id=anonsession&throttled=1&utm_source=thecrag&utm_medium=popup&utm_campaign=ServerLoad&utm_id=anonsession' )
response2 = page.content()
response2 = Selector(text=str(response2))

page.get_by_placeholder("Username").fill('les4kins')
page.get_by_placeholder("Password").fill('&h7kuv&3yxXP4e*3')
page.get_by_role("button", name="Login").click()

js-lazy-img.fill

loc = page.locator('#s-top-left > a:nth-child(7)')
loc.click()
len(context.pages)
context.new_page()
len(context.pages)
