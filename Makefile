all: stat545a-2013-hw06_gao-wen.html README.md

result/*.tsv: data/clean_globalterrorismdb_1012dist.tsv
	Rscript dataPrep.r

figure/group_*.svg: result/*.tsv
	Rscript plotByGroup.r

figure/region_*.svg: result/*.tsv
	Rscript plotByCountry.r

README.md: README.rmd
	Rscript -e "knitr::knit('README.rmd')"

stat545a-2013-hw06_gao-wen.html: stat545a-2013-hw06_gao-wen.rmd figure/group_*.svg figure/region_*.svg result/*.tsv
	Rscript -e "library(knitr)" \
	-e "if (is.null(customKnit <- getOption('rstudio.markdownToHTML'))){" \
	-e "	knit2html('stat545a-2013-hw06_gao-wen.rmd')" \
	-e "} else { knit('stat545a-2013-hw06_gao-wen.rmd')" \
	-e "	customKnit('stat545a-2013-hw06_gao-wen.md','stat545a-2013-hw06_gao-wen.html')}"

clean:
	rm -rf *.md *.html figure/* result/*
