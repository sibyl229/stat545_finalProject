library(ggplot2)
library(RColorBrewer)

countryDat <- read.table('result/countryDat.tsv', sep='\t', header=TRUE)
countryDat <- within(countryDat, country_txt <- reorder(country_txt, -totalEvents))

regions <- 'South Asia' #c('Middle East & North Africa')

p <- ggplot(subset(countryDat, region_txt==regions), 
            aes(x=country_txt, y=totalEvents))

p <- p + geom_bar(stat="identity") +coord_flip()
ggsave('figure/SouthAsiaTotalAttackes.png')


pEventKilled <- ggplot(countryDat,
                       aes(x=totalEvents, y=totalKilled, color=region_txt))
pEventKilled + geom_point() +
  scale_x_log10() + scale_y_log10()
ggsave('figure/numAttackesVsNumKilled.png')

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
ggsave('figure/attacksVsKilledRegional.png')


pEventTrend2 <- ggplot(subset(countryAnnualDat, region_txt=='Middle East & North Africa'),
                       aes(x=iyear, y=totalEvents, size=totalKilled, 
                           color=country_txt))
pEventTrend2 + geom_point(alpha=0.3) + scale_size_area(max_size=10) + 
  geom_smooth(method='loess') 
ggsave('figure/attacksVsKilledMiddleEast.png')


# p
# dev.print(pdf,        # copies the plot to a the PDF file
#           "figure/testFigure_method2.pdf")
# 
# p2 <- ggplot(subset(countryDat, region_txt==regions), aes(x=1, y=totalKilled, fill = country_txt))
# p2 + geom_bar(stat='identity') +coord_polar(theta='y')
#p + #geom_violin(alpha=0.3) + coord_flip()