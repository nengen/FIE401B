require(DescTools)
require(lmtest)
require(car)
require(plyr);
require(stargazer)
dataMB <- read.csv("MB_Own_1993 (1).csv", header = TRUE, sep = ",")
summary(dataMB)
plot(dataMB$mtbe, dataMB$own)
dataMB <- dataMB[which(dataMB$mtbe > 0),]
dataMB$wingvkey <- Winsorize(dataMB$gvkey, probs = c(0.005, 0.995))
dataMB$winleverage <- Winsorize(dataMB$leverage, probs = c(0.005, 0.995))
dataMB$winmtbe <- Winsorize(dataMB$mtbe, probs = c(0.005, 0.995))
dataMB$winown <- Winsorize(dataMB$own, probs = c(0.005, 0.995))

#linear 
fitLin <- lm(winmtbe~winown,data = dataMB) 
#quadratic
quadOwn <- dataMB$winown^2
fitQuad <- lm(winmtbe~quadOwn, data = dataMB)

#test for heteroskedasticity
bptest(fitLin); #have to correct for hetero
robustFitLin <- coeftest(fitLin, vcov = hccm)
bptest(fitQuad) #have to correct
robustFitQuad <- coeftest(fitQuad, vcov = hccm )

#2
indexData <- read.csv("Data_index_addition.csv", header = TRUE, sep = ",")
summary(indexData)

#winsorize data
indexData$wincar <- Winsorize(indexData$car, probs = c(0.025,0.975))
indexData$winPQS <- Winsorize(indexData$PQS, probs = c(0.025,0.975))
indexData$winVOL <- Winsorize(indexData$VOL, probs = c(0.025,0.975))
plot(indexData$wincar, indexData$winVOL)
plot(indexData$wincar, indexData$winPQS)

indexData$year <- floor(indexData$event_date/10000)
NOBS <- ddply(indexData, .(year), function(indexData) length(indexData$wincar))
colnames(NOBS) <- c("Year", "N")
avgCar <- ddply(indexData, .(year), function(indexData) mean(indexData$wincar))
colnames(avgCar) <- c("Year", "avgCar")
OUT <- merge(NOBS, avgCar, by=c("Year"))

t.test(indexData$winPQS, mu = 0, alternative = "less") #keep H0
t.test(indexData$winVOL, mu = 0, alternative = "greater")#Reject H0

fitLiqCar <- lm(wincar~winVOL, data = indexData)
bptest(fitLiqCar) #no need for correction
fitLiqCar1 <- lm(wincar~winPQS, data = indexData)
bptest(fitLiqCar1) #no need for correction

indexData$NYSE_AMEX <- 1
indexData$NYSE_AMEX[(indexData$EXCH =="Q")] <- 0
fit1 <- lm(wincar~winPQS+NYSE_AMEX, data = indexData)
bptest(fit1)#correct for hetero
robustFit1 <- coeftest(fit1, vcov = hccm)[,2]

fit2 <- lm(wincar~winVOL+NYSE_AMEX, data = indexData)
bptest(fit2)
robustFit2 <- coeftest(fit2, vcov = hccm)[,2]

fit3 <- lm(wincar~winPQS+NYSE_AMEX+winPQS*NYSE_AMEX, data = indexData)
bptest(fit3)
robustFit3 <- coeftest(fit3, vcov = hccm)[,2]

fit4 <- lm(wincar~winVOL+NYSE_AMEX+winVOL*NYSE_AMEX, data = indexData)
bptest(fit4)
robustFit4 <- coeftest(fit4, vcov = hccm)[,2]

stargazer(list(fitLiqCar, fitLiqCar1,fit1,fit2,fit3,fit4), se= list(NULL,NULL,robustFit1,robustFit2,robustFit3,robustFit4), type = "text", keep.stat = c("n", "rsq", "adj.rsq"), out = "index_addition.txt", report = ('vc*t'))
