
###########This is a script to clean up URLS removing prefixes and subdomains.
whitelistloc<-"C:/Users/jwarren/Documents/iMacros/Downloads/NB_aldo_whitelist.csv"
library("stringr")

## load the CSV
whitelist<-as.data.frame(read.table(whitelistloc, sep=",", quote="\"", header=FALSE, strip.white=TRUE, fill=TRUE,stringsAsFactors=FALSE));

##pivot the data from a few columns to a single column
unlisted<-as.data.frame(unlist(whitelist))
##name our new column
names(unlisted)[1]<-"URLs"
# remove HTTP and www
tempURL<-gsub("Http://", "", unlisted$URLs, ignore.case = TRUE)
tempURL<-gsub("Https://", "", tempURL, ignore.case = TRUE)
tempURL<-gsub("www.", "", tempURL, ignore.case = TRUE)
#parse out  spaces or /
tempURL<-str_split_fixed(tempURL, " ", 2)[,1]
tempURL<-str_split_fixed(tempURL, "/", 2)[,1]
tempURL<-unique(tolower(tempURL))


write.table(tempURL, file=whitelistloc, sep=',', row.names=FALSE, quote=FALSE, col.names = TRUE)


