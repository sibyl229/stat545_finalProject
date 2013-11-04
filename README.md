README
========================================================
## Updated on Nov 3nd, 2013 to use make

How to replicate my analysis

  * Clone the repo!
  * Download into an empty directory:
    - Input data: [`Terrorism Dataset`](data/clean_globalterrorismdb_1012dist.tsv). This file is modified from the original data by removing unnecessary text columns, so it won't give error when loading into R.
    - Scripts: [`dataPrep.r`](dataPrep.r), [`plotByGroup.r`](plotByGroup.r), and [`plotByCountry.r`](plotByCountry.r)
    - Makefile script: [`Makefile`](Makefile)
  * Start a fresh RStudio session, make sure the above directory is the working directory, open `Makefile.r`, and click on "Source".
  * Alternatively, in a shell: `Rscript Makefile.r`.
  * When you run the pipeline the first time, you will get warnings about `file.remove()` trying to remove files that don't exist. That's OK. They will exist and will be removed and remade on subsequent runs.
  * New files you should see after running the pipeline (Some of the files are quite ugly, and the better ones are included in the html report):  
<ul>
<li><a href="figure//group_impact_bar.png"><code>figure//group_impact_bar.png</code></a></li>
<li><a href="figure//group_impact_violin.png"><code>figure//group_impact_violin.png</code></a></li>
<li><a href="figure//group_pKilledvsAttacks.png"><code>figure//group_pKilledvsAttacks.png</code></a></li>
<li><a href="figure//region_attacksVsKilledMiddleEast.png"><code>figure//region_attacksVsKilledMiddleEast.png</code></a></li>
<li><a href="figure//region_attacksVsKilledRegional.png"><code>figure//region_attacksVsKilledRegional.png</code></a></li>
<li><a href="figure//region_numAttackesVsNumKilled.png"><code>figure//region_numAttackesVsNumKilled.png</code></a></li>
<li><a href="figure//region_SouthAsiaTotalAttackes.png"><code>figure//region_SouthAsiaTotalAttackes.png</code></a></li>
</ul>

- [stat545a-2013-hw06_gao-wen.html](stat545a-2013-hw06_gao-wen.html) which can be previewed [here](http://htmlpreview.github.io/?https://github.com/sibyl229/stat545a-2013-hw06_gao-wen/blob/master/stat545a-2013-hw06_gao-wen.html)
  
