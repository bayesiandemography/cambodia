
library(dplyr)
library(dembase)
library(latticeExtra)


births_dhs <- readRDS("data/births_dhs.rds")
births_census <- readRDS("data/births_census.rds")
exposure <- readRDS("data/exposure.rds")

births_census <- births_census %>%
    collapseDimension(margin = "age")

exposure <- exposure %>%
    collapseDimension(dimension = "province")

rates <- dbind(DHS = births_dhs / exposure,
               Census = births_census / exposure,
               along = "variant") %>%
    as.data.frame(direction = "long")

col <- c("dark grey", "light grey")
p <- barchart(value ~ age,
              data = rates,
              groups = variant,
              xlab = "",
              ylab = "",
              col = col,
              ylim = c(0, NA),
              scales = list(tck = 0.3),
              lattice.options = modifyList(lattice.options(),
                                           list(skip.boundary.labels = 0)),
              par.settings = list(fontsize = list(text = 7, points = 5),
                                  strip.background = list(col = "grey90")),
              key = list(text = list(levels(rates$variant)),
                         rectangles = list(col = col),
                         space = "right"))


pdf(file = "out/fig_direct_national.pdf",
    w = 4.7,
    h = 2.1)
plot(p)
dev.off()
