---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->


# cambodia

This repository contains the R code for modelling and creating graphs for the paper

> Zhang JL, Bryant J. 2019. Combining multiple imperfect data sources for small area estimation: A Bayesian model of provincial fertility rates in Cambodia. *Statistical Theory and Related Fields* 3(2): 178-185.

The model and graphs in the paper can be reproduced by running the code in file "run_all.R", which in turn runs code in the "src" folder.

For the code to run, you will need to have the packages **coda**, **dplyr**, and **latticeExtra** installed on your computer. These can all be installed from CRAN.

You will also need to have the packages **dembase** and **demest** installed. These can be installed from GitHub using
``` r
devtools::install_github("statisticsnz/dembase")
devtools::install_github("statisticsnz/demest")
```

Running the code creates the database "model.est" and five pdf files in the folder "out".






