library(data.table)
original <- readRDS('~/Dropbox (MIT)/Survey Database/dgo Data/targets_dgo.rds')
summary(original)
original[sapply(original, is.factor)] <- lapply(original[sapply(original, is.factor)], 
  as.character)
data.table::setnames(original, "prop", "proportion")
targets <- original
devtools::use_data(targets, overwrite = TRUE)
