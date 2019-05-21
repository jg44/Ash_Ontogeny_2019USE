C:/Users/jrg1035/Dropbox/R/Projects2019Win/Proj_Ash_Ontogeny_2019USE/Ash_Ontogeny_2019USE/data/2019.04postTreatmentSamplesFromScottG.xlsx
# yield from tabs:

postArea <- .read.csv.dt("./data/2019.04postTreatmentSamplesFromScottG_area.csv")
postClasses <- .read.csv.dt("./data/2019.04postTreatmentSamplesFromScottG_classes.csv")
postCompounds <- .read.csv.dt("./data/2019.04postTreatmentSamplesFromScottG_compounds.csv")
preCompound <-  .read.csv.dt("./data/ontogeny result 1 18.08 Heath for R compunds.csv")

comm_postCompound <- t(copy(postCompounds[, grepl("^x",names(postCompounds), ignore.case = TRUE), with=FALSE]))


env_postCompounds <- copy(postCompounds[, !grepl("^x",names(postCompounds), ignore.case = TRUE), with=FALSE])

grep("\\<x", names(postCompounds))
     
     ?grep


NMDS_post <- metaMDS(comm_postCompound, k = 2, trymax = 450, engine = "monoMDS", weakties = TRUE, stress = 1, noshare=.1,
                maxit=2000, scaling = TRUE, pc = TRUE, smin = 1e-4, sfgrmin = 1e-7,
                sratmax=0.999999, zerodist="add") 


treatments2018Key$DBHtrtSL <- factor(gsub("M", "", treatments2018Key$DBHtrt), level=c("S", "L"))


trtSizeAll2019 <- treatments2018Key[.nn(gsub("X", "", rownames(comm_postCompound))), ]$DBHtrt

trttypeAll2019 <- treatments2018Key[.nn(gsub("X", "", rownames(comm_postCompound))), ]$INNOC_TYPE

trtPreYN2019 <- treatments2018Key[.nn(gsub("X", "", rownames(comm_postCompound))), ]$preYN



trtSizeAll2019 

treeNumPost <- .nn(gsub("X", "", rownames(NMDS_post$points)))



x11(12,12)
par(mfrow=c(2,2))
ordiplot(NMDS, main="Pre-treatment tree, by size")
ordiellipse(NMDS,groups=trtSize,draw="polygon",col=c("dark green",4, 2, "yellow"), label=TRUE)

ordiplot(NMDS_post, main="Post-treatment, by size")
ordiellipse(NMDS_post,groups=paste(trtSizeAll2019),draw="polygon",col=c("dark green",4, 2, "yellow"), label=TRUE)

ordiplot(NMDS_post, main="Post-treatment, by treatment")
ordiellipse(NMDS_post,groups=paste(trttypeAll2019),draw="polygon",col=c("dark green",4, 2), label=TRUE)

ordiplot(NMDS_post, main="Post-treatment, by treatment and tree size")
ordiellipse(NMDS_post,groups=paste(trtSizeAll2019, trttypeAll2019),draw="polygon",col=c("dark green",4, 2, "yellow"), label=TRUE)

.devpdf("NMDS ellipse pre and post")


x11(14,8)
par(mfrow=c(1,2))

ordiplot(NMDS)
ordiellipse(NMDS,groups=trtSize,draw="polygon",col=c("dark green",4, 2, "yellow"))

ordiplot(NMDS_post)
ordiellipse(NMDS_post,groups=trtSizeAll2019,draw="polygon",col=c("dark green",4, 2, "yellow"), label=TRUE)


# Match pre and post samples that can be matched --------------------------

compoundsByRun <- rbind(
data.frame(run=1, compound=com$Compound),
data.frame(run=2, compound=env_postCompounds$Compound)
)

compoundsByRuntable

compoundsByRuntable <- 
    
    with(compoundsByRun, table(compound, run) )

write.csv(compoundsByRuntable, "./data/compoundsByRuntable.csv")

c(levels(), levels(env_postCompounds$Compound)))

write.csv(as.data.table(table(c(levels(com$Compound), levels(env_postCompounds$Compound)))), file="./data/compounds across years.csv")


merge()

allCompounds <-  data.table(Compound=rownames(compoundsByRuntable))

