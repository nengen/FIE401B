require(car);
fit <- lm(wage~educ+exper, data = wage)
# VIF indicates how much larger the standard error is,
# compared with what it would be if the variables 
# were uncorrelated
vif(fit);

