require(car);
fit <- lm(wage~educ+exper, data = wage);
coeftest(fit); #homoskedasticity only
coeftest(fit, vcov = hccm); #robust to heteroskedasticity
# vcov = hccm fits a heteroskedasticity corrected matrice into
#the coeftest

# vcov gives a specification of the covariance matrix of the
# estimated coefficients
