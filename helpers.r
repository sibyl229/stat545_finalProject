library(ggplot2)

myggsave <- function(filename, width=20, height=11.25, units='cm',...){
  defaultFormats <- c(".png", ".svg")
  fileNames <- c(filename)
  for (fmt in defaultFormats){
    # generate file names of all default formats
    nm <- sub("(\\.\\w+$)", fmt, filename, perl=T)
    fileNames <- c(fileNames, nm)
  }
  for (nm in unique(fileNames)){
    ggsave(nm, width=width, height=height, units=units, ...)
  }
}