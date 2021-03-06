
source("/Users/jrg1035/Dropbox/R/myfunctions/functionlist.r")
library(JGTools)
library(vegan)

com <- read.csv.dt("./data/ontogeny result 1 18.08 Heath for R compunds.csv")
names(com)[1] <- "Compound"

bu("./data/")

(comClasses <- read.csv.dt("./data/ontogeny result 1 18.08 Heath for R compound CLASSES.csv", header=T))

treekey <- read.csv.dt("./data/treeSampleMatchKeyPilotPre1.csv", header=TRUE)

# .bu(("./data/randomization scheme ontogenyUSETHISONE.csv"))
# .bu(("./data/randomization scheme ontogenyUSETHISONE.xlsx"))


treatments2018Key <- read.csv.dt("./data/randomization scheme ontogenyUSETHISONE.csv")

treatments2018Key[preYN=="Y" & process!="", table(tyvexYN, INNOC_TYPE, DBHtrt)]

names(treekey)[1]<-"treeID"

# get treatment and key for our tree #
matchKey <- read.csv.dt("./data/treeSampleMatchKeyPilotPreUSE.csv")
matchKey_coldesc <- read.csv.dt("./data/treeSampleMatchKeyPilotPreUSE_dataDictionary.csv")

sampleInFeb2019 <- c(3,4,5,6,8,11,13,14,16,18,21,25,28,31,32,34,35,41,42,43,44,46)  #23 and 40 missing (see 32) I found most of your samples, except for: 23, 32 and 40.  There are other samples with the same number (32 and 40) but they are labeled like this: 32.2, 32.5, 41.1, 41.11 and 41.11A. 
substituteForMissing <- c(47, 24) # and select 32.2
treatments2018Key[c(sampleInFeb2019,substituteForMissing), table(INNOC_TYPE, paste(DBHtrt, tyvexYN))]


treekey
#View(com)


# browseURL("./data/randomization scheme ontogenyUSETHISONE.xlsx")
  
samplesIDshrt <- 
    as.character(t(com[1,4:15]))

# 
samplesIDshrt <-  gsub("X|iih", "", names(com[,4:15]))



commat <- t(as.matrix(data.frame(lapply((com[-1,4:15]), function(x) { as.numeric(gsub("%", "", x))}))))



commatClasses <- (as.matrix(data.frame(lapply((comClasses[,3:10]), function(x) { as.numeric(gsub("%", "", x))}))))

dimnames(commatClasses)[[1]] <- trtSize

# install.packages("vegan")
    
dimnames(commat) <- list( samplesIDshrt , com$V1[-1] )
dimnames(commat) <- list( trtSize , com$V1[-1] )


# View(commat)

princomp(t(commat))

NMDS <- metaMDS(commat, k = 2, trymax = 450, engine = "monoMDS", weakties = TRUE, stress = 1, noshare=.1,
             maxit=2000, scaling = TRUE, pc = TRUE, smin = 1e-4, sfgrmin = 1e-7,
             sratmax=0.999999, zerodist="add") 
str(commat)

stressplot(NMDS)

plot(NMDS)

as.numeric(gsub("iih", "", row.names(commat)))

sizeLevels <- factor(gsub("iih", "", row.names(commat)), levels=c("S", "SM", "ML", "L"))
# trtSize <- treekey[as.numeric(sizeLevels), get("DBHtrt")]
# trtSize<0 
# treatments2018Key
# orditorp(NMDS,display="sites",cex=1.25,air=0.01, col=1)
# # orditorp(NMDS,display="species",col="red",air=0.01)
# trtSize1 <- as.numeric(trtSize)
# trtSizeSL <- c("S", "L")[as.numeric(trtSize1>3)+1]
# trtSize <- treatments2018Key[.nn(rownames(NMDS$points))]$DBHtrt

trtSize <- rownames(commat)

preYN <- treatments2018Key[.nn(rownames(NMDS$points))]$preYN

#convert the 4 levels into 2 (S, SM and ML, L)
trtSizeSL <- factor(gsub("M", "", sizeLevels), levels=c("S", "L"))
x11()
ordiplot(NMDS)
ordihull(NMDS,groups=trtSizeSL,draw="polygon",col=3:4,label=F)

ordiplot(NMDS)
ordiellipse(NMDS,groups=trtSize,draw="polygon",col=c("dark green",4, 2, "yellow"))

ordiellipse(NMDS,groups=trtSize,draw="polygon",col=c("dark green",4, 2, "yellow"), label=TRUE)

# .devpdf("NMDS ellipse_new")  (waiting to add devpdf to JGTools)



