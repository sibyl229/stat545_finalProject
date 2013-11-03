README
========================================================
## Being updated on Nov 2nd, 2013

How to replicate my analysis

  * Clone the repo!
  * Download into an empty directory:
    - Input data: [`Terrorism Dataset`](data/clean_globalterrorismdb_1012dist.tsv). This file is modified from the original data by removing unnecessary text columns, so it won't give error when loading into R.
    - Scripts: [`dataPrep.r`](dataPrep.r), [`plotByGroup.r`](plotByGroup.r), and [`plotByCountry.r`](plotByCountry.r)
    - Makefile-like script: [`Makefile.r`](Makefile.r)
  * Start a fresh RStudio session, make sure the above directory is the working directory, open `Makefile.r`, and click on "Source".
  * Alternatively, in a shell: `Rscript Makefile.r`.
  * When you run the pipeline the first time, you will get warnings about `file.remove()` trying to remove files that don't exist. That's OK. They will exist and will be removed and remade on subsequent runs.
  * New files you should see after running the pipeline:  
<ul>
<li><a href="figure//attacksVsKilledMiddleEast.png"><code>figure//attacksVsKilledMiddleEast.png</code></a></li>
<li><a href="figure//attacksVsKilledRegional.png"><code>figure//attacksVsKilledRegional.png</code></a></li>
<li><a href="figure//group_impact_bar.png"><code>figure//group_impact_bar.png</code></a></li>
<li><a href="figure//group_impact_violin.png"><code>figure//group_impact_violin.png</code></a></li>
<li><a href="figure//numAttackesVsNumKilled.png"><code>figure//numAttackesVsNumKilled.png</code></a></li>
<li><a href="figure//pKilledvsAttacks.png"><code>figure//pKilledvsAttacks.png</code></a></li>
<li><a href="figure//SouthAsiaTotalAttackes.png"><code>figure//SouthAsiaTotalAttackes.png</code></a></li>
</ul>

- [stat545a-2013-hw06_gao-wen.html](stat545a-2013-hw06_gao-wen.html)
  
