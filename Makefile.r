## one script to rule them all

## clean out any previous work
outputs <- c(list.files('figure/'),
         #    list.files('result/')
             )
file.remove(outputs)

## run my scripts
source("01_filterReorder.R")
source("02_aggregatePlot.R")