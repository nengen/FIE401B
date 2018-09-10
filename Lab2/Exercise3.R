#ex3
dataDebt = read.csv("~/desktop/nhh/fie401b/lab2/Debt_data.csv")
summary(dataDebt);
dataDebt$Win_MC <- Winsorize(dataDebt$MarketDebt_Capital,probs = c(0.025,0.975));
dataDebt$Win_EffTax <- Winsorize(dataDebt$EffectiveTaxRate,probs = c(0.025,0.975));
dataDebt$Win_InstHoldings <- Winsorize(dataDebt$InstitutionalHoldings,probs = c(0.025,0.975));
dataDebt$Win_EBIDTA <- Winsorize(dataDebt$EBITDA_EV,probs = c(0.025,0.975));
dataDebt$Win_NetPPE <- Winsorize(dataDebt$NetPPE_TotalAssets,probs = c(0.025,0.975));

#Perform univariate regression?


fitD <- lm(Win_MC~Win_EffTax+Win_InstHoldings+Win_EBIDTA+Win_NetPPE, data = dataDebt);
bptest(fitD); # No need o correct
vif(fitD);
