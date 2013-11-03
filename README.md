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
  
[1] "[`figure//attacksVsKilledMiddleEast.svg`](figure//attacksVsKilledMiddleEast.svg)"
[2] "[`figure//attacksVsKilledRegional.svg`](figure//attacksVsKilledRegional.svg)"    
[3] "[`figure//group_impact_bar.svg`](figure//group_impact_bar.svg)"                  
[4] "[`figure//group_impact_violin.svg`](figure//group_impact_violin.svg)"            
[5] "[`figure//numAttackesVsNumKilled.svg`](figure//numAttackesVsNumKilled.svg)"      
[6] "[`figure//pKilledvsAttacks.svg`](figure//pKilledvsAttacks.svg)"                  
[7] "[`figure//SouthAsiaTotalAttackes.svg`](figure//SouthAsiaTotalAttackes.svg)"      

  
