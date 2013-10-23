## one script to rule them all

## clean out any previous work
outputs <- c(list.files('figure/', pattern='*.png', full.names=T),
             list.files('figure/', pattern='*.pdf', full.names=T)
         #    list.files('result/')
             )
file.remove(outputs)

## run my scripts
#source("dataPrep.r")
source("plotByGroup.r")
#source("plot.r") #not exactly working yet