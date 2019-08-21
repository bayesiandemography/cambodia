
library(demest)
library(dplyr)
library(lattice)

filename <- "out/model.est"

rates <- fetch(filename,
               where = c("model", "likelihood", "rate"))
births_dhs <- fetch(filename,
                    where = c("datasets", "births_dhs"))
exposure <- fetch(filename,
                  where = "exposure")

rates <- rates %>%
    collapseIntervals(dimension = "age",
                      old = c("40-44", "45-49"),
                      weights = exposure)

rates_direct <- births_dhs / exposure
                       
p <- dplot(~ age,
           data = rates,
           weights = exposure,
           col = "grey60",
           xlab = "",
           ylab = "",
           scales = list(tck = 0.4),
           ylim = c(0, NA),
           lattice.options = modifyList(lattice.options(), list(skip.boundary.labels = 0)),
           par.settings = list(fontsize = list(text = 7),
                               strip.background = list(col = "grey90")),
           overlay = list(values = rates_direct,
                          col = "black",
                          lwd = 2))


pdf(file = "out/fig_model_national.pdf",
    w = 3.4,
    h = 2.5)
plot(p)
dev.off()
