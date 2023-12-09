from typing import Any, Optional
import scrapy


class BooksSpider(scrapy.Spider):
    name = "books"
    allowed_domains = ["books.toscrape.com"]
    start_urls = ["https://books.toscrape.com/"]
         

    def parse(self, response):
        
        for row in response.css("ol.row > li > article.product_pod"):
            title = row.css("h3 > a::attr(title)").get()
            price = row.css("div.product_price > p.price_color::text").get()
            yield {"title": title, "price": price}

