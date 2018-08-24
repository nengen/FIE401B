require(foreign);
myData <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/affairs.dta");
new <- myData [myData$age>=32,];
head(myData);
str(myData);
colMeans(myData);
summary(myData);
quantile(myData$age,0.75);
save(myData,file="wood.RData");
