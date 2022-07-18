#subsetting 
library(RMySQL)
library(DBI)
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <-X[sample(1:5),]; X$var2[c(1,3)] = NA
X


#SUBSET A VAR VS A SECTION IN A VAR
X[,"var1"]
X[1:2,"var2"]


#Logicals ands and Ors
X[(X$var1 <= 3 & X$var3 > 11),] # | for or statement

#dealing with missing values

#with nas
X[(X$var2 > 8),]

#no nas
X[which(X$var2 > 8),]


#sorting
sort(X$var1,decreasing = TRUE)
sort(X$var2,na.last = TRUE)

#Ordering-reorder rows
X<-X[order(X$var1,X$var3),]

#Adding rows and columns/ var
X$var4 <- rnorm(5)
X

#ADDING TWO VARS
X$var5 <- X$var1 + X$var3
X

#same code, SUPER IMPORTANT ALTHOUGH CODE LOOKS LONGER IT IS MORE USEFUL
#FOR REAL DATASETS, THIS WILL IGNORE MISSING
X$var6 <- rowSums(cbind(X$var1,X$var2),na.rm=TRUE)
X

X$var7 <- colSums(cbind(X$var2),na.rm=TRUE)
X

#WHEN DOING A combination make sure both data vars are the same data type
data$co#Types of vars
str(X)
l1 <- as.numeric(data$col1)
data$col2 <- as.numeric(data$col2)


#summarizing data
head(X, n=3)
tail(X, n=3)

summary(X)

#cross tabs
table(X$var1,X$var4)

#specific attributes
table(X$var1 %in% c(1,2))
table(X$var1 %in% c(1,3))


xt <- xtabs( ~ var1 + var2, data=X)
xt

xta
#view of specific data rows
X[X$var1 %in% c(1),]

#Checking for missing values
sum(is.na(X$var2))

colSums(is.na(X))

#Number of rows in dataset
nrow(X)

#install.packages("reshape2")
library(reshape2)
head(mtcars)


mtcars$carname <- rownames(mtcars)
carsmelt <- melt(mtcars, id=c("carname", "gear", "cyl")
                 ,measure.vars= c("mpg","hp"),na.rm=TRUE)
head(carsmelt)

#counts
cylData<- dcast(carsmelt, cyl ~ variable)
cylData

#mean
cylData<- dcast(carsmelt, cyl ~ variable, mean)
cylData

#sum
cylData<- dcast(carsmelt, cyl ~ variable, sum)
cylData


head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)


#same as sum above but different package
library(plyr)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

#new variable with the sum
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
#same dimensions as the dataset but now we have a new variable
dim(spraySums)
head(spraySums)

#ddplyr is fast because is was written in C++


#merging data
mergedData= merge(Xdataset,ydataset,by.x="solution_id",by.y="id",all=TRUE)
head(mergeData)


#quiz
#The American Community Survey distributes downloadable 
#data about United States communities. Download the 2006 
#microdata survey about housing for the state of
#Idaho using download.file() from here: 
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- file.path(getwd(), "ss06hid.csv")
download.file(url, file, method = "curl")
dt <- data.table(read.csv(file))
agricultureLogical <- dt$ACR == 3 & dt$AGS == 6
which(agricultureLogical)[1:3]

#Use the parameter native=TRUE. What are 
#the 30th and 80th quantiles of the resulting data?
#(some Linux systems may produce an answer
#638 different for the 30th quantile)
#install.packages("jpeg")
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
file <- file.path(getwd(), "jeff.jpg")
download.file(url, file, mode = "wb", method = "curl")
img <- readJPEG(file, native = TRUE)
quantile(img, probs = c(0.3, 0.8))


#Match the data based on the country shortcode. 
#How many of the IDs match? Sort the data frame in 
#descending order by GDP rank (so United States is last). 
#What is the 13th country in the resulting data frame?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file <- file.path(getwd(), "GDP.csv")
download.file(url, file, method = "curl")
dtGDP <- data.table(read.csv(file, skip = 4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, file, method = "curl")
dtEd <- data.table(read.csv(file))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))
dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]


#What is the average GDP ranking for the "High income:
#OECD" and "High income: nonOECD" group?
dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]


#Cut the GDP ranking into 5 separate quantile groups. 
#Make a table versus Income.Group. How many countries 
#are Lower middle income but among the 38 nations with highest GDP?
breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]











