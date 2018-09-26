install.packages("dplyr")
install.packages("devtools")
devtools::install_github("kassambara/ggpubr")
library("dplyr")
library("ggpubr")
require(car)
require(lmtest)
require(stargazer)
require(xtable)
dataset = read.csv('CAR_M&A.csv')
summary(dataset);
head(dataset);

#find number of deals pr year
numberOfDeals <- table(dataset$yyyy);

#save it in data frame
df1 = as.data.frame(numberOfDeals);

#Compute average value of deals and add to data frame
df1$avgDealVals <- tapply(dataset$deal_value, list(dataset$yyyy), mean);


#Compute the proportion of deals paid and add to data frame
df1$propOfDealPaidInStock <- tapply(dataset$all_stock, list(dataset$yyyy), mean);

#Compute the average value of bidders and add to data frame
df1$avgValOfBidder <- tapply(dataset$carbidder, list(dataset$yyyy), mean);

#Change column names
names(df1) <- c("Year", "Number of deals", "Average value of deals", "Proportion of deal paid fully in stock", "Average value of bidder");


print(xtable(df1), type="html", file="table1.html");#export table 1 to a html file

stargazer(df1, type = "text" );


#1.2
#second table

df2 <- aggregate(list(dataset$deal_value, dataset$carbidder, dataset$bidder_size, dataset$bidder_mtb, dataset$sigma_bidder), list(dataset$all_stock), mean)
names(df2) <- c("all_stock", "deal_value",  
                 "carbidder", "bidder_size", 
                "bidder_mtb",  "sigma_bidder");#add the names of our choosen control variable


#Interpretation 1 according to announcement
dataset1 <- dataset[which(dataset$all_stock==1),]
dataset0 <- dataset[which(dataset$all_stock==0),]

fit1 <- lm(formula = carbidder ~ bidder_size, data=dataset1)
summary(fit1)
bptest(fit1)
fit10 <- lm(formula = carbidder ~ bidder_size, data=dataset0)
summary(fit10)
bptest(fit10)



fit2 <- lm(formula = carbidder ~ sigma_bidder, data=dataset1)
summary(fit2)
bptest(fit2)
coeftest(fit2)
robust_sefit2 <- coeftest(fit2, vcov=hccm)[,2]

fit20<- lm(formula = carbidder ~ sigma_bidder, data=dataset0)
summary(fit20)
bptest(fit20)
coeftest(fit20, vcov=hccm)
robust_sefit20 <- coeftest(fit20, vcov=hccm) [,2]


fit3 <- lm(formula = carbidder ~ deal_value, data=dataset1)
summary(fit3)
bptest(fit3)

fit30 <- lm(formula = carbidder ~ deal_value, data=dataset0)
summary(fit30)
bptest(fit30)

fit4 <- lm(formula= carbidder ~ bidder_mtb, data=dataset1)
summary(fit4)
bptest(fit4)
fit40 <- lm(formula= carbidder ~ bidder_mtb, data=dataset0)
summary(fit40)
bptest(fit40)

print(xtable(df2), type="html", file="table2.html"); #Export table2 to a html file
stargazer(list(fit1, fit10, fit2, fit20, fit3, fit30, fit4, fit40), se=list(NULL, NULL, robust_sefit2, robust_sefit20, NULL, NULL, NULL, NULL), type="text", out="table2reg.html", keep.stat=c("n", "rsq", "adj.rsq"))


#Interpretation 2 according to assignment
t.test(dataset1$carbidder, dataset0$carbidder)
t.test(dataset1$bidder_size, dataset0$bidder_size)
t.test(dataset1$sigma_bidder, dataset0$sigma_bidder)
t.test(dataset1$deal_value, dataset0$deal_value)
t.test(dataset1$bidder_mtb, dataset0$bidder_mtb)

# Task 2
require(lmtest)
require(car)
publicdataset <- dataset[which(dataset$public==1),]
fittask2 <- lm(carbidder ~ all_stock, data=publicdataset)
summary(fittask2)
bptest(fittask2)
coeftest(fittask2, vcov=hccm)
robust_se2 <- coeftest(fittask2, vcov=hccm) [,2]

fittask2m <- lm(carbidder~all_stock+bidder_size+deal_value+bidder_mtb+sigma_bidder, data=publicdataset)
summary(fittask2m)
bptest(fittask2m)
coeftest(fittask2m, vcov=hccm)
robust_se2m <- coeftest(fittask2m, vcov=hccm)[,2]
vif(fittask2m)
stargazer(list(fittask2, fittask2m), se=list(robust_se2, robust_se2m), type="text", keep.stat=c("n", "rsq","adj.rsq"))


#Interaction regression
fitint <- lm(carbidder~ all_stock*public, data=dataset)
summary(fitint)
bptest(fitint)
coeftest(fitint, vcov=hccm)
robust_seint <- coeftest(fitint, vcov=hccm)[,2]

fitintm <- lm(carbidder~all_stock*public+bidder_size+deal_value+bidder_mtb+sigma_bidder, data=dataset)
summary(fitintm)
bptest(fitintm)
coeftest(fitint, vcov=hccm)
robust_seintm <- coeftest(fitintm, vcov=hccm)[,2]
vif(fitintm)
stargazer(list(fitint, fitintm), se=list(robust_seint, robust_seintm), type="text", keep.stat=c("n", "rsq", "adj.rsq"))
