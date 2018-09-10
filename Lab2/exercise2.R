#ex2
dataCahart = read.csv("~/desktop/nhh/fie401b/lab2/Data_for_Cahart_test.csv")

summary(dataCahart);
dataCahart$Win_ret <- Winsorize(dataCahart$ret,probs = c(0.025,0.975));
dataCahart$Win_b <- Winsorize(dataCahart$b,probs = c(0.025,0.975));
dataCahart$Win_s <- Winsorize(dataCahart$s,probs = c(0.025,0.975));
dataCahart$Win_h <- Winsorize(dataCahart$h,probs = c(0.025,0.975));
dataCahart$Win_w <- Winsorize(dataCahart$w,probs = c(0.025,0.975));

#regressing average returns on factor loadings
fitC <- lm(Win_ret~Win_b+Win_s+Win_h+Win_w, data = dataCahart);
bptest(fitC); #test for heteroskedasticity -> no need to correct
vif(fitC); # all values are less than 2 -> no need to correct

dataCahart$fitted <- fitted(fitC);
plot(dataCahart$fitted, dataCahart$Win_ret);
abline(0,1);

stargazer(list(fit1, fitC), type = "text", keep.stat = c("n", "rsq"), out = "stargazingEX.txt", report = ('vc*t'));
linearHypothesis(fit1,fitC); #FIX : NOT WORKING
