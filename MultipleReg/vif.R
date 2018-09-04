require(car);
fit <- lm(wage~educ+exper, data = wage)
vif(fit);

