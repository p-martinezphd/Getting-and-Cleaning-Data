##https://biostat.app.vumc.org/wiki/Main/RMySQL
##Connecting to MySQL database

#install.packages('RMySQL',type='source') 
#install.packages('DBI')

library('RMySQL')

##Add to PowerShell
##Add-Content C:/PROGRA~1/R/R-4.1.0/etc/.Renviron "MYSQL_HOME=C:/PROGRA~1/MySQL/MYSQLS~8.0/"


##Check for file 
Sys.getenv('MYSQL_HOME') 

#R Directory
R.home() 

#Connecting and listing databases
ucscDb <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);
result



hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                    host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

dbListFields(hg19,"affyU133Plus2")

#How many rows in all dataset
dbGetQuery(hg19,"select count(*) from affyU133Plus2")


dbGetQuery(hg19,"select * from affyU133Plus2
                 limit 10")

#Extract data into R
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)

#ALWAYS DISCONNECT FROM DATASET
dbDisconnect(hg19)
