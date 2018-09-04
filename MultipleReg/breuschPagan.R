require(lmtest);
fit <- (wage~educ+exper, data = wage);
bptest(fit);
