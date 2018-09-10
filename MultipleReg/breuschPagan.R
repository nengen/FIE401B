require(lmtest);
fit <- lm(wage~educ+exper, data = wage);

# Breusch Pagan test -> testing for heteroskedasticity
# H0 = homoskedasticity
bptest(fit);
#here p-value is less than 0.01 so we reject h0
#implies we have a violation of homoskedasticity