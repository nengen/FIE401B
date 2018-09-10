require(foreign);
wage <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta");

#fit the linear regression
#wage is the response vector and ecuc specifies a linear predictior for wage
#lm gives us a list containing multiple variables of the linear regression
fit <- lm(wage~educ, data = wage);
summary(fit);
#fit the multiple linear regression
fit <- lm(wage~educ+exper, data = wage);
summary(fit);
