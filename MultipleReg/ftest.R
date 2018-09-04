require(car);
fit <- lm(wage~educ+exper,data=wage);
myH0 <- c("educ=0","exper=0");
linearHypothesis(fit,myH0); # homoskedasticity case
linearHypothesis(fit,myH0,vcov=hccm); # heteroskedasticity case
