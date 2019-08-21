
library(dembase)
library(dplyr)
library(latticeExtra)

births <- readRDS("data/births_census.rds")

exposure <- readRDS("data/exposure.rds")
    
sample_provinces <- readRDS("data/sample_provinces.rds")

rates <- (births / exposure) %>%
    subarray(province %in% sample_provinces) %>%
    as.data.frame(direction = "long") %>%
    mutate(province = factor(province, levels = rev(sample_provinces)))

p <- barchart(value ~ age | province,
              data = rates,
              col = "light grey",
              type = "b",
              xlab = "",
              ylab = "",
              ylim = c(0, NA),
              as.table = TRUE,
              layout = c(NA, 2),
              lattice.options = list(skip.boundary.labels = 0),
              scales = list(tck = 0.3,
                            x = list(rot = 90)),
              par.settings = list(fontsize = list(text = 6, points = 5),
                                  strip.background = list(col = "grey90")))


pdf(file = "out/fig_direct_province.pdf",
    w = 4.7,
    h = 2.9)
plot(p)
dev.off()
