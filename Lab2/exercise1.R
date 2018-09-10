#ex1
dataCAPM <- read.csv("~/desktop/nhh/fie401b/lab2/Data_for_CAPM_test.csv", header=TRUE, sep = ",")
summary(dataCAPM);
plot(dataCAPM$ret, dataCAPM$b);

require(DescTools);
dataCAPM$Win_returns <- Winsorize(dataCAPM$ret, probs = c(0.025,0.975));
dataCAPM$Win_beta <- Winsorize(dataCAPM$b, probs = c(0.025,0.975));

fit <- lm(ret~b, data = dataCAPM);
fit1 <- lm(Win_returnsWin_beta, data = dataCAPM);
#compare winsorized and original average returns and beta
summary(fit);
summary(fit1); #lower standard error

require(lmtest);
bptest(fit); # p value = 0.0378 < 0.05    -> correct for heteroskedasiticity
coeftest(fit, vcov = hccm); #correct
bptest(fit1); #no need to correct

dataCAPM$fitted <- fitted(fit1); #use the winz data
plot(dataCAPM$fitted, dataCAPM$ret);
abline(coef = c(0,1));

stargazer(list(fit,fit1), type = "text", keep.stat = c("n", "rsq"), out = "stargazingEX.txt", report = ('vc*t'));
