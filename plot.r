library(ggplot2)
library(RColorBrewer)

countryDat <- read.table('result/countryDat.tsv', sep='\t', header=TRUE)
countryDat <- within(countryDat, country_txt <- reorder(country_txt, -totalEvents))

regions <- 'South Asia' #c('Middle East & North Africa')

p <- ggplot(subset(countryDat, region_txt==regions), 
            aes(x=country_txt, y=totalEvents))

p <- p + geom_bar(stat="identity") +coord_flip()

countryDat <- read.table('result/countryDat.tsv', sep='\t', header=TRUE)
countryDat <- within(countryDat, country_txt <- reorder(country_txt, -totalEvents))

myPdf <- function(p, fileName, ...){
  fname <- paste('figure', fileName,  sep = "/")
  pdf(fname, ...) # starts writing a PDF to file
  p                    # makes the actual plot
  dev.off()                     # closes the PDF file
}

myPdf(p, 'SouthAsiaTotalAttackes.pdf')
pdf('figure/SouthAsiaTotalAttackes.pdf') # starts writing a PDF to file
p                    # makes the actual plot
dev.off()   
# p
# dev.print(pdf,        # copies the plot to a the PDF file
#           "figure/testFigure_method2.pdf")
# 
# p2 <- ggplot(subset(countryDat, region_txt==regions), aes(x=1, y=totalKilled, fill = country_txt))
# p2 + geom_bar(stat='identity') +coord_polar(theta='y')
#p + #geom_violin(alpha=0.3) + coord_flip()