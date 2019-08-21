
library(demest)
library(dplyr)


sample_provinces <- readRDS("data/sample_provinces.rds")

coverage <- fetch("out/model.est",
                  where = c("dataModels", "births_census", "likelihood", "rate")) %>%
    subarray(province %in% sample_provinces) %>%
    slab(dimension = "province", elements = rev(sample_provinces))

p <- dplot(~  age | province,
           data = coverage,
           col = "grey50",
           xlab = "",
           ylab = "",
           layout = c(NA, 2),
           as.table = TRUE,
           scales = list(tck = 0.3,
                         x = list(rot = 90)),
           par.settings = list(fontsize = list(text = 6),
                               strip.background = list(col = "grey90")))

pdf(file = "out/fig_coverage.pdf",
    w = 4.7,
    h = 3)
plot(p)
dev.off()
