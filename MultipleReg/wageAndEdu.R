require(foreign);
wage <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta");

#fit the linear regression
fit <- lm(wage~educ, data = wage);
summary(fit);
#fit the multiple linear regression
fit <- lm(wage~educ+exper, data = wage);
summary(fit);
