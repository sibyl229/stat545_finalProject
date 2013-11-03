library(plyr)

gDatPath <- 'data/clean_globalterrorismdb_1012dist.tsv'
gDat <- read.table(gDatPath, 
                   sep='\t',
                   quote="\"",
                   header=TRUE,
                   na.strings=c('','.','Unknown'))

count_totals <- function(xDat){
  result <- summarize(xDat,
                      totalEvents=length(eventid),
                      totalKilled=sum(nkill, na.rm=TRUE),
                      totalWounded=sum(nwound, na.rm=TRUE),
                      foreignTarget=sum(as.character(country_txt) != as.character(natlty1_txt), na.rm=TRUE),
                      ratioForeignTarget=foreignTarget/totalEvents
  )  
  return(result)
}

countryToRegion <- ddply(gDat, ~country_txt+region_txt,
                         function(xDat){
                           cTor <- xDat[1,][c('country_txt', 'region_txt')]
                           return(cTor)
                         })
## based on country

countryAnnualDat <- ddply(gDat, ~country_txt+iyear, count_totals, .drop=FALSE)
# matched <- match(countryAnnualDat$country_txt, countryToRegion$country_txt)
# a <- countryToRegion[matched,]
countryAnnualDat <- merge(countryAnnualDat, countryToRegion, by='country_txt')
write.table(countryAnnualDat, "result/countryAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)
                          

countryDat <- ddply(gDat, ~country_txt, count_totals, .drop=FALSE)
countryDat <- merge(countryDat, countryToRegion, by='country_txt')
write.table(countryDat, "result/countryDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)

## based on groups

evnCntByGroup <- ddply(subset(gDat, !is.na(gname)),
                       ~gname, count_totals)
write.table(evnCntByGroup, "result/groupDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)


top <- seq(1:6)
dangerGrps <- arrange(evnCntByGroup, totalEvents, decreasing=TRUE)[top,]$gname
dangerGrpDat <- droplevels(subset(gDat, gname %in% dangerGrps))
groupAlias <- data.frame(
  gname=c(
    'Shining Path (SL)',                               
    'Farabundo Marti National Liberation Front (FMLN)',
    'Irish Republican Army (IRA)',
    'Revolutionary Armed Forces of Colombia (FARC)',   
    'Taliban',
    'Basque Fatherland and Freedom (ETA)'), 
  galias=c(
    'SL',
    'FMLN',
    'IRA',
    'FARC',
    'Taliban',
    'ETA'
    )) 
write.table(groupAlias, "result/groupAlias.tsv")
dangerGrpDat <- merge(dangerGrpDat, groupAlias, by='gname')
write.table(dangerGrpDat, "result/TopDangerGroupDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)


dangerGrpAnnual <- ddply(dangerGrpDat, ~gname+iyear, count_totals, .drop=FALSE)
dangerGrpAnnual <- merge(dangerGrpAnnual, groupAlias, by='gname')
write.table(dangerGrpAnnual, "result/TopDangerGroupAnnualDat.tsv", 
            quote = FALSE, sep = "\t", row.names = FALSE)



