require(DescTools)
dataMB <- read.csv("MB_Own_1993 (1).csv", header = TRUE, sep = ",")
summary(dataMB)
plot(dataMB$mtbe, dataMB$own)
dataMB <- dataMB[which(dataMB$mtbe > 0),]
dataMB$wingvkey <- Winsorize(dataMB$gvkey, probs = c(0.005, 0.995))
dataMB$winleverage <- Winsorize(dataMB$leverage, probs = c(0.005, 0.995))
dataMB$winmtbe <- Winsorize(dataMB$mtbe, probs = c(0.005, 0.995))
dataMB$winown <- Winsorize(dataMB$own, probs = c(0.005, 0.995))
