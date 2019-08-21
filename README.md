---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->


# cambodia

This repository contains the R code for modelling and creating graphs for the paper

> Zhang JL, Bryant J. Forthcoming. Combining multiple imperfect data sources for small area estimation: A Bayesian model of provincial fertility rates in Cambodia. *Statistical Theory and Related Fields*.

The model and graphs in the paper can be reproduced by running the code in file "run_all.R", which in turn runs code in the "src" folder.

For the code to run, you will need to have the packages **coda**, **dplyr**, and **latticeExtra** installed on your computer. These can both be installed from CRAN.

You will also need to have the packages **dembase** and **demest**. These can be installed from GitHub using
``` r
devtools::install_github("dembase")
devtools::install_github("demest")
```

The model database "model.est" and the figures are all created in folder "out".





