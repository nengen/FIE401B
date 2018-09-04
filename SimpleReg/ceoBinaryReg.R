require(foreign);
ceo <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta");

#calculate roemedia
roemedian <- median(ceo$roe);
#make a new variable
ceo$dummyroe <- 0;
#if roe is bigger than roemedian set it to 1, this is binary regression
ceo$dummyroe[(ceo$roe > roemedian)] <- 1;

#fit the linear regression
fit <- lm(salary~dummyroe, data = ceo);

summary(fit);
