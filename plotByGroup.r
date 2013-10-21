library(plyr)
library(ggplot2)
library(RColorBrewer)

evnCntByGroup <- read.table('result/groupDat.tsv', sep='\t', header=TRUE)
iGroupAnnual <- read.table('result/TopDangerGroupAnnualDat.tsv', sep='\t', header=TRUE)
dangerGrpDat <- read.table("result/TopDangerGroupDat.tsv", sep='\t', header=TRUE)

top <- seq(1:5)
dangerGrps <- arrange(evnCntByGroup, totalEvents, decreasing=TRUE)[top,]$gname

pEveCntByGrp <- ggplot(evnCntByGroup, aes(x=totalEvents))
pEveCntByGrp + geom_bar(binwidth=0.3) + scale_x_log10(breaks=c(1, 10, 100, 1000))


pGroup <- ggplot(dangerGrpDat, 
                 aes(x=gname, y=iyear, fill=gname))
pGroup <- pGroup + geom_violin(scale='count') + coord_flip()
pdf('figure/group_impact_violin.pdf') # starts writing a PDF to file
pGroup                    # makes the actual plot
dev.off() 


pGroupEvent <- ggplot(iGroupAnnual, aes(x=iyear, y=totalKilled, fill=gname, color=gname))
pGroupEvent <- pGroupEvent + 
  geom_histogram(stat='identity', alpha=0.3, color=NA) +
  geom_path() + 
  labs(x = "Year", y = "Total Number of People Killed", colour = "Group Name")

png('figure/group_impact_bar.png', width=900,height=500) # starts writing a PDF to file
pGroupEvent                    # makes the actual plot
dev.off() 