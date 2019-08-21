
library(demest)
library(dplyr)
library(latticeExtra)

sample_provinces <- readRDS("data/sample_provinces.rds")

tfr <- fetch("out/model.est", where = c("model", "likelihood", "rate")) %>%
    tfr()

tfr <- tfr %>%
    slab(dimension = "province", elements = sample_provinces)
                       
p <- dplot(~ province,
           data = tfr,
           col = "grey50",
           xlab = "Births",
           ylab = "",
           horizontal = TRUE, 
           xlim = c(-0.2, NA),
           scales = list(tck = 0.3),
           layout = c(NA, 1),
           par.settings = list(fontsize = list(text = 7),
                               strip.background = list(col = "grey90")))

pdf(file = "out/fig_tfr.pdf",
    w = 3,
    h = 2)
plot(p)
dev.off()


