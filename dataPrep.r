library(plyr)

gDatPath <- 'data/clean_globalterrorismdb_1012dist.tsv'
gDat <- read.table(gDatPath, 
                   sep='\t',
                   quote="\"",
                   header=TRUE,
                   na.strings=c('','.','Unknown'))

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





evnCntByGroup <- ddply(subset(gDat, !is.na(gname)),
                       ~gname, count_totals)
write.table(evnCntByGroup, "result/groupDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)

top <- seq(1:5)
dangerGrps <- arrange(evnCntByGroup, totalEvents, decreasing=TRUE)[top,]$gname
dangerGrpDat <- droplevels(subset(gDat, gname %in% dangerGrps))

pEveCntByGrp <- ggplot(evnCntByGroup, aes(x=totalEvents))
pEveCntByGrp + geom_bar(binwidth=0.3) + scale_x_log10(breaks=c(1, 10, 100, 1000))

groupAnnualDat <- ddply(dangerGrpDat, ~gname+iyear, count_totals, .drop=FALSE)
write.table(groupAnnualDat, "result/groupAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)

pGroup <- ggplot(subset(gDat, gname %in% dangerGrps), 
                 aes(x=gname, y=iyear, fill=gname))
pGroup + geom_violin(scale='count') + 
  coord_flip()
iGroupAnnual <- droplevels(subset(groupAnnualDat, gname %in% dangerGrps))
write.table(iGroupAnnual, "result/TopDangerGroupAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)

pGroupEvent <- ggplot(iGroupAnnual, aes(x=iyear, y=totalKilled, fill=gname, color=gname))
pGroupEvent + geom_histogram(stat='identity', alpha=0.3, color=NA) +
  geom_path()
#labs(x = "City mpg", y = "Highway", colour = "Displacement")

# pGroupEvent2 <- ggplot(subset(groupAnnualDat, gname %in% dangerGrps), aes(x=iyear, weight=totalKilled, fill=gname))
# pGroupEvent2 + geom_histogram() + geom_density(adjust=0.2, fill=NA)


iGroupAnnual <- subset(groupAnnualDat, gname %in% dangerGrps)
write.table(iGroupAnnual, "result/TopDangerGroupAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)
