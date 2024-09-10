
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')


library(httr)
library(rvest)
library(chromote)

wd <- rP("file:///C:/Users/doria/Downloads/mloader_downloads")

url <- "https://mangaplus.shueisha.co.jp/titles/100020"
# url <- "https://www.google.com"
session <-  session(url)
# form <- html_form(session)[[2]]
# fl_fm <- html_form_set(form,
#                        "D:Login" = "les4kins",
#                        "D:Password" = "&h7kuv&3yxXP4e*3")
# main_page <- session_submit(session, fl_fm)
stringi::stri_encode(session$response$content)

session %>% html_elements("")



Sys.setenv(CHROMOTE_CHROME = "C:/Users/doria/scoop/apps/googlechrome/current/chrome.exe")

b <- ChromoteSession$new()
# b$view()
{
  b$Page$navigate(url)
  b$Page$loadEventFired()
}

#source : https://stackoverflow.com/questions/76346671/from-chromote-to-rvest


links <- b$Runtime$evaluate("document.querySelector('html').outerHTML")$result$value %>% 
  read_html() %>% 
  html_elements("a") 
b$close()

data <- data.table()
links2 <- links %>% html_attr('href') 
data[, links := links2]
data <- data[links %like% "comments"]

