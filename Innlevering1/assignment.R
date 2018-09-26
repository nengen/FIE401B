require(stargazer);
dataset = read.csv('~/Desktop/CAR_M&A.csv')
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
df1$avgValOfCARBidder <- tapply(dataset$carbidder, list(dataset$yyyy), mean);

#Change column names
names(df1) <- c("Year", "Number of deals", "Average value of deals", "Proportion of deal paid fully in stock", "Average value of CAR bidder");

stargazer(df1, type = "text",keep.stat=c("n","rsq","adj.rsq"));


#second table

df2 <- aggregate(list(dataset$carbidder,dataset$deal_value,dataset$private,dataset$public, dataset$bidder_size,  dataset$bidder_mtb, dataset$run_up_bidder, dataset$bidder_fcf, dataset$bidder_lev, dataset$sigma_bidder, dataset$relsize, dataset$horz, dataset$tender_offer, dataset$hostile), list(dataset$all_stock), mean)
names(df2) <- c("all_stock","carbidder", "deal_value", "private", "public", "bidder_size", "bidder_mtb", "run_up_bidder",  "bidder_fcf", "bidder_lev", "sigma_bidder", "relsize", "horz", "tender_offer", "hostile")

#subsamples
dataset1 <- dataset[which(dataset$all_stock==1),]
dataset0 <- dataset[which(dataset$all_stock==0),]

fit1 <- lm(formula = carbidder ~ bidder_size, data=dataset1)
summary(fit1)
fit10 <- lm(formula = carbidder ~ bidder_size, data=dataset0)
summary(fit10)

fit2 <- lm(formula = carbidder ~ sigma_bidder, data=dataset1)
summary(fit2)
fit20<- lm(formula = carbidder ~ sigma_bidder, data=dataset0)
summary(fit20)

fit3 <- lm(formula = carbidder ~ deal_value, data=dataset1)
summary(fit3)
fit30 <- lm(formula = carbidder ~ deal_value, data=dataset0)
summary(fit30)

fit4 <- lm(formula= carbidder ~ bidder_mtb, data=dataset1)
summary(fit4)
fit40 <- lm(formula= carbidder ~ bidder_mtb, data=dataset0)
summary(fit40)

stargazer(list(fit1,fit10,fit2,fit20,fit3,fit30,fit4,fit40), type = "text", keep.stat=c("n","rsq","adj.rsq"))



#2
#Interaction regression
fitint <- lm(carbidder~ all_stock*public, data=dataset)
summary(fitint)





