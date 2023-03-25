set when=202303
scrapy crawl extract -o Spain_%when%.csv -a country=spain
scrapy crawl extract -o Portugal_%when%.csv -a country=portugal
scrapy crawl extract -o France_%when%.csv -a country=france
scrapy crawl extract -o Germany_%when%.csv -a country=germany
