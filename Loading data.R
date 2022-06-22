getwd()

fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,"~/getdata_data_ss06hid.csv")

acs2006 <- read.csv("~/getdata_data_ss06hid.csv")

head(acs2006)

#How many properties are worth $1,000,000 or more?
sum(na.omit(acs2006$VAL) == 24)



#Q3
#Natural Gas Aquisition Program 

fileUrl2 <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl2,"~/getdata_data_DATA.gov_NGAP.xlsx", mode='wb')
#HAD TO INSTALL JAVA
#https://www.java.com/en/download/manual.jsp

#install.packages('xlsx')
library('xlsx')
NGAP <- read.xlsx("~/getdata_data_DATA.gov_NGAP.xlsx", sheetIndex=1,header=TRUE)

head(NGAP)


colIndex<- 7:15
rowIndex<- 18:23
dat <- read.xlsx("~/getdata_data_DATA.gov_NGAP.xlsx", sheetIndex=1,header=TRUE
                 ,colIndex = colIndex,rowIndex = rowIndex)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)


#Q4 Read the XML data

#install.packages('XML')
library(XML)
#remove s from https to make XML work
fileUrl3 <-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl3,useInternalNodes = TRUE)
rootNode <- xmlRoot (doc)
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)


#Q5
install.packages('data.table')

library ('data.table')
DT <- fread("~/getdata_data_ss06hid.csv")
file.info("~/getdata_data_ss06hid.csv")$size
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2])
