#26 Jul 2018 - parse Scott Greenwood's py-GCMS library to just CAS numbers for lookup on PubChem (NCBI)
# still need to look at the other 200 that do not have cas numbers.

# setwd("F:/UNH/Ash_Induction")
# read.f <- "Library_copy.txt"
setwd("F:/UNH/Ash_Induction")
read.f <- "./data/Ash_induction/Library_copy.txt"
dat <- readLines(read.f)
dat[1:20]

cas.i <- grep("CASNO:", dat) #find all lines that start with CASNO:
cas.1 <- dat[cas.i] #extract these lines only
cas.2 <- gsub("CASNO:", "OR ", cas.1) #remove CASNO:
cas.i2 <- grep("[0-9]{1,}-[0-9]{1,}-[0-9]{1,}",cas.2)#remove everything but actual cas numbers
cas.3 <- cas.2[cas.i2]

cas <- as.data.frame(matrix(data = c(cas.3,rep(NA,3)), nrow = 6, ncol = 100, byrow = T, dimnames = NULL)) #put in groups of 100
head(cas)
tail(cas)

getwd()
write.table(cas, file = "cas_only_library.txt",
	append = FALSE, quote = FALSE, sep = " ",row.names = FALSE,
            col.names = FALSE)


