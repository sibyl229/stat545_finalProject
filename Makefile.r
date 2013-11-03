## one script to rule them all

library(knitr)

## clean out any previous work
outputs <- c(list.files('figure/', pattern='*.(png)|(svg)|(pdg)', full.names=T),
             list.files('result/', full.names=T)
            )
file.remove(outputs)

## run my scripts
source("dataPrep.r")
source("plotByGroup.r")
source("plotByCountry.r") 

knit2html('stat545a-2013-hw06_gao-wen.rmd')
knit('README.rmd')