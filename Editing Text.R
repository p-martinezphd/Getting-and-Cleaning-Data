#fixing character vectors - strsplit

splitNames = strsplit(namesvariable(data),"\\.")

##Apply strsplit() to split all the names of the data frame on 
##the characters "wgtp". What is the value of the 123 element of the resulting list?
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- file.path(getwd(), "ss06hid.csv")
download.file(url, file, method = "curl")
dt <- data.table(read.csv(file))
varNames <- names(dt)
varNamesSplit <- strsplit(varNames, "wgtp")
varNamesSplit[[123]]


##Remove the from the GDP numbers in millions of dollars
##and average them. What is the average?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file <- file.path(getwd(), "GDP.csv")
download.file(url, file, method = "curl")
dtGDP <- data.table(read.csv(file, skip = 4, nrows = 215, stringsAsFactors = FALSE))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))
mean(gdp, na.rm = TRUE)

##In the data set from Question 2 what is a regular expression
##that would allow you to count the number of countries whose name
##begins with "United"? Assume that the variable with the country names
##in it is named countryNames. How many countries begin with United?

isUnited <- grepl("^United", dtGDP$Long.Name)
summary(isUnited)


##Match the data based on the country shortcode. 
##Of the countries for which the end of the fiscal year is available, 
##how many end in June?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, file, method = "curl")
dtEd <- data.table(read.csv(file))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)


##Use the following code to download data on Amazon's stock price 
##and get the times the data was sampled.
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 



amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn) 
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
