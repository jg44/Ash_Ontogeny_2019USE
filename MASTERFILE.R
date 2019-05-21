#source("C:/Users/jrg1035/Dropbox/R/myfunctions/functionlist.r")
.bu("./data")


library(ProjectTemplate)
library(data.table)
library(vegan)
library(ggplot2)
library(JGTools)



.adf(list.files())

list.files(path="./src")

browseURL(list.files()[grep("src", list.files())])

browseURL(getwd())
browseURL("README_new.md")
browseURL("TODO.md")

