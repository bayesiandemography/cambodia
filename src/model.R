
library(demest)

n_burnin <- 200000
n_sim <- 200000
n_chain <- 4
n_thin <- 500

births_census <- readRDS("data/births_census.rds")
births_dhs_revised <- readRDS("data/births_dhs_revised.rds")
exposure <- readRDS("data/exposure.rds")
poverty <- readRDS("data/poverty.rds")
phnom_penh_1524 <- readRDS("data/phnom_penh_1524.rds")
cover_dhs_mean <- readRDS("data/cover_dhs_mean.rds")
cover_dhs_se <- readRDS("data/cover_dhs_se.rds")


## system model

model <- Model(y ~ Poisson(mean ~ age + province),
               age ~ DLM(damp = NULL),
               province ~ Exch(covariates = Covariates(mean ~ poverty,
                                                       data = poverty)),
               jump = 0.05)


## data models

model_census <- Model(births_census ~ Poisson(mean ~ age + province),
                      age ~ DLM(level = Level(scale = HalfT(scale = 0.05)),
                                trend = NULL,
                                damp = NULL,
                                error = Error(scale = HalfT(scale = 0.05))),
                      province ~ Exch(error = Error(scale = HalfT(scale = 0.05))),
                      jump = 0.07)

model_dhs <- Model(births_dhs ~ NormalFixed(mean = cover_dhs_mean, sd = cover_dhs_se))

data_models = c(model_census, model_dhs)


## datasets

datasets <- list(births_census = births_census,
                 births_dhs = births_dhs_revised)



## initial value of 'y'

y <- toInteger(2 * births_census)


## estimation

filename <- "out/model.est"
set.seed(1)
estimateCounts(model = model,
               y = y, 
               exposure = exposure,
               dataModels = data_models,
               datasets = datasets,
               filename = filename,
               nBurnin = n_burnin,
               nSim = n_sim,
               nChain = n_chain,
               nThin = n_thin)
options(width = 120)
fetchSummary(filename)
