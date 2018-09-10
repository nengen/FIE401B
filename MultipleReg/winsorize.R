require(DescTools);
wage$winwage <- Winsorize(wage$wage, probs = c(0.05,0.95));
wage$wineduc <- Winsorize(wage$educ, probs = c(0.05,0.95));
wage$winexper <- Winsorize(wage$exper, probs = c(0.05,0.95));
fit <- lm(winwage~wineduc+winexper, data = wage);
summary(fit);

#winsorize take the 5% on each side of the prob and sets
#it equal to the 0.05 value and 0.95 value
