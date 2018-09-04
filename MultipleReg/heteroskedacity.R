require(car);
fit <- (wage~educ+exper, data = wage);
coeftest(fit, vcov = hccm); #robust to heteroskedasticity
