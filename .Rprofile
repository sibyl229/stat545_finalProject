options(rstudio.markdownToHTML = function(inputFile, outputFile) {
     require(markdown)
     
     ## make easy to toggle base64 encoding of images and perhaps other things ...
     htmlOptions <- markdownHTMLOptions(defaults = TRUE)
     ## htmlOptions <- htmlOptions[htmlOptions != 'base64_images']
     
     ## you must customize for where YOU store CSS
     pathToCSS <- "resources/css/markdown-css-themes"
     pathToCSS <- file.path(path.expand("~/"), pathToCSS, "markdown7.css")
     
     markdownToHTML(inputFile, outputFile, options = htmlOptions, stylesheet = pathToCSS)
})



