
library(demest)
library(dplyr)

sample_provinces <- readRDS("data/sample_provinces.rds")

rates <- fetch("out/model.est",
               where = c("model", "likelihood", "rate")) %>%
    slab(dimension = "province", elements = rev(sample_provinces))


births_census <- fetch("out/model.est",
                       where = c("datasets", "births_census"))

exposure <- fetch("out/model.est",
                  where = "exposure")

rates_direct <- (births_census / exposure) %>%
    subarray(province %in% sample_provinces) %>%
    slab(dimension = "province", elements = rev(sample_provinces))
                       
p <- dplot(~ age | province,
           data = rates,
           col = "grey50",
           xlab = "",
           ylab = "",
           as.table = TRUE,
           scales = list(tck = 0.3,
                         x = list(rot = 90)),
           layout = c(NA, 2),
           lattice.options = list(skip.boundary.labels = 0),
           par.settings = list(fontsize = list(text = 6),
                               strip.background = list(col = "grey90")),
           overlay = list(values = rates_direct,
                          col = "black",
                          lwd = 1.5))

pdf(file = "out/fig_model_province.pdf",
    w = 4.7,
    h = 3)
plot(p)
dev.off()
