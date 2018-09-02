
require(foreign);
dat = read.csv("/Users/Nengen/Downloads/STATOIL.csv", header = TRUE);

#prints a summary of the data
summary(dat);

#plots a histogram of the trading volume
hist(dat$Volume);

#plots the density of trading volume
plot(density(dat$Volume));

#plots the cumulative distribution of trading volume
plot(ecdf(dat$Volume));

#make a boxplot of the open price
boxplot(dat$Open);

#cor(dat$Volume, dat$Open);
#cov(dat$Volume, dat$Open);
#summary(dat);

