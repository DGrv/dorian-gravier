# importing the scrapy module
import scrapy
  
class ExtractUrls(scrapy.Spider):
    name = "extract"
    # custom_settings = {
        # 'FEED_EXPORT_BATCH_ITEM_COUNT': 10
    # }
    
    # request function
    def start_requests(self):
        urls = [ 'https://www.thecrag.com/de/klettern/' + self.country]
        
        # scrapy shell https://www.thecrag.com/de/klettern/france/alsace-lorraine/area/881031801
          
        for url in urls:
            yield scrapy.Request(url = url, callback = self.parse)
  
    # Parse function
    def parse(self, response):
        
        # Extra feature to get title
        title = response.css('title::text').extract_first() 
        
        # Get anchor tags
        links = response.css('a::attr(href)').extract()     
        # the links list is local links so I have to add the domain for each element in the list
        links[:] = ['https://www.thecrag.com' + e for e in links if 'http' not in e]
        
        # use scrapy crawl extract -o youroutput.csv -a country=spain
        ok = [self.country]
        notok = ['route', 'ascent', 'forum', 'guide', 'weather', 'accomodation', 'publication', 'contributors', 'discussions', 'nodes', 'climbers', 'photos', 'list', 'search', 'topos', 'favorites', 'map', 'webcover']
        
        for link in links:
            
            if all(x in link for x in ok):    
                    if 'gpx' in link:
                        yield {
                            'title': title,
                            'links': link
                        }
                    if all(x not in link for x in notok):
                        yield scrapy.Request(url = link, callback = self.parse)
                    
                    

