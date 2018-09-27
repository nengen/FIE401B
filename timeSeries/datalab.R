require(DescTools)
require(car)
require(plm)
require(tseries)
require(dynlm)
require(timeDate)

INDUSTRY <- read.csv("49_industry_portfolios_and_risk_factors.CSV", header= TRUE, sep = ",")

#create an empty data frame in which we are going to store the coefficients and t-statistics
RESULT<-as.data.frame(matrix(NA,49,10));
colnames(RESULT)<-c("a","b","s","h","w","ta","tb","ts","th","tw");

for (i in 1:49) {
  df_i <- as.data.frame(apply(INDUSTRY[,c("WML","MktRF","SMB","HML","RF",paste("Ind",i,sep=""))],MARGIN=2,Winsorize,probs=c(0.005,0.995)));
  df_i$ExRet <- df_i[, paste("Ind",i,sep="")]-df_i$RF
  fit <- lm(ExRet~MktRF+SMB+HML+WML, data = df_i)
  
  if(bgtest(fit)$p.value <= 0.05){#test for autocorrelation
      out<-coeftest(fit,vcov=vcovHAC(fit))
  } else{
    if(bptest(fit)$p.value <= 0.05){#test for heteroskedasticity
      out <- coeftest(fit, vcov = vcovHC(fit));
    }else{
      out <- coeftest(fit);
    }
  }
  #1 is equal to the estimate, 3 is equal to t-value
  #difference in name is row names
  RESULT[i,"a"]<-out["(Intercept)",1];
  RESULT[i,"ta"]<-out["(Intercept)",3];
  RESULT[i,"b"]<-out["MktRF",1];
  RESULT[i,"tb"]<-out["MktRF",3];
  RESULT[i,"s"]<-out["SMB",1];
  RESULT[i,"ts"]<-out["SMB",3];
  RESULT[i,"h"]<-out["HML",1];
  RESULT[i,"th"]<-out["HML",3];
  RESULT[i,"w"]<-out["WML",1];
  RESULT[i,"tw"]<-out["WML",3];
  
  rm(fit,df_i,out);#remove the data that is used in iteration i
  
}

n_sig_a<-sum(abs(RESULT$ta)>=1.96) #abs just gives us the absolute value
write.csv(RESULT,file="Cahart_model.csv")


GDPDATA <- read.csv("GDP.csv", header=TRUE, sep = ",", stringsAsFactors = FALSE)
GDPDATA$date <- as.POSIXlt(as.character(GDPDATA$date), format = "%d-%m-%y") 
GDPDATA$ln <- log(GDPDATA$gdp) #calculate ln(GDP)
GDPDATA$ln <- Winsorize(GDPDATA$ln,probs = c(0.005,0.995))

timeSeriesData <- ts(GDPDATA, start = c(1962), frequency = 4)
adf.test(GDPDATA[,"ln"], k = 0) #unit root test
adf.test(diff(GDPDATA[,"ln"]), k = 0)

#estimate AR(2) 
fitGDP1 <- dynlm(d(ln)~L(d(ln)) + L(d(ln),2), data=GDPDATA, end = c(2012,4));

bgtest(fitGDP1) # check for autocorrelation
bptest(fitGDP1) #check for heteroskedasticity
coeftest(fitGDP1) # dont have to correct for anything

#estimate AR(3) 
fitGDP2 <- dynlm(d(ln)~L(d(ln)) + L(d(ln) + L(d(ln)), 3), data=GDPDATA, end = c(2012,4));

bgtest(fitGDP2) #check for autocorrelation
bptest(fitGDP2) # check for heteroskedasticity
coeftest(fitGDP2)# dont have to correct for anything

stargazer(list(fitGDP1,fitGDP2), type = "text", keep.stat = c("n", "rsq", "adj.rsq"), out = "models.txt", report = ('vc*t'))

f<-predict(fitGDP1,newdata=window(GDPDATA,start=c(2013,1)),interval="prediction")