presamplesMerged <- merge(preCompound, allCompounds, all=TRUE)
presamplesMerged[, prePost := 1]


postsamplesMerged <- merge(postCompounds, allCompounds, all=TRUE)
postsamplesMerged[, prePost := 2]


presamplesMerged_mat <-  t(copy(presamplesMerged[, grepl("^X.", names(presamplesMerged)), with=FALSE]))
postsamplesMerged_mat <-  t(copy(postsamplesMerged[, grepl("^X.", names(postsamplesMerged)), with=FALSE]))


allMat <- rbind(presamplesMerged_mat, postsamplesMerged_mat)

tmp <- as.numeric(gsub("%", "",  allMat))
tmp[is.na(tmp)] <- 0

allMat1 <- matrix(tmp, 38, 186, byrow = FALSE)


dimnames(allMat1) <-  list(gsub("[^0-9.-]", "", rownames(allMat)), allCompounds$Compound)

prePost <- as.vector(dimnames(allMat)[[1]])
prePost[grepl("ii", prePost)] <- "pre"
prePost[grepl("X", prePost)] <- "post"
prePost <- as.factor(prePost)

NMDSAll <- metaMDS(allMat1, k = 2, trymax = 450, engine = "monoMDS", weakties = TRUE, stress = 1, noshare=.1,
        maxit=2000, scaling = TRUE, pc = TRUE, smin = 1e-4, sfgrmin = 1e-7,
        sratmax=0.999999, zerodist="add") 

treeNumbersAll <- as.numeric(dimnames(allMat1)[[1]])

trtSizeAll <- factor(treatments2018Key$DBHtrt[treeNumbersAll], levels = c("S", "SM", "ML", "L"))
trtTypeAll <- treatments2018Key$INNOC_TYPE[treeNumbersAll]


trtTypePost <- treatments2018Key$INNOC_TYPE[treeNumPost]
trtSizePost <- treatments2018Key$DBHtrt[treeNumPost]
trtpreYNPost <- treatments2018Key$preYN[treeNumPost]
trttyvexPost <- treatments2018Key$tyvexYN[treeNumPost]

which(trtTypeAll=="control")
# treatments2018Key$INNOC_TYPE[as.numeric(rownames(NMDSAll$points))]

x11(14,7)
par(mfrow=c(1,2))

ordiplot(NMDSAll, main="Pre- v. post")
ordiellipse(NMDSAll,groups=prePost,draw="polygon",col=c("dark green",4), label=TRUE)
#ordiplot(NMDSAll, main="Pre- v. post")
# points(NMDSAll$points, pch=20, col=as.numeric(trtTypeAll), cex=as.numeric(trtSizeAll))




ordiplot(NMDSAll, main="Pre- v. post", type = "none", display = "sites")
ordiellipse(NMDSAll,groups=treeNumbersAll,draw="lines", col=1, label=F, lwd=1.8, conf=.22)
points(NMDSAll$points, pch=20, col=as.numeric(trtTypeAll), cex=as.numeric(trtSizeAll))

legend("topleft", fill=1:3, col=1:3, legend=levels(trtTypeAll), cex=1.62)
.devpdf("comparing pre and post 2018", png=TRUE, overwrite = TRUE)


x11(14,7)
par(mfrow=c(1,2))

# compare post samples where pre samples were and were not taken ----------

ordiplot(NMDS_post, main="Post samples where pre samples were and were not taken")
points(NMDS_post$points, pch=20, col=as.numeric(trtTypePost), cex=as.numeric(trtSizePost))

ordiellipse(NMDS_post,groups=trtPreYN2019,draw="polygon", col=c("dark green", "dark red"), label=T, lwd=1.8)

# compare post samples where Tyvex was and was not used ----------

ordiplot(NMDS_post, main="Post samples where Tyvex was or was not used")
points(NMDS_post$points, pch=20, col=as.numeric(trtTypePost), cex=as.numeric(trtSizePost))

ordiellipse(NMDS_post,groups=trttyvexPost,draw="polygon", col=c("dark green", "dark red"), label=T, lwd=1.8)
legend("bottomright", fill=1:3, col=1:3, legend=levels(trtTypeAll), cex=1.62)

.devpdf("comparing post with pre and tyvex", png=TRUE, overwrite = TRUE)
