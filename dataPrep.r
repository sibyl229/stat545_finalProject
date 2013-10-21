library(plyr)

gDatPath <- 'data/clean_globalterrorismdb_1012dist.tsv'
gDat <- read.table(gDatPath, 
                   sep='\t',
                   quote="\"",
                   header=TRUE,
                   na.strings=c('','.','Unknown'))


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
                      foreignTarget=sum(as.character(country_txt) != as.character(natlty1_txt), na.rm=TRUE),
                      ratioForeignTarget=foreignTarget/totalEvents,
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
# matched <- match(countryAnnualDat$country_txt, countryToRegion$country_txt)
# a <- countryToRegion[matched,]
countryAnnualDat <- merge(countryAnnualDat, countryToRegion, by='country_txt')
write.table(countryAnnualDat, "result/countryAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)
                          

countryDat <- ddply(gDat, ~country_txt, count_totals, .drop=FALSE)
countryDat <- merge(countryDat, countryToRegion, by='country_txt')
#countryDat$
write.table(countryDat, "result/countryDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)

#dangerCountries <- arrange(countryDat, totalKilled, decreasing=TRUE)


pEventKilled <- ggplot(countryDat,
                       aes(x=totalEvents, y=totalKilled, color=region_txt))
pEventKilled + geom_point() +
  scale_x_log10() + scale_y_log10() 

highLight <- function(x, labels){
  newx <- c()
  highlighted <- x %in% labels
  newx[highlighted] <- as.character(x)[highlighted]
  newx[!highlighted] <- 'Others'
  newx <- factor(newx, levels=c(labels, 'Others'))
  return(newx)
}

iRegions <- c('Central Asia', 'South Asia', 'South America', 
              'Middle East & North Africa')
pEventTrend <- ggplot(countryAnnualDat,
                       aes(x=iyear, y=totalEvents, size=totalKilled, 
                           color=highLight(region_txt, iRegions)))
pEventTrend + geom_point(alpha=0.3) + scale_size_area(max_size=10) + 
  facet_wrap(~ region_txt) +
  geom_smooth(method='loess') 


pEventTrend2 <- ggplot(subset(countryAnnualDat, region_txt=='Middle East & North Africa'),
                      aes(x=iyear, y=totalEvents, size=totalKilled, 
                          color=country_txt))
pEventTrend2 + geom_point(alpha=0.3) + scale_size_area(max_size=10) + 
  geom_smooth(method='loess') 


evnCntByGroup <- ddply(subset(gDat, !is.na(gname)),
                       ~gname, count_totals)

top <- seq(1:5)
dangerGrps <- arrange(evnCntByGroup, totalEvents, decreasing=TRUE)[top,]$gname

pEveCntByGrp <- ggplot(evnCntByGroup, aes(x=totalEvents))
pEveCntByGrp + geom_bar(binwidth=0.3) + scale_x_log10(breaks=c(1, 10, 100, 1000))

groupAnnualDat <- ddply(subset(gDat, gname %in% dangerGrps), ~gname+iyear, count_totals, .drop=FALSE)
write.table(groupAnnualDat, "result/groupAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)

pGroup <- ggplot(subset(gDat, gname %in% dangerGrps), 
                 aes(x=gname, y=iyear, fill=gname))
pGroup + geom_violin(scale='count') + 
  coord_flip()
iGroupAnnual <- subset(groupAnnualDat, gname %in% dangerGrps)
pGroupEvent <- ggplot(iGroupAnnual, aes(x=iyear, y=totalKilled, fill=gname, color=gname))
pGroupEvent + geom_histogram(stat='identity', alpha=0.3, color=NA) +
  geom_path()
#labs(x = "City mpg", y = "Highway", colour = "Displacement")

# pGroupEvent2 <- ggplot(subset(groupAnnualDat, gname %in% dangerGrps), aes(x=iyear, weight=totalKilled, fill=gname))
# pGroupEvent2 + geom_histogram() + geom_density(adjust=0.2, fill=NA)



countryDat <- ddply(gDat, ~country_txt, count_totals, .drop=FALSE)
countryDat <- merge(countryDat, countryToRegion, by='country_txt')
write.table(countryDat, "result/countryDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)
