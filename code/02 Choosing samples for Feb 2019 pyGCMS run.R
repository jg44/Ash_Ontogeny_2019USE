
source("/Users/jrg1035/Dropbox/R/myfunctions/functionlist.r")

.bu("/Users/jrg1035/Box/R/Projects2019Win/Proj_Ash_Ontogeny_2019USE/MasterProjectFile_Ash_Ontogeny_2019USE.md")

com <- .read.csv.dt("./data/ontogeny result 1 18.08 Heath for R compunds.csv")
names(com)[1] <- "Compound"

(comClasses <- .read.csv.dt("./data/ontogeny result 1 18.08 Heath for R compound CLASSES.csv", header=T))

treekey <- .read.csv.dt("./data/treeSampleMatchKeyPilotPre1.csv", header=TRUE)

.bu(("./data/randomization scheme ontogenyUSETHISONE.csv"))
.bu(("./data/randomization scheme ontogenyUSETHISONE.xlsx"))


treatments2018Key <- .read.csv.dt("./data/randomization scheme ontogenyUSETHISONE.csv")

treatments2018Key[preYN=="Y" & process!="", table(tyvexYN, INNOC_TYPE, DBHtrt)]

names(treekey)[1]<-"treeID"

# get treatment and key for our tree #
matchKey <- .read.csv.dt("./data/treeSampleMatchKeyPilotPreUSE.csv")
matchKey_coldesc <- .read.csv.dt("./data/treeSampleMatchKeyPilotPreUSE_dataDictionary.csv")



sampleInFeb2019 <- c(3,4,5,6,8,11,13,14,16,18,21,23, 25,28,31,32,34,35,40, 41,42,43,44,46)  #23 and 40 missing (see 32) I found most of your samples, except for: 23, 32 and 40.  There are other samples with the same number (32 and 40) but they are labeled like this: 32.2, 32.5, 41.1, 41.11 and 41.11A. 
.l(sampleInFeb2019)

sampleInFeb2019 <- c(3,4,5,6,8,11,13,14,16,18,21,23, 25,28,31,32,34,35,40, 41,42,43,44,46, 15, 19)  #
.l(sampleInFeb2019)


# from Karen:  I found most of your samples, except for: 23, 32 and 40.
# There are other samples with the same number (32 and 40) but they are 
#labeled like this: 32.2, 32.5, 41.1, 41.11 and 41.11A.

substituteForMissing <- c(47, 24) # and select 32.2
treatments2018Key[c(sampleInFeb2019,substituteForMissing), table(INNOC_TYPE, paste(DBHtrt, tyvexYN))]

treatments2018Key[c(sampleInFeb2019,substituteForMissing),]

treatments2018Key$DBHtrt <- factor(treatments2018Key$DBHtrt, c("S", "SM", "ML", "L"))
sampleInFeb2019


treatments2018Key[sampleInFeb2019, table(paste(DBHtrt, tyvexYN, preYN, sep="_"), INNOC_TYPE)]


treatments2018Key[sampleInFeb2019, table(paste(DBHtrt, tyvexYN, sep="_"), paste(INNOC_TYPE,preYN, sep="_"))]

ADD 1


