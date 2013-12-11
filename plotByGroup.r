library(plyr)
library(ggplot2)
#library(RColorBrewer)
source('helpers.r')

evnCntByGroup <- read.table('result/groupDat.tsv', sep='\t', header=TRUE)
iGroupAnnual <- read.table('result/TopDangerGroupAnnualDat.tsv', sep='\t', header=TRUE)
dangerGrpDat <- read.table("result/TopDangerGroupDat.tsv", sep='\t', header=TRUE)

top <- seq(1:5)
dangerGrps <- arrange(evnCntByGroup, totalEvents, decreasing=TRUE)[top,]$gname

pEveCntByGrp <- ggplot(evnCntByGroup, aes(x=totalEvents)) +
  geom_bar(binwidth=0.3) + 
  scale_x_log10(breaks=c(1, 10, 100, 1000))


pGroup <- ggplot(dangerGrpDat, 
                 aes(x=as.integer(galias), y=iyear, fill=galias)) + 
  geom_violin(scale='count', color=NA) +
  coord_flip() + scale_x_reverse(labels=NULL, breaks=NULL) +
  labs(x='', y = "Year", fill = "Group Name",
       title="Number of Terrorist Attacks By Groups Over Time")
myggsave('figure/group_impact_violin.png', plot=pGroup, width=15, height=11, units='cm')

# png('figure/group_impact_violin.png', width=900,height=500) # starts writing a PDF to file
# pGroup + geom_violin(scale='count') + coord_flip()                   # makes the actual plot
# dev.off() 


pGroupEvent <- ggplot(iGroupAnnual,
                      aes(x=iyear, y=totalKilled, fill=galias, color=galias)) + 
  geom_histogram(stat='identity', alpha=0.5, color=NA) +
  geom_path() + 
  labs(x = "Year", y = "Number of People Killed Annually", 
       fill="Group Name", color="Group Name",
       title="Number of People Killed Annually in Terrorist Attackes")
#   theme(title = element_text(size = rel(2)),
#         axis.text = element_text(size = rel(1.5)),
#         legend.text = element_text(size = rel(1.5)))
myggsave('figure/group_impact_bar.png', plot=pGroupEvent, scale=1.5)

numKilledPerAttack <- function(x) {
  estCoefs <- coef(lm(totalKilled ~ totalEvents, x))
  slopeLabel <- "slope"
  names(estCoefs) <- c("intercept", slopeLabel)
  return(estCoefs[slopeLabel])
}
pKilledvsAttacks <- ggplot(subset(iGroupAnnual, totalEvents > 0 & totalKilled > 0),
                           aes(x=totalEvents, y=totalKilled, color=galias)) + 
  #scale_x_log10() + scale_y_log10() +  
  #scale_x_continuous(trans = "log") + scale_y_continuous(trans = "log") +
  geom_point(alpha=0.4)  + geom_smooth(method='lm') +
  geom_text(aes(x=200, y=2000, 
                label=sprintf('Avg. # Killed Per Attack:\n %.3f',slope),
                color=NA), 
            data=ddply(iGroupAnnual, ~galias, numKilledPerAttack),
            size=3.5) +
  facet_wrap(~galias) +
  labs(x = "Number of Attacks Annually", y = "Number of People Killed Annually",
       color="Group Name",
       title="Number of People Killed in Terrorist Attacks Annually 
        Against Number of Terrorist Attacks") #+
#   theme(
# title = element_text(size = rel(1.5)),
#         axis.text = element_text(size=rel(1.5)))
myggsave('figure/group_pKilledvsAttacks.png', plot=pKilledvsAttacks)
