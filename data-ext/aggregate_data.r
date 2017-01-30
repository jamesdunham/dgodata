library(data.table)
library(dplyr)
path = "~/Dropbox (MIT)/Survey Database/DGIRT Data/GSS_long160412.dta"
aggregates = foreign::read.dta(path)
aggregates[sapply(aggregates, is.factor)] <- 
  lapply(aggregates[sapply(aggregates, is.factor)], as.character)
setDT(aggregates)
setnames(aggregates, c("STATEAB", "N", "S", "gender", "race"),
         c("state", "n_grp", "s_grp", "female", "race3"))
aggregates <- as.data.frame(aggregates)
aggregates$year <- as.integer(aggregates$year)
aggregates <- aggregates[aggregates$year %in% 2006:2008, ]
aggregates$race3 <- replace(aggregates$race3, aggregates$race3 == "1", "white")
aggregates$race3 <- replace(aggregates$race3, aggregates$race3 == "2", "black")
aggregates$race3 <- replace(aggregates$race3, aggregates$race3 == "3", "other")
aggregates$female <- replace(aggregates$female, aggregates$female == "0", "male")
aggregates$female <- replace(aggregates$female, aggregates$female == "1", "female")
aggregates <- aggregates %>%
  group_by_("year", "state", "race3", "female", "item") %>%
  summarize(n_grp = sum(n_grp), s_grp = sum(s_grp))
devtools::use_data(aggregates, overwrite = TRUE)
