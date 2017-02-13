data(targets)

char_vars <- names(targets)[sapply(targets, is.character)]
data.table::setDT(targets)
targets[, c(char_vars) := lapply(.SD, as.factor), .SDcols = char_vars]
class(targets) <- "data.frame"

targets <- targets[targets$year %in% 1975:2015, ]
devtools::use_data(targets, overwrite = TRUE)
tools::checkRdaFiles('../data')

