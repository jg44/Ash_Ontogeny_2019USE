#24 Sep 2018 - subsample the MeJA posttreatment ash bark samples that were taken from ABOVE the treatment area. Jeff wants a sample size of 6 for
# this run.

## JG I Wouldn't use this...disregard in favor of "02 Choosing samples for Feb 2019 pyGCMS run.R"

setwd("F:/UNH/Ash_Induction")
read.f <- "posttreatment_samples.txt"
dat <- read.delim(read.f, header = T)

str(dat)
head(dat)

samp <- sample(dat$tree.id, 6, replace = F)
samp
