#if (!require("BiocManager", quietly = TRUE))
 # install.packages("BiocManager")
#BiocManager::install(version = "3.15")

#BiocManager::available()

#BiocManager::install(c("rhdf5"))

library(rhdf5)
created = h5createFile("example.h5")
created

created=h5createGroup("example.h5","foo")
created=h5createGroup("example.h5","baa")
created=h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

#read to R
df= data.frame(1L:5L,seq(0,1,length.out=5),
               c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

readdf= h5read("example.h5","df")
readdf

