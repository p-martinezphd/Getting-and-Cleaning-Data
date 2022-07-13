con= url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

#XML Format
library(XML)
library(RCurl)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
xData <- getURL(url)
html <- htmlTreeParse(xData, useInternalNodes =T)
xpathSApply(html,"//title",xmlValue)


#HTTR
library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2,asText = TRUE)
xpathApply(parsedHtml,"//title", xmlValue)

#Accessing websites with passwords
pg2= GET("http://httpbin.org/basic-auth/user/passwd",
         authenticate("user","passwd"))
pg2


names(pg2)
