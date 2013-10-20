library(plyr)

gDatPath <- 'data/clean_globalterrorismdb_1012dist.tsv'
gDat <- read.table(gDatPath, 
                   sep='\t',
                   quote="\"",
                   header=TRUE,
                   na.strings=c('','.'))


# selected <- rawDat[c("eventid", "iyear", 
#                      "country_txt", "region_txt", "latitude", "longitude", "summary", 
#                      "crit1", "crit2", "crit3", "doubtterr", "alternative_txt", 
#                      "success","suicide", "attacktype1_txt", "targtype1_txt", "natlty1_txt", "gname", "weaptype1_txt", 
#                      "nkill", "nkillter", "nwound", "nwoundus", "nwoundte", "propvalue", 
#                      "ishostkid", "nhostkid", "nhours","ndays","ransom", "ransomamt", "ransompaid", "hostkidoutcome_txt", "nreleased")]

count_totals <- function(xDat, ...){
  result <- summarize(xDat,
                      totalEvents=length(eventid),
                      totalKilled=sum(nkill, na.rm=TRUE),
                      totalWounded=sum(nwound, na.rm=TRUE),
                      ...
  )  
  return(result)
}

countryToRegion <- ddply(gDat, ~country_txt+region_txt,
                         function(xDat){
                           cTor <- xDat[1,][c('country_txt', 'region_txt')]
                           return(cTor)
                         })

countryAnnualDat <- ddply(gDat, ~country_txt+iyear, count_totals, .drop=FALSE)
matched <- match(countryAnnualDat$country_txt, countryToRegion$country_txt)
a <- countryToRegion[matched,]
b <- merge(countryAnnualDat, countryToRegion, by='country_txt')
                          

countryDat <- ddply(gDat, ~country_txt, count_totals, .drop=FALSE)

dangerCountries <- arrange(countryDat, totalKilled, decreasing=TRUE)




library(ggplot2)
p <- ggplot(subset(rawDat, region_txt=="Middle East & North Africa"), 
            aes(x=country_txt, y=iyear))

#p + #geom_violin(alpha=0.3) + coord_flip()
