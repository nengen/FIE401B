#Exercise9
a<-rbinom(100,1000,0.01)
b<-rbinom(100,1000,0.5)
head(a)

ybar<-mean(a)
n<-length(a)
s<-sd(a)
se<-s/sqrt(n)
tscore<-qt(0.975,n-1)
CI<-c(ybar-tscore*se,ybar+tscore*se)
CI
sp<-sd(b)

t<-(ybar-500)/sp
p<-pt(t, n-1)
p
